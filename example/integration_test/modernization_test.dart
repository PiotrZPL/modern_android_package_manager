import 'package:android_package_manager/android_package_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const examplePackageName = 'lab.neruno.android_package_manager_example';
  final pm = AndroidPackageManager();

  group(
    'Modernized API tests',
    () {
      test(
        'getPackageUid and getTargetSdkVersion return values for the example app',
        () async {
          final uid = await pm.getPackageUid(
            packageName: examplePackageName,
          );
          final targetSdk = await pm.getTargetSdkVersion(
            packageName: examplePackageName,
          );

          expect(uid, isNotNull);
          expect(uid, greaterThan(0));
          expect(targetSdk, isNotNull);
          expect(targetSdk, greaterThanOrEqualTo(21));
        },
      );

      test(
        'getText and getDrawable read app resources',
        () async {
          final packageInfo = await pm.getPackageInfo(
            packageName: examplePackageName,
          );
          final applicationInfo = packageInfo?.applicationInfo;

          expect(applicationInfo, isNotNull);
          expect(applicationInfo?.labelRes, isNotNull);
          expect(applicationInfo?.icon, isNotNull);

          final label = await pm.getText(
            packageName: examplePackageName,
            resourceId: applicationInfo!.labelRes!,
          );
          final appLabel = await pm.getApplicationLabel(
            packageName: examplePackageName,
          );
          final drawable = await pm.getDrawable(
            packageName: examplePackageName,
            resourceId: applicationInfo.icon!,
          );

          expect(label, appLabel);
          expect(drawable, isNotNull);
          expect(drawable, isNotEmpty);
        },
      );

      test(
        'permission group and permission queries return Android metadata',
        () async {
          const groupName = 'android.permission-group.CALENDAR';

          final permissionGroup = await pm.getPermissionGroupInfo(
            groupName,
          );
          final permissions = await pm.queryPermissionsByGroup(
            groupName,
          );
          final cameraPermission = await pm.getPermissionInfo(
            'android.permission.CAMERA',
          );

          expect(permissionGroup?.name, groupName);
          expect(permissions, isNotNull);
          expect(
            permissions?.every(
                  (permission) => permission.group == groupName,
                ) ??
                false,
            isTrue,
          );
          expect(cameraPermission?.name, 'android.permission.CAMERA');
        },
      );

      test(
        'signing certificate checks work for the example app',
        () async {
          final packageInfo = await pm.getPackageInfo(
            packageName: examplePackageName,
            flags: PackageInfoFlags(
              {
                PMFlag.getSigningCertificates,
              },
            ),
          );
          final certificateBytes =
              packageInfo?.signingInfo?.apkContentSigners?.first;
          final uid = await pm.getPackageUid(
            packageName: examplePackageName,
          );

          expect(certificateBytes, isNotNull);
          expect(uid, isNotNull);

          final packageCheck = await pm.hasSigningCertificate(
            packageName: examplePackageName,
            certificateBytes: certificateBytes!,
          );
          final uidCheck = await pm.hasSigningCertificateByUid(
            uid: uid!,
            certificateBytes: certificateBytes,
          );

          expect(packageCheck, isTrue);
          expect(uidCheck, isTrue);
        },
      );
    },
  );
}
