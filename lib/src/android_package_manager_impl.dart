part of '../android_package_manager.dart';

class AndroidPackageManagerImpl extends AndroidPackageManager {
  const AndroidPackageManagerImpl() : super._();

  static const MethodChannel _channel = MethodChannel(
    'android_package_manager',
  );

  static const Map<int, CheckPermissionStatus> _checkPermissionResultMap = {
    0: CheckPermissionStatus.granted,
    -1: CheckPermissionStatus.denied,
  };

  static const Map<int, SignatureCheckResult> _signatureCheckResultMap = {
    0: SignatureCheckResult.match,
    1: SignatureCheckResult.neitherSigned,
    -1: SignatureCheckResult.firstNotSigned,
    -2: SignatureCheckResult.secondNotSigned,
    -3: SignatureCheckResult.noMatch,
    -4: SignatureCheckResult.unknownPackage,
  };

  static Map<String, dynamic> _asMap(
    dynamic data,
  ) =>
      Map<String, dynamic>.from(
        data as Map,
      );

  static T? _parseMap<T>(
    dynamic data,
    T Function(Map<String, dynamic> data) parser,
  ) {
    if (data == null) {
      return null;
    }
    return parser(
      _asMap(data),
    );
  }

  static List<T>? _parseMapList<T>(
    List<Object?>? data,
    T Function(Map<String, dynamic> data) parser,
  ) {
    if (data == null) {
      return null;
    }
    return data
        .map<T>(
          (entry) => parser(
            _asMap(entry),
          ),
        )
        .toList(
          growable: false,
        );
  }

  @override
  Future<bool> canPackageQuery({
    required String sourcePackageName,
    required String targetPackageName,
  }) async {
    final queryable = await _channel.invokeMethod<bool>(
      "canPackageQuery",
      {
        "sourcePackageName": sourcePackageName,
        "targetPackageName": targetPackageName,
      },
    );
    return queryable ?? false;
  }

  @override
  Future<List<String>?> canonicalToCurrentPackageNames({
    required List<String> packageNames,
  }) =>
      _channel.invokeListMethod<String>(
        "canonicalToCurrentPackageNames",
        {
          "packageNames": packageNames,
        },
      );

  @override
  Future<CheckPermissionStatus?> checkPermission({
    required String packageName,
    required String permName,
  }) async {
    final checkResult = await _channel.invokeMethod<int>(
      "checkPermission",
      {
        "packageName": packageName,
        "permName": permName,
      },
    );
    return _checkPermissionResultMap[checkResult];
  }

  @override
  Future<SignatureCheckResult> checkSignatures({
    required String packageName1,
    required String packageName2,
  }) async {
    final checkResult = await _channel.invokeMethod<int>(
      "checkSignatures",
      {
        "packageName1": packageName1,
        "packageName2": packageName2,
      },
    );
    return _signatureCheckResultMap[checkResult] ??
        SignatureCheckResult.unknownPackage;
  }

  @override
  Future<List<String>?> currentToCanonicalPackageNames({
    required List<String> packageNames,
  }) =>
      _channel.invokeListMethod<String>(
        "currentToCanonicalPackageNames",
        {
          "packageNames": packageNames,
        },
      );

  @override
  Future<Uint8List?> getActivityDrawableResource({
    required ComponentName componentName,
    required ActivityResourceType type,
    BitmapCompressFormat format = BitmapCompressFormat.png,
    int quality = 100,
  }) {
    const Map<ActivityResourceType, String> availableMethods = {
      ActivityResourceType.banner: "getActivityBanner",
      ActivityResourceType.icon: "getActivityIcon",
      ActivityResourceType.logo: "getActivityLogo",
    };
    return _channel.invokeMethod<Uint8List>(
      availableMethods[type]!,
      {
        ...componentName.asMap,
        "quality": quality.clamp(
          1,
          100,
        ),
        "format": format.index,
      },
    );
  }

  @override
  Future<List<PermissionGroupInfo>?> getAllPermissionGroups({
    PermissionGroupInfoFlags? flags,
  }) async {
    final permissionGroupsData = await _channel.invokeListMethod(
      "getAllPermissionGroups",
      {
        "flags": flags?.flags,
      },
    );
    return permissionGroupsData
        ?.map<PermissionGroupInfo>(
          (data) => PermissionGroupInfoImpl(
            Map<String, dynamic>.from(
              data,
            ),
          ),
        )
        .toList(
          growable: false,
        );
  }

