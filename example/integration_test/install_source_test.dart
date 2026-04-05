import 'dart:io';
import 'dart:math';

import 'package:android_package_manager/android_package_manager.dart';
import 'package:android_package_manager_example/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

int _androidSdkInt() {
  final match = RegExp(r'\(SDK\s+(\d+)\)').firstMatch(Platform.operatingSystemVersion);
  return int.tryParse(match?.group(1) ?? '') ?? 30;
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final pm = AndroidPackageManager();
  group(
    'Install Source and Installer Package Name (Deprecated) tests',
    () {
      test(
        'Install Source Info Test',
        () async {
          expect(Platform.isAndroid, true,);
          final sdkInt = _androidSdkInt();
          expect(sdkInt >= 30, true,);
          final random = Random();
          final packages = await pm.getInstalledPackages();
          expect(packages?.isNotEmpty ?? false, true,);
          final package = packages![random.nextInt(packages.length,)];
          debugPrint('Package: ${package.packageName}',);
          final installSourceInfo = await pm.getInstallSourceInfo(
            packageName: package.packageName!,
          );
          debugPrint(
            'Install Source Info:'
              '\noriginatingPackageName: ${installSourceInfo?.originatingPackageName}'
              '\ninstallingPackageName: ${installSourceInfo?.installingPackageName}'
              '\ninitiatingPackageName: ${installSourceInfo?.initiatingPackageName}',
          );
          expect(installSourceInfo != null, true,);
        },
      );

      test(
        'Installer Package Name Test',
        () async {
          expect(Platform.isAndroid, true,);
          final sdkInt = _androidSdkInt();
          if (sdkInt >= 30) {
            debugPrint('WARNING: Running deprecated method',);
          }
          final random = Random();
          final packages = await pm.getInstalledPackages();
          expect(packages?.isNotEmpty ?? false, true,);
          final package = packages![random.nextInt(packages.length,)];
          debugPrint('Package: ${package.packageName}',);
          final ipn = await pm.getInstallerPackageName(
            packageName: package.packageName!,
          );
          debugPrint('Installer Package Name: $ipn',);
        },
      );
    },
  );
}
