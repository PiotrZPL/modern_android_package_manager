import '../base/changed_packages.dart';

class ChangedPackagesImpl extends ChangedPackages {
  ChangedPackagesImpl(
    Map<String, dynamic> data,
  ) : super(
          packageNames: data['packageNames']?.whereType<String>().toList(
                    growable: false,
                  ) ??
              const <String>[],
          sequenceNumber: data['sequenceNumber'] ?? 0,
        );
}
