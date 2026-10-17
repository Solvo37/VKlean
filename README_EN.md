# VK Video Patched (VKlean)

[![Add to Obtainium](https://img.shields.io/badge/Obtainium-Add-7c4dff?logo=android&logoColor=white)](https://apps.obtainium.imranr.dev/redirect?r=obtainium%3A%2F%2Fapp%2F%257B%2522id%2522%253A%2522com.vk.vkvideo%2522%252C%2522url%2522%253A%2522https%253A%252F%252Fgithub.com%252FSolvo37%252FVKlean%2522%252C%2522author%2522%253A%2522Solvo37%2522%252C%2522name%2522%253A%2522VK%2520Video%2520Patched%2522%252C%2522installedVersion%2522%253Anull%252C%2522latestVersion%2522%253A%25221.166.1%2522%252C%2522apkUrls%2522%253A%2522%255B%255B%255C%2522VK-Video-1.166.1-patched.apk%255C%2522%252C%255C%2522https%253A%252F%252Fgithub.com%252FSolvo37%252FVKlean%252Freleases%252Fdownload%252F1.166.1%252FVK-Video-1.166.1-patched.apk%255C%2522%255D%255D%2522%252C%2522preferredApkIndex%2522%253A0%252C%2522additionalSettings%2522%253A%2522%257B%255C%2522includePrereleases%255C%2522%253Afalse%252C%255C%2522fallbackToOlderReleases%255C%2522%253Afalse%252C%255C%2522filterReleaseTitlesByRegEx%255C%2522%253A%255C%2522%255C%2522%252C%255C%2522filterReleaseNotesByRegEx%255C%2522%253A%255C%2522%255C%2522%252C%255C%2522verifyLatestTag%255C%2522%253Atrue%252C%255C%2522sortMethodChoice%255C%2522%253A%255C%2522date%255C%2522%252C%255C%2522useLatestAssetDateAsReleaseDate%255C%2522%253Afalse%252C%255C%2522releaseTitleAsVersion%255C%2522%253Afalse%252C%255C%2522trackOnly%255C%2522%253Afalse%252C%255C%2522versionExtractionRegEx%255C%2522%253A%255C%2522%255C%2522%252C%255C%2522matchGroupToUse%255C%2522%253A%255C%2522%255C%2522%252C%255C%2522versionDetection%255C%2522%253Afalse%252C%255C%2522releaseDateAsVersion%255C%2522%253Afalse%252C%255C%2522useVersionCodeAsOSVersion%255C%2522%253Afalse%252C%255C%2522apkFilterRegEx%255C%2522%253A%255C%2522%255EVK-Video-.*-patched%255C%255C%255C%255C.apk%2524%255C%2522%252C%255C%2522invertAPKFilter%255C%2522%253Afalse%252C%255C%2522autoApkFilterByArch%255C%2522%253Afalse%252C%255C%2522appName%255C%2522%253A%255C%2522VK%2520Video%2520Patched%255C%2522%252C%255C%2522appAuthor%255C%2522%253A%255C%2522Solvo37%255C%2522%252C%255C%2522shizukuPretendToBeGooglePlay%255C%2522%253Afalse%252C%255C%2522allowInsecure%255C%2522%253Afalse%252C%255C%2522exemptFromBackgroundUpdates%255C%2522%253Afalse%252C%255C%2522skipUpdateNotifications%255C%2522%253Afalse%252C%255C%2522about%255C%2522%253A%255C%2522VK%2520Video%2520patched%2520builds%2520by%2520Solvo37%255C%2522%252C%255C%2522refreshBeforeDownload%255C%2522%253Atrue%257D%2522%252C%2522overrideSource%2522%253Anull%252C%2522allowIdChange%2522%253Afalse%252C%2522releaseUrl%2522%253A%2522https%253A%252F%252Fgithub.com%252FSolvo37%252FVKlean%252Freleases%252Ftag%252F1.166.1%2522%257D)

Open-source Morphe patches and signed ARM64 builds of VK Video with selected advertisements removed. Installs alongside the regular VK app.

## Current stable release — 1.166.1

- **Android VK Video:** `1.166`, RuStore `versionCode 53253`.
- **APK:** [VK-Video-1.166.1-patched.apk](https://github.com/Solvo37/VKlean/releases/download/1.166.1/VK-Video-1.166.1-patched.apk).
- **Morphe patch bundle:** [patches-1.166.1.mpp](https://github.com/Solvo37/VKlean/releases/download/1.166.1/patches-1.166.1.mpp).
- [GitHub Release 1.166.1](https://github.com/Solvo37/VKlean/releases/tag/1.166.1).

Fixed the dedicated VK Clips tab black screen caused by a stale obfuscated class reference. Physical-device testing on Galaxy S24 Ultra covered Clips, normal videos and seeking, Home, Profile, background/foreground and restart; no ads were observed during the test.

Former release `1.166.0` remains a **pre-release** and should not be installed. Only the physically verified `1.166 / 53253` upstream is approved for production; other upstream versionCodes remain blocked pending tests.

## Install and updates

1. For initial installation, uninstall only the official **VK Video** (`com.vk.vkvideo`). Keep the standard VK app installed.
2. Install the signed APK from Releases. Future VKlean APKs retain the same project signing key.
3. Optionally import the project into [Obtainium](https://github.com/ImranR98/Obtainium). Use repository URL `https://github.com/Solvo37/VKlean` and APK filter `^VK-Video-.*-patched\.apk$`.

The automated builder checks RuStore and APKPure for newer upstream APKs and uses compatibility checks. A green static build alone does not prove the app works correctly when logged in.

## Morphe patch source

- [Add VKlean to Morphe Android](https://morphe.software/add-source?github=Solvo37/VKlean)
- [Current patch manifest](https://raw.githubusercontent.com/Solvo37/VKlean/main/patches-bundle.json)
- [Patch list](./patches-list.json)

## Troubleshooting

- [Clips tab black screen: ADB log capture and non-release comparison builds](./docs/CLIPS_DIAGNOSTICS.md)
- [Installation details (Russian)](./docs/INSTALL.md)
- [Changes](./CHANGELOG.md)

VKlean is not affiliated with VK, VK Video, Morphe or Obtainium. GPL-3.0 licensed.
