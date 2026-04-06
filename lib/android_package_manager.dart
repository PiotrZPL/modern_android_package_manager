library android_package_manager;

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

import 'src/entities/entities.dart';
import 'src/entities/entities_impl.dart';
import 'src/entities/enums.dart';

export 'src/entities/entities.dart';
export 'src/entities/enums.dart';

part 'src/android_package_manager_impl.dart';

abstract class AndroidPackageManager {
  const AndroidPackageManager._();

  static const AndroidPackageManager _pm = AndroidPackageManagerImpl();

  factory AndroidPackageManager() {
    if (!Platform.isAndroid) {
      throw StateError(
        "Can only be run on Android devices",
      );
    }
    return _pm;
  }

  Future<bool> canPackageQuery({
    required String sourcePackageName,
    required String targetPackageName,
  }) =>
      throw UnimplementedError();

  Future<List<String>?> canonicalToCurrentPackageNames({
    required List<String> packageNames,
  }) =>
      throw UnimplementedError();

  Future<CheckPermissionStatus?> checkPermission({
    required String packageName,
    required String permName,
  }) =>
      throw UnimplementedError();

  Future<SignatureCheckResult> checkSignatures({
    required String packageName1,
    required String packageName2,
  }) =>
      throw UnimplementedError();

  Future<List<String>?> currentToCanonicalPackageNames({
    required List<String> packageNames,
  }) =>
      throw UnimplementedError();

  Future<Uint8List?> getActivityDrawableResource({
    required ComponentName componentName,
    required ActivityResourceType type,
    BitmapCompressFormat format = BitmapCompressFormat.png,
    int quality = 100,
  }) =>
      throw UnimplementedError();

  Future<List<PermissionGroupInfo>?> getAllPermissionGroups({
    PermissionGroupInfoFlags? flags,
  });

  Future<String?> getBackgroundPermissionOptionLabel() =>
      throw UnimplementedError();

  Future<bool?> getApplicationEnabledSetting({
    required String packageName,
  });

  Future<Uint8List?> getApplicationIcon({
    required String packageName,
    BitmapCompressFormat format = BitmapCompressFormat.png,
    int quality = 100,
  });

  Future<String?> getApplicationLabel({
    required String packageName,
    ApplicationInfoFlags? flags,
  });

  Future<Uint8List?> getActivityIcon({
    required String packageName,
    BitmapCompressFormat format = BitmapCompressFormat.png,
    int quality = 100,
  });

  Future<Uint8List?> getActivityLogo({
    required String packageName,
    BitmapCompressFormat format = BitmapCompressFormat.png,
    int quality = 100,
  });

  Future<ChangedPackages?> getChangedPackages({
    required int sequenceNumber,
  }) =>
      throw UnimplementedError();

  Future<bool?> getComponentEnabledSetting({
    required String packageName,
  });

  Future<Uint8List?> getDefaultActivityIcon();

  Future<Uint8List?> getDrawable({
    required String packageName,
    required int resourceId,
    BitmapCompressFormat format = BitmapCompressFormat.png,
    int quality = 100,
  }) =>
      throw UnimplementedError();

  /// Available for SDK Int >= 30 (Android R)
  Future<InstallSourceInfo?> getInstallSourceInfo({
    required String packageName,
  });

