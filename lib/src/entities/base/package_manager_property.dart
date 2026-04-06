abstract class PackageManagerProperty {
  const PackageManagerProperty({
    this.className,
    this.name,
    this.packageName,
    this.value,
  });

  final String? className;
  final String? name;
  final String? packageName;
  final Object? value;
}