  @override
  Future<String?> getBackgroundPermissionOptionLabel() =>
      _channel.invokeMethod<String>(
        "getBackgroundPermissionOptionLabel",
      );

  @override
  Future<bool?> getApplicationEnabledSetting({
    required String packageName,
  }) =>
      _channel.invokeMethod<bool>(
        "getApplicationEnabledSetting",
        {
          "packageName": packageName,
        },
      );

  @override
  Future<Uint8List?> getApplicationIcon({
    required String packageName,
    BitmapCompressFormat format = BitmapCompressFormat.png,
    int quality = 100,
  }) =>
      _channel.invokeMethod<Uint8List>(
        "getApplicationIcon",
        {
          'packageName': packageName,
          'quality': quality.clamp(
            1,
            100,
          ),
          'format': format.index,
        },
      );

  @override
  Future<String?> getApplicationLabel({
    required String packageName,
    ApplicationInfoFlags? flags,
  }) =>
      _channel.invokeMethod<String>(
        "getApplicationLabel",
        {
          "packageName": packageName,
          'flags': flags?.flags,
        },
      );

  @override
  Future<Uint8List?> getActivityIcon({
    required String packageName,
    BitmapCompressFormat format = BitmapCompressFormat.png,
    int quality = 100,
  }) =>
      _channel.invokeMethod<Uint8List>(
        "getActivityIcon",
        {
          'packageName': packageName,
          'quality': quality.clamp(
            1,
            100,
          ),
          'format': format.index,
        },
      );

  @override
  Future<Uint8List?> getActivityLogo({
    required String packageName,
    BitmapCompressFormat format = BitmapCompressFormat.png,
    int quality = 100,
  }) =>
      _channel.invokeMethod<Uint8List>(
        "getActivityLogo",
        {
          'packageName': packageName,
          'quality': quality.clamp(
            1,
            100,
          ),
          'format': format.index,
        },
      );

  @override
  Future<ChangedPackages?> getChangedPackages({
    required int sequenceNumber,
  }) async {
    final changedPackagesData = await _channel.invokeMapMethod(
      "getChangedPackages",
      {
        "sequenceNumber": sequenceNumber,
      },
    );
    return _parseMap(
      changedPackagesData,
      (data) => ChangedPackagesImpl(
        data,
      ),
    );
  }

  @override
  Future<bool?> getComponentEnabledSetting({
    required String packageName,
  }) =>
      _channel.invokeMethod<bool>(
        "getComponentEnabledSetting",
        {
          "packageName": packageName,
        },
      );

  @override
  Future<Uint8List?> getDefaultActivityIcon() =>
      _channel.invokeMethod<Uint8List>(
        "getDefaultActivityIcon",
      );

  @override
  Future<Uint8List?> getDrawable({
    required String packageName,
    required int resourceId,
    BitmapCompressFormat format = BitmapCompressFormat.png,
    int quality = 100,
  }) =>
      _channel.invokeMethod<Uint8List>(
        "getDrawable",
        {
          "packageName": packageName,
          "resourceId": resourceId,
          "quality": quality.clamp(
            1,
            100,
          ),
          "format": format.index,
        },
      );

  @override
  Future<List<ApplicationInfo>?> getInstalledApplications({
    ApplicationInfoFlags? flags,
  }) async {
    final installedApplicationsData = await _channel.invokeListMethod(
      "getInstalledApplications",
      {
        "flags": flags?.flags,
      },
    );
    return installedApplicationsData
        ?.map<ApplicationInfo>(
          (data) => ApplicationInfoImpl(
            Map<String, dynamic>.from(
              data,
            ),
          ),
        )
        .toList(
          growable: false,
        );
  }

  @override
  Future<InstallSourceInfo?> getInstallSourceInfo({
    required String packageName,
  }) async {
    final sourceInfo = await _channel.invokeMapMethod(
      'getInstallSourceInfo',
      {
        'packageName': packageName,
      },
    );
    if (sourceInfo != null) {
      return InstallSourceInfoImpl(
        Map<String, dynamic>.from(
          sourceInfo,
        ),
      );
    }
    return null;
  }

