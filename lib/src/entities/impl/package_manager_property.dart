import '../base/package_manager_property.dart';

class PackageManagerPropertyImpl extends PackageManagerProperty {
  PackageManagerPropertyImpl(
    Map<String, dynamic> data,
  ) : super(
          className: data['className'],
          name: data['name'],
          packageName: data['packageName'],
          value: data['value'],
        );
}
