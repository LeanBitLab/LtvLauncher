# LTvLauncher

<picture>
  <source media="(prefers-color-scheme: dark)" srcset=".github/assets/banner_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset=".github/assets/banner_light.svg">
  <img alt="LTvLauncher Banner" src=".github/assets/banner_light.svg">
</picture>

[![Version](https://raw.githubusercontent.com/leanbitlab-org/LtvLauncher/master/.github/badges/version.svg)](https://github.com/leanbitlab-org/LtvLauncher/releases/latest) [![Downloads](https://raw.githubusercontent.com/leanbitlab-org/LtvLauncher/master/.github/badges/downloads.svg)](https://github.com/leanbitlab-org/LtvLauncher/releases) [![Stars](https://raw.githubusercontent.com/leanbitlab-org/LtvLauncher/master/.github/badges/stars.svg)](https://github.com/leanbitlab-org/LtvLauncher/stargazers)



**LTvLauncher** is a fork of [FLauncher](https://github.com/osrosal/flauncher) (originally by [etienn01](https://gitlab.com/flauncher/flauncher)) - an open-source alternative launcher for Android TV.

This customized version introduces usability enhancements and some UX improvements by [LeanBitLab](https://github.com/leanbitlab-org).

<a href="https://github.com/leanbitlab-org/LtvLauncher/releases/latest">
  <img alt="Get it on GitHub" src=".github/assets/get_it_on_github.png" height="65">
</a>
<a href="https://apt.izzysoft.de/fdroid/index/apk/com.leanbitlab.ltvL">
  <img alt="Get it on IzzyOnDroid" src=".github/assets/IzzyOnDroid.png" height="65">
</a>
<a href="https://go.aftvnews.com">
  <img alt="Downloader Code: 7259827" src=".github/assets/get_it_on_downloader.png" height="65">
</a>
<a href="https://github.com/leanbitlab-org/LtvLauncher/releases">
  <img alt="Pre-release" src=".github/badges/prerelease.png" height="65">
</a>




## Screenshots

<table>
  <tr>
    <td align="center">Home Screen</td>
    <td align="center">Settings 1</td>
    <td align="center">Settings 2</td>
    <td align="center">Settings 3</td>
    <td align="center">Screensaver</td>
  </tr>
  <tr>
    <td><img src="docs/images/screenshot_1.png" width="100%" alt="Home Screen"/></td>
    <td><img src="docs/images/screenshot_2.png" width="100%" alt="Settings 1"/></td>
    <td><img src="docs/images/screenshot_3.png" width="100%" alt="Settings 2"/></td>
    <td><img src="docs/images/screenshot_4.png" width="100%" alt="Settings 3"/></td>
    <td><img src="docs/images/screensaver.gif" width="100%" alt="Screensaver"/></td>
  </tr>
</table>


## Key Features & Enhancements

- **Multiple Backups & Restore Dialog** - Export backups with unique timestamps and restore them via a D-pad friendly in-app backup selection dialog.
- **System-wide Notification Overlays** - Display notification alerts globally over other apps.
- **Status Bar Inputs Toggle** - Easily toggle the visibility of the inputs widget in the status bar.
- **TV Input Selector** - Directly switch between input sources (HDMI, AV, etc.) from the launcher.
- **Accessibility Settings Page** - Manage launcher-specific accessibility settings.
- **Data Usage Widget** - Track daily Internet consumption (WiFi, Ethernet, Mobile) directly from the status bar.
- **Inbuilt OLED Screensaver** - Minimal screensaver with 30s clock position shifting to prevent burn-in.
- **Easy WiFi Access** - Network indicator doubles as a shortcut to system WiFi settings.
- **Quick Presets** - Select Time/Date formats and Category names from a list (No keyboard required).
- **Time-Based Wallpaper** - Automatically switch between day and night backgrounds.
- **Pitch Black Wallpaper** - Added a true black gradient background option.
- **Enhanced Focus Indicator** - New double-border design ensures perfect visibility on any background.
- **Smart Navigation** - Fixed "bounce back" issues and optimized focus traversal for a smoother experience.
- **Refined Settings** - Reorganized menus with a new "Miscellaneous" section and unified focus styles.
- **Accent Color Support** - Personalize the UI with multiple color presets.
- **Themes** - Switch between distinct visual styles (Default, Premium, Classic, Capsule).
- **Focus Customization** - Toggle focus outline and transition animations to tailor your experience.
- **Edge Bump Animation** - Visual feedback when reaching the edge of a row, preventing accidental focus wrapping.
- **Improved Sorting** - Easily reorder categories using Left/Right arrow keys instead of finicky gestures.
- **Left Side Settings** - Reorganized settings panel now opens on the left for better reach.
- **Brightness Scheduler (Experimental)** - Automatically adjust system brightness based on time of day (Requires `WRITE_SETTINGS` permission via ADB).
- **New Category** - Added "Favorites".
- **Custom Banner Support** - Display and apply your own personalized custom banners.
- **Optimizations** - Improved performance with aggressive icon caching and code cleanups.

> [!WARNING]
> **Brightness Scheduler is an experimental feature.** It is currently untested across all devices and may be removed or modified in future versions based on user feedback.

## Original FLauncher Features

- [x] No ads
- [x] Customizable categories
- [x] Manually reorder apps within categories
- [x] Wallpaper support
- [x] Open "Android Settings"
- [x] Open "App info"
- [x] Uninstall app
- [x] Clock
- [x] Switch between row and grid for categories
- [x] Support for non-TV (sideloaded) apps
- [x] Navigation sound feedback
- [x] Official support for `armeabi-v7a`, `arm64-v8a`, and `x86_64` devices.


## Set LTvLauncher as default launcher

### Method 1: Via Built-in Settings (Recommended)
This is the easiest and native way. Go to **Settings -> Accessibility -> Set as default launcher**. This will open the system home picker or default apps settings directly where you can select **LTvLauncher** as your default home app.

On Google TV this does not take effect, and no picker or `adb shell cmd package set-home-activity` can make it. The stock launcher (`com.google.android.apps.tv.launcherx`) declares its HOME intent filter with priority 2 (its recovery activity uses 1). Android resolves the Home intent by priority first and only consults the preferred activity / HOME role when the top candidates tie, and non-system apps cannot declare a priority above 0. The picker records LTvLauncher as the home app and the system keeps launching Google TV. Use Method 2. To confirm on a device:

```shell
$ adb shell dumpsys package -f resolvers activity | grep -B4 -A4 'category.HOME' | grep -E 'com\.|mPriority'
$ adb shell dumpsys role | grep -A1 android.app.role.HOME   # shows LTvLauncher as the holder, which is ignored
```

### Method 2: Home Button Fix (Google TV / Fire TV)
If your device blocks changing the default launcher (common on Google TV and newer Fire TV updates), you can use our built-in Home Button Fix:
1. Open **Settings -> Accessibility**.
2. Tap **Home Button Fix (Google TV)**.
3. Turn on the accessibility service for **LTvLauncher** in the system settings.
Once enabled, the launcher will intercept Home button presses to automatically return to **LTvLauncher**.

### Method 3: Remap the Home button
This is another fallback if the built-in options don't suit your setup. Use [Key Mapper](https://github.com/keymapperorg/KeyMapper) to remap the Home button of the remote to launch LTvLauncher.

### Method 4: Disable the default launcher via ADB
**:warning: Disclaimer :warning:**

**You are doing this at your own risk, and you'll be responsible in any case of malfunction on your device.**

The following commands have been tested on Chromecast with Google TV only. This may be different on other devices.

Once the default launcher is disabled, press the Home button on the remote, and you'll be prompted by the system to choose which app to set as default.

#### Disable default launcher
```shell
# Disable com.google.android.apps.tv.launcherx which is the default launcher on CCwGTV
$ adb shell pm disable-user --user 0 com.google.android.apps.tv.launcherx
# com.google.android.tungsten.setupwraith will then be used as a 'fallback' and will automatically
# re-enable the default launcher, so disable it as well
$ adb shell pm disable-user --user 0 com.google.android.tungsten.setupwraith
```

#### Re-enable default launcher
```shell
$ adb shell pm enable com.google.android.apps.tv.launcherx
$ adb shell pm enable com.google.android.tungsten.setupwraith
```

#### Known issues
On Chromecast with Google TV (maybe others), the "YouTube" remote button will stop working if the default launcher is disabled. As a workaround, you can use [key Mapper](https://github.com/keymapperorg/KeyMapper) to remap it correctly.

## Wallpaper
Because Android's `WallpaperManager` is not available on some Android TV devices, FLauncher implements its own wallpaper management method.

Please note that changing wallpaper requires a file explorer to be installed on the device in order to pick a file.

## Credits

### Original Projects
- **[FLauncher](https://gitlab.com/flauncher/flauncher)** by [etienn01](https://github.com/etienn01) - The original project
- **[FLauncher (Fork)](https://github.com/osrosal/flauncher)** by [osrosal](https://github.com/osrosal) - The base for this fork

---

### LTvLauncher
- Customizations by [LeanBitLab](https://github.com/leanbitlab-org)

---

## 🛡️ LeanBitLab Ecosystem

Check out our other projects: 👉 [LeanBitLab Projects](https://github.com/leanbitlab-org)
