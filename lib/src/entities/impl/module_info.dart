import '../base/module_info.dart';

class ModuleInfoImpl extends ModuleInfo {
  ModuleInfoImpl(
    Map<String, dynamic> data,
  ) : super(
          isHidden: data['isHidden'] ?? false,
          name: data['name'],
          packageName: data['packageName'],
        );
}