  @override
  Future<List<ModuleInfo>?> getInstalledModules({
    InstalledModulesFlags? flags,
  }) async {
    final installedModulesData = await _channel.invokeListMethod(
      "getInstalledModules",
      {
        "flags": flags?.flags ?? InstalledModulesFlags().flags,
      },
    );
    return _parseMapList(
      installedModulesData,
      (data) => ModuleInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<List<PackageInfo>?> getInstalledPackages({
    PackageInfoFlags? flags,
  }) async {
    final installedPackagesData = await _channel.invokeListMethod(
      "getInstalledPackages",
      {
        "flags": flags?.flags,
      },
    );
    return installedPackagesData
        ?.map<PackageInfo>(
          (data) => PackageInfoImpl(
            Map<String, dynamic>.from(
              data,
            ),
          ),
        )
        .toList(
          growable: false,
        );
  }

  @override
  Future<String?> getInstallerPackageName({required String packageName}) async {
    final installerPackageName = await _channel.invokeMethod(
      'getInstallerPackageName',
      {
        'packageName': packageName,
      },
    );
    return installerPackageName?.toString();
  }

  @override
  Future<InstrumentationInfo?> getInstrumentationInfo({
    required ComponentName componentName,
    InstrumentationInfoFlags? flags,
  }) async {
    var instrumentationInfoData = await _channel.invokeMapMethod(
      "getInstrumentationInfo",
      {
        ...componentName.asMap,
        "flags": flags?.flags ?? InstrumentationInfoFlags().flags,
      },
    );
    return _parseMap(
      instrumentationInfoData,
      (data) => InstrumentationInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<List<String>?> getMimeGroup(
    String mimeGroup,
  ) =>
      _channel.invokeListMethod<String>(
        "getMimeGroup",
        {
          "mimeGroup": mimeGroup,
        },
      );

  @override
  Future<ModuleInfo?> getModuleInfo({
    required String packageName,
    ModuleInfoFlags? flags,
  }) async {
    final moduleInfoData = await _channel.invokeMapMethod(
      "getModuleInfo",
      {
        "packageName": packageName,
        "flags": flags?.flags,
      },
    );
    return _parseMap(
      moduleInfoData,
      (data) => ModuleInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<String?> getNameForUid(int uid) => _channel.invokeMethod<String>(
        "getNameForUid",
        {
          'uid': uid,
        },
      );

  @override
  Future<PackageInfo?> getPackageArchiveInfo({
    required String archiveFilePath,
    PackageInfoFlags? flags,
  }) async {
    final packageData = await _channel.invokeMethod(
      "getPackageArchiveInfo",
      {
        "archiveFilePath": archiveFilePath,
        "flags": flags?.flags,
      },
    );
    if (packageData != null) {
      return PackageInfoImpl(
        Map<String, dynamic>.from(
          packageData,
        ),
      );
    }
    return null;
  }

  @override
  Future<List<int>?> getPackageGids({required String packageName}) async {
    final data = await _channel.invokeListMethod(
      "getPackageGids",
      {
        "packageName": packageName,
      },
    );
    return data?.whereType<int>().toList(
          growable: false,
        );
  }

  @override
  Future<PackageInfo?> getPackageInfo({
    required String packageName,
    PackageInfoFlags? flags,
  }) async {
    final packageData = await _channel.invokeMethod(
      "getPackageInfo",
      {
        "packageName": packageName,
        "flags": flags?.flags,
      },
    );
    if (packageData != null) {
      return PackageInfoImpl(
        Map<String, dynamic>.from(
          packageData,
        ),
      );
    }
    return null;
  }

  @override
  Future<int?> getPackageUid({
    required String packageName,
    PackageInfoFlags? flags,
  }) =>
      _channel.invokeMethod<int>(
        "getPackageUid",
        {
          "packageName": packageName,
          "flags": flags?.flags,
        },
      );

  @override
  Future<List<String>?> getPackagesForUid(int uid) async {
    final data = await _channel.invokeListMethod("getPackagesForUid", {
      "uid": uid,
    });
    return data?.whereType<String>().toList(
          growable: false,
        );
  }

  @override
  Future<List<PackageInfo>?> getPackagesHoldingPermissions(
      Set<String> permissions) async {
    final packagesData = await _channel.invokeListMethod(
      "getPackagesHoldingPermissions",
      {
        "permissions": permissions.toList(),
      },
    );
    return _parseMapList(
      packagesData,
      (data) => PackageInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<PermissionGroupInfo?> getPermissionGroupInfo(
    String groupName, {
    PermissionGroupInfoFlags? flags,
  }) async {
    final infoData = await _channel.invokeMapMethod(
      "getPermissionGroupInfo",
      {
        "groupName": groupName,
        "flags": flags?.flags ?? PermissionGroupInfoFlags().flags,
      },
    );
    return _parseMap(
      infoData,
      (data) => PermissionGroupInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<PermissionInfo?> getPermissionInfo(
    String permName, {
    PermissionInfoFlags? flags,
  }) async {
    final infoData = await _channel.invokeMapMethod(
      "getPermissionInfo",
      {
        "permName": permName,
        "flags": flags?.flags ?? PermissionInfoFlags().flags,
      },
    );
    return _parseMap(
      infoData,
      (data) => PermissionInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<PackageManagerProperty?> getProperty({
    required String propertyName,
    required String packageName,
  }) async {
    final propertyData = await _channel.invokeMapMethod(
      "getProperty",
      {
        "propertyName": propertyName,
        "packageName": packageName,
      },
    );
    return _parseMap(
      propertyData,
      (data) => PackageManagerPropertyImpl(
        data,
      ),
    );
  }

  @override
  Future<ProviderInfo?> getProviderInfo({
    required ComponentName componentName,
    ComponentInfoFlags? flags,
  }) async {
    final providerData = await _channel.invokeMapMethod(
      "getProviderInfo",
      {
        ...componentName.asMap,
        "flags": flags?.flags,
      },
    );
    return _parseMap(
      providerData,
      (data) => ProviderInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<ActivityInfo?> getReceiverInfo(
      {required ComponentName componentName, ComponentInfoFlags? flags}) async {
    final receiverData = await _channel.invokeMapMethod(
      "getReceiverInfo",
      {
        ...componentName.asMap,
        "flags": flags?.flags,
      },
    );
    return _parseMap(
      receiverData,
      (data) => ActivityInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<ServiceInfo?> getServiceInfo({
    required ComponentName componentName,
    ComponentInfoFlags? flags,
  }) async {
    final serviceData = await _channel.invokeMapMethod(
      "getServiceInfo",
      {
        ...componentName.asMap,
        "flags": flags?.flags,
      },
    );
    return _parseMap(
      serviceData,
      (data) => ServiceInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<List<FeatureInfo>?> getSystemAvailableFeatures() async {
    final featureData = await _channel.invokeListMethod(
      "getSystemAvailableFeatures",
    );
    return _parseMapList(
      featureData,
      (data) => FeatureInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<List<String>?> getSystemSharedLibraryNames() async {
    final nameData = await _channel.invokeListMethod(
      "getSystemSharedLibraryNames",
    );
    return nameData?.whereType<String>().toList(
          growable: false,
        );
  }

  @override
  Future<int?> getTargetSdkVersion({
    required String packageName,
  }) =>
      _channel.invokeMethod<int>(
        "getTargetSdkVersion",
        {
          "packageName": packageName,
        },
      );

  @override
  Future<String?> getText({
    required String packageName,
    required int resourceId,
  }) =>
      _channel.invokeMethod<String>(
        "getText",
        {
          "packageName": packageName,
          "resourceId": resourceId,
        },
      );

  @override
  Future<List<String>?> getWhitelistedRestrictedPermissions({
    required String packageName,
    required int whitelistFlags,
  }) =>
      _channel.invokeListMethod<String>(
        "getWhitelistedRestrictedPermissions",
        {
          "packageName": packageName,
          "flags": whitelistFlags,
        },
      );

  @override
  Future<bool> hasSigningCertificateByUid({
    required int uid,
    required Uint8List certificateBytes,
    CertificateType type = CertificateType.rawX509,
  }) async {
    final result = await _channel.invokeMethod(
      'hasSigningCertificateWithUid',
      {
        'uid': uid,
        'certificate': certificateBytes,
        'type': type.index,
      },
    );
    return result == true;
  }

  @override
  Future<bool> hasSigningCertificate({
    required String packageName,
    required Uint8List certificateBytes,
    CertificateType type = CertificateType.rawX509,
  }) async {
    final result = await _channel.invokeMethod(
      'hasSigningCertificate',
      {
        'packageName': packageName,
        'certificate': certificateBytes,
        'type': type.index,
      },
    );
    return result == true;
  }

  @override
  Future<bool> hasSystemFeature({required String featureName, int? version}) =>
      _channel.invokeMethod(
        "hasSystemFeature",
        {
          "featureName": featureName,
          "version": version,
        },
      ).then(
        (result) => result == true,
      );

  @override
  Future<bool?> isAutoRevokeWhitelisted({
    String? packageName,
  }) =>
      _channel.invokeMethod<bool>(
        "isAutoRevokeWhitelisted",
        {
          if (packageName != null) "packageName": packageName,
        },
      );

  @override
  Future<bool?> isDeviceUpgrading() => _channel.invokeMethod<bool>(
        "isDeviceUpgrading",
      );

  @override
  Future<bool?> isInstantApp({
    String? packageName,
  }) =>
      _channel.invokeMethod<bool>(
        "isInstantApp",
        {
          if (packageName != null) "packageName": packageName,
        },
      );

  @override
  Future<bool?> isPackageSuspended({
    String? packageName,
  }) =>
      _channel.invokeMethod<bool>(
        "isPackageSuspended",
        {
          if (packageName != null) "packageName": packageName,
        },
      );

  @override
  Future<bool?> isPermissionRevokedByPolicy({
    required String packageName,
    required String permName,
  }) =>
      _channel.invokeMethod<bool>(
        "isPermissionRevokedByPolicy",
        {
          "packageName": packageName,
          "permName": permName,
        },
      );

  @override
  Future<bool> isSafeMode() => _channel
      .invokeMethod(
        "isSafeMode",
      )
      .then(
        (result) => result == true,
      );

  @override
  Future<void> launchLeanback(String packageName) async {
    await _channel.invokeMethod(
      "launchLeanback",
      {
        "packageName": packageName,
      },
    );
  }

  @override
  Future<void> openApp(String packageName) async {
    await _channel.invokeMethod(
      "openApp",
      {
        "packageName": packageName,
      },
    );
  }

  @override
  Future<List<ProviderInfo>?> queryContentProviders({
    required int uid,
    String? processName,
    ComponentInfoFlags? flags,
  }) async {
    final providerData = await _channel.invokeListMethod(
      "queryContentProviders",
      {
        "uid": uid,
        "processName": processName,
        "flags": flags?.flags,
      },
    );
    return _parseMapList(
      providerData,
      (data) => ProviderInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<List<PackageManagerProperty>?> queryActivityProperty(
    String propertyName,
  ) async {
    final propertyData = await _channel.invokeListMethod(
      "queryActivityProperty",
      {
        "propertyName": propertyName,
      },
    );
    return _parseMapList(
      propertyData,
      (data) => PackageManagerPropertyImpl(
        data,
      ),
    );
  }

  @override
  Future<List<PackageManagerProperty>?> queryApplicationProperty(
    String propertyName,
  ) async {
    final propertyData = await _channel.invokeListMethod(
      "queryApplicationProperty",
      {
        "propertyName": propertyName,
      },
    );
    return _parseMapList(
      propertyData,
      (data) => PackageManagerPropertyImpl(
        data,
      ),
    );
  }

  @override
  Future<List<InstrumentationInfo>?> queryInstrumentation(
    String targetPackage, {
    InstrumentationInfoFlags? flags,
  }) async {
    final info = await _channel.invokeListMethod(
      "queryInstrumentation",
      {
        "targetPackage": targetPackage,
        "flags": flags?.flags ?? InstrumentationInfoFlags().flags,
      },
    );
    return _parseMapList(
      info,
      (data) => InstrumentationInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<List<PermissionInfo>?> queryPermissionsByGroup(
    String permissionGroup, {
    PermissionInfoFlags? flags,
  }) async {
    final info = await _channel.invokeListMethod(
      "queryPermissionsByGroup",
      {
        "permissionGroup": permissionGroup,
        "flags": flags?.flags ?? PermissionInfoFlags().flags,
      },
    );
    return _parseMapList(
      info,
      (data) => PermissionInfoImpl(
        data,
      ),
    );
  }

  @override
  Future<List<PackageManagerProperty>?> queryProviderProperty(
    String propertyName,
  ) async {
    final propertyData = await _channel.invokeListMethod(
      "queryProviderProperty",
      {
        "propertyName": propertyName,
      },
    );
    return _parseMapList(
      propertyData,
      (data) => PackageManagerPropertyImpl(
        data,
      ),
    );
  }

  @override
  Future<List<PackageManagerProperty>?> queryReceiverProperty(
    String propertyName,
  ) async {
    final propertyData = await _channel.invokeListMethod(
      "queryReceiverProperty",
      {
        "propertyName": propertyName,
      },
    );
    return _parseMapList(
      propertyData,
      (data) => PackageManagerPropertyImpl(
        data,
      ),
    );
  }

  @override
  Future<List<PackageManagerProperty>?> queryServiceProperty(
    String propertyName,
  ) async {
    final propertyData = await _channel.invokeListMethod(
      "queryServiceProperty",
      {
        "propertyName": propertyName,
      },
    );
    return _parseMapList(
      propertyData,
      (data) => PackageManagerPropertyImpl(
        data,
      ),
    );
  }

  @override
  Future<void> removePermission(String permName) async {
    await _channel.invokeMethod(
      "removePermission",
      {
        "permName": permName,
      },
    );
  }

  @override
  Future<ProviderInfo?> resolveContentProvider({
    required String authority,
    ComponentInfoFlags? flags,
  }) async {
    final providerData = await _channel.invokeMethod(
      "resolveContentProvider",
      {
        "authority": authority,
        "flags": flags?.flags,
      },
    );
    if (providerData != null) {
      return ProviderInfoImpl(
        Map<String, dynamic>.from(
          providerData,
        ),
      );
    }
    return null;
  }

  @override
  Future<void> setApplicationEnabledSetting({
    required String packageName,
    required ComponentEnabledState newState,
    EnabledFlags? flags,
  }) async {
    await _channel.invokeMethod(
      "setApplicationEnabledSetting",
      {
        "packageName": packageName,
        "newState": newState.index,
        "flags": flags?.flags,
      },
    );
  }

  @override
  Future<bool?> setAutoRevokeWhitelisted({
    required String packageName,
    required bool whitelisted,
  }) =>
      _channel.invokeMethod<bool>(
        "setAutoRevokeWhitelisted",
        {
          "packageName": packageName,
          "whitelisted": whitelisted,
        },
      );

  @override
  Future<void> setComponentEnabledSetting({
    required ComponentName componentName,
    required ComponentEnabledState newState,
    EnabledFlags? flags,
  }) async {
    await _channel.invokeMethod(
      "setComponentEnabledSetting",
      {
        ...componentName.asMap,
        "newState": newState.index,
        "flags": flags?.flags,
      },
    );
  }

  @override
  Future<void> setInstallerPackageName({
    required String targetPackage,
    String? installerPackageName,
  }) async {
    await _channel.invokeMethod(
      "setInstallerPackageName",
      {
        "targetPackage": targetPackage,
        "installerPackageName": installerPackageName,
      },
    );
  }

  @override
  Future<void> setMimeGroup({
    required String mimeGroup,
    required Set<String> mimeTypes,
  }) async {
    await _channel.invokeMethod(
      "setMimeGroup",
      {
        "mimeGroup": mimeGroup,
        "mimeTypes": mimeTypes.toList(
          growable: false,
        ),
      },
    );
  }

  @override
  Future<void> verifyPendingInstall({
    required int id,
    required VerificationCode verificationCode,
  }) async {
    await _channel.invokeMethod(
      "verifyPendingInstall",
      {
        "id": id,
        "verificationCode": <VerificationCode, int>{
          VerificationCode.allow: 1,
          VerificationCode.reject: -1,
        }[verificationCode],
      },
    );
  }
}
