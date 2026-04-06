abstract class ChangedPackages {
  const ChangedPackages({
    required this.packageNames,
    required this.sequenceNumber,
  });

  final List<String> packageNames;
  final int sequenceNumber;
}