  Future<List<ApplicationInfo>?> getInstalledApplications({
    ApplicationInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<List<ModuleInfo>?> getInstalledModules({
    InstalledModulesFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<List<PackageInfo>?> getInstalledPackages({
    PackageInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  /// Uses InstallSourceInfo on Android 30+ and falls back to the legacy API on older versions.
  Future<String?> getInstallerPackageName({
    required String packageName,
  });

  Future<InstrumentationInfo?> getInstrumentationInfo({
    required ComponentName componentName,
    InstrumentationInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<List<String>?> getMimeGroup(
    String mimeGroup,
  ) =>
      throw UnimplementedError();

  Future<ModuleInfo?> getModuleInfo({
    required String packageName,
    ModuleInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<String?> getNameForUid(
    int uid,
  ) =>
      throw UnimplementedError();

  Future<PackageInfo?> getPackageArchiveInfo({
    required String archiveFilePath,
    PackageInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<List<int>?> getPackageGids({
    required String packageName,
  }) =>
      throw UnimplementedError();

  Future<PackageInfo?> getPackageInfo({
    required String packageName,
    PackageInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<int?> getPackageUid({
    required String packageName,
    PackageInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<List<String>?> getPackagesForUid(
    int uid,
  ) =>
      throw UnimplementedError();

  Future<List<PackageInfo>?> getPackagesHoldingPermissions(
    Set<String> permissions,
  ) =>
      throw UnimplementedError();

  Future<PermissionGroupInfo?> getPermissionGroupInfo(
    String groupName, {
    PermissionGroupInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<PermissionInfo?> getPermissionInfo(
    String permName, {
    PermissionInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<PackageManagerProperty?> getProperty({
    required String propertyName,
    required String packageName,
  }) =>
      throw UnimplementedError();

  Future<ProviderInfo?> getProviderInfo({
    required ComponentName componentName,
    ComponentInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<ActivityInfo?> getReceiverInfo({
    required ComponentName componentName,
    ComponentInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<ServiceInfo?> getServiceInfo({
    required ComponentName componentName,
    ComponentInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<List<FeatureInfo>?> getSystemAvailableFeatures() =>
      throw UnimplementedError();

  Future<List<String>?> getSystemSharedLibraryNames() =>
      throw UnimplementedError();

  Future<int?> getTargetSdkVersion({
    required String packageName,
  }) =>
      throw UnimplementedError();

  Future<String?> getText({
    required String packageName,
    required int resourceId,
  }) =>
      throw UnimplementedError();

  Future<List<String>?> getWhitelistedRestrictedPermissions({
    required String packageName,
    required int whitelistFlags,
  }) =>
      throw UnimplementedError();

  Future<bool> hasSigningCertificateByUid({
    required int uid,
    required Uint8List certificateBytes,
    CertificateType type = CertificateType.rawX509,
  }) =>
      throw UnimplementedError();

  Future<bool> hasSigningCertificate({
    required String packageName,
    required Uint8List certificateBytes,
    CertificateType type = CertificateType.rawX509,
  }) =>
      throw UnimplementedError();

  Future<bool> hasSystemFeature({
    required String featureName,
    int? version,
  }) =>
      throw UnimplementedError();

  Future<bool?> isAutoRevokeWhitelisted({
    String? packageName,
  }) =>
      throw UnimplementedError();

  Future<bool?> isDeviceUpgrading() => throw UnimplementedError();

  Future<bool?> isInstantApp({
    String? packageName,
  }) =>
      throw UnimplementedError();

  Future<bool?> isPackageSuspended({
    String? packageName,
  }) =>
      throw UnimplementedError();

  Future<bool?> isPermissionRevokedByPolicy({
    required String packageName,
    required String permName,
  }) =>
      throw UnimplementedError();

  Future<bool> isSafeMode() => throw UnimplementedError();

  Future<void> launchLeanback(
    String packageName,
  ) =>
      throw UnimplementedError();

  Future<void> openApp(
    String packageName,
  ) =>
      throw UnimplementedError();

  Future<List<ProviderInfo>?> queryContentProviders({
    required int uid,
    String? processName,
    ComponentInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<List<PackageManagerProperty>?> queryActivityProperty(
    String propertyName,
  ) =>
      throw UnimplementedError();

  Future<List<PackageManagerProperty>?> queryApplicationProperty(
    String propertyName,
  ) =>
      throw UnimplementedError();

  Future<List<InstrumentationInfo>?> queryInstrumentation(
    String targetPackage, {
    InstrumentationInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<List<PermissionInfo>?> queryPermissionsByGroup(
    String permissionGroup, {
    PermissionInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<List<PackageManagerProperty>?> queryProviderProperty(
    String propertyName,
  ) =>
      throw UnimplementedError();

  Future<List<PackageManagerProperty>?> queryReceiverProperty(
    String propertyName,
  ) =>
      throw UnimplementedError();

  Future<List<PackageManagerProperty>?> queryServiceProperty(
    String propertyName,
  ) =>
      throw UnimplementedError();

  Future<void> removePermission(
    String permName,
  ) =>
      throw UnimplementedError();

  Future<ProviderInfo?> resolveContentProvider({
    required String authority,
    ComponentInfoFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<void> setApplicationEnabledSetting({
    required String packageName,
    required ComponentEnabledState newState,
    EnabledFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<bool?> setAutoRevokeWhitelisted({
    required String packageName,
    required bool whitelisted,
  }) =>
      throw UnimplementedError();

  Future<void> setComponentEnabledSetting({
    required ComponentName componentName,
    required ComponentEnabledState newState,
    EnabledFlags? flags,
  }) =>
      throw UnimplementedError();

  Future<void> setInstallerPackageName({
    required String targetPackage,
    String? installerPackageName,
  }) =>
      throw UnimplementedError();

  Future<void> setMimeGroup({
    required String mimeGroup,
    required Set<String> mimeTypes,
  }) =>
      throw UnimplementedError();

  Future<void> verifyPendingInstall({
    required int id,
    required VerificationCode verificationCode,
  }) =>
      throw UnimplementedError();
}
