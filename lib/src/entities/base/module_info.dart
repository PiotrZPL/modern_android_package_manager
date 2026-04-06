abstract class ModuleInfo {
  const ModuleInfo({
    this.isHidden = false,
    this.name,
    this.packageName,
  });

  final bool isHidden;
  final String? name;
  final String? packageName;
}
