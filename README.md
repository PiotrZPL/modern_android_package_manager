# modern_android_package_manager

Provides access to Android's native `PackageManager` API to fetch various information, such as installed applications, packages, permissions, and more.

## About this Package
This plugin is intended for Android use only. It provides easier access to commonly used methods of Android's [PackageManager](https://developer.android.com/reference/android/content/pm/PackageManager) API.

This project is a continuation of the original [`android_package_manager`](https://github.com/nsNeruno/android_package_manager) package created by [nsNeruno](https://github.com/nsNeruno). The original package filled an important gap for Flutter developers who needed direct access to Android package information from Dart code.

## Project History
`modern_android_package_manager` exists as a maintained continuation of the original `android_package_manager` project.

The original repository appears to have been inactive for a long time, while the package is still useful and relevant for Android and Flutter developers. This fork was created to:

- keep the package alive and compatible with newer Android and Flutter versions,
- review and merge pending fixes and improvements,
- improve documentation and long-term maintainability,
- continue development in a standalone repository.

This project would not exist without the work done in the original repository, and this fork aims to preserve that work while moving it forward.

## Why this Fork Exists
The goal of this fork is not to replace the original author's work, but to provide a modern, actively maintained continuation for users who still rely on this package.

Main reasons for this fork:

- the original repository has not been maintained for an extended period,
- Android APIs continue to evolve and require updates for compatibility,
- developers need a reliable package with ongoing fixes and documentation improvements,
- a standalone repository ensures the project can continue independently.

## Getting Started

Importing:

```dart
import 'package:modern_android_package_manager/modern_android_package_manager.dart';
```

Singleton access example:

```dart
final pm = AndroidPackageManager();
```

## Available Methods

Please see the official documentation of the [PackageManager](https://developer.android.com/reference/android/content/pm/PackageManager) API.

**Disclaimer**: This package aims to expose many of the available `PackageManager` methods in a Flutter-friendly way. Some methods have been covered with simple instrumentation tests.

Tested methods can be found under the `example/integration_test` directory.

The example Flutter app demonstrates the [`getInstalledPackages`](https://developer.android.com/reference/android/content/pm/PackageManager#getInstalledPackages%28int%29) method.

## Side Notes

Please take note of the optional `flags` argument on some methods. These flags affect the output returned by the Android APIs. For example, `PackageInfo` will not include permission information unless the `GET_PERMISSIONS` flag is specified.

## Optional Permissions

By default, the list of installed apps is limited on Android 11 (API level 30) and higher. Read more about it [here](https://developer.android.com/training/package-visibility).

To access the full list of apps installed on a device, add the following permission to your `AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" />
```

## TO-DOs
- Proper documentation
- DartDocs
- Adjusting some methods to be Android Tiramisu compatible (deprecating some methods)
- Documenting bitmask values
- Separating interfaces into a separate package (maybe)

## Issues
Feel free to file issues or any suggestions [here](https://github.com/PiotrZPL/modern_android_package_manager/issues)