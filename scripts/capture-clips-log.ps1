# Capture VK Clips-tab diagnostics locally; never uploads logs.
[CmdletBinding()]
param(
    [string]$AdbPath = '',
    [string]$Serial = '',
    [string]$OutputDir = (Join-Path $env:USERPROFILE 'Desktop\VKlean-Clips-Logs')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$packageName = 'com.vk.vkvideo'

if (-not $AdbPath) {
    $adbCommand = Get-Command 'adb' -ErrorAction SilentlyContinue
    if ($adbCommand) {
        $AdbPath = $adbCommand.Source
    } elseif (Test-Path 'C:\AndroidLab\Sdk\platform-tools\adb.exe') {
        $AdbPath = 'C:\AndroidLab\Sdk\platform-tools\adb.exe'
    } else {
        throw 'ADB not found. Install Android platform-tools or pass -AdbPath C:\path\to\adb.exe.'
    }
}

& $AdbPath start-server | Out-Null
if ($LASTEXITCODE -ne 0) { throw 'Cannot start adb server.' }

if (-not $Serial) {
    $connected = @(& $AdbPath devices | ForEach-Object {
        if ($_ -match '^(\S+)\s+device(?:\s|$)') { $Matches[1] }
    })
    if ($connected.Count -ne 1) {
        throw ('Connect and authorize exactly one Android device, or specify -Serial. Detected: ' + ($connected -join ', '))
    }
    $Serial = $connected[0]
}

$apkPaths = @(& $AdbPath -s $Serial shell pm path $packageName)
if ($LASTEXITCODE -ne 0 -or -not ($apkPaths | Where-Object { $_ -match '^package:' })) {
    throw "VK Video ($packageName) is not installed on $Serial."
}

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$runDir = Join-Path $OutputDir "clips-$stamp"
New-Item -ItemType Directory -Path $runDir -Force | Out-Null
$rawPath = Join-Path $runDir 'logcat-private.txt'
$sharePath = Join-Path $runDir 'clips-filtered-review-before-sharing.txt'
$appInfoPath = Join-Path $runDir 'app-version.txt'

@(& $AdbPath -s $Serial shell dumpsys package $packageName) |
    Select-String -Pattern '^\s*(versionName|versionCode|targetSdk|firstInstallTime|lastUpdateTime)=' |
    Set-Content -Path $appInfoPath -Encoding UTF8

& $AdbPath -s $Serial logcat -c -b main -b system -b crash
if ($LASTEXITCODE -ne 0) { throw 'Could not clear logcat buffers.' }

Write-Host 'Open VK Video, tap the dedicated Clips button, and wait for the black screen.' -ForegroundColor Yellow
[void](Read-Host 'Then press Enter here to capture the log')

& $AdbPath -s $Serial logcat -d -v threadtime -b main -b system -b crash |
    Out-File -FilePath $rawPath -Encoding UTF8
if ($LASTEXITCODE -ne 0) { throw 'Could not capture logcat.' }

$pattern = '(?i)(AndroidRuntime|FATAL EXCEPTION|Fatal signal|vkvideo|vk\.video|vk\.clips|clip|shortvideo|Instream|MediaCodec|ExoPlayer|ActivityTaskManager|ActivityManager|am_crash|am_anr|ANR|NetworkSecurity|SSLHandshake|UnknownHost|IllegalStateException|NullPointerException|IndexOutOfBoundsException)'
$hits = @(Select-String -Path $rawPath -Pattern $pattern -Context 4,8)
$filtered = foreach ($hit in $hits) {
    $block = @($hit.Context.PreContext) + @($hit.Line) + @($hit.Context.PostContext)
    foreach ($line in $block) {
        $line = $line -replace '(?i)https?://\S+', '[URL]'
        $line = $line -replace '(?i)(access[_-]?token|refresh[_-]?token|session[_-]?id|authorization|device[_-]?id|user[_-]?id)\s*[:=]\s*[^,\s&]+', '$1=[REDACTED]'
        $line = $line -replace '(?i)Bearer\s+[A-Za-z0-9._~+-]+', 'Bearer [REDACTED]'
        $line
    }
    '---'
}
$filtered | Set-Content -Path $sharePath -Encoding UTF8

Write-Host "Raw private log: $rawPath"
Write-Host "Filtered log:    $sharePath" -ForegroundColor Green
Write-Host "App version:     $appInfoPath"
Write-Host 'Review the filtered log for personal data before sending it. Never post the raw log publicly.' -ForegroundColor Yellow
