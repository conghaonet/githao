extension StringExtension on String? {
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }
  bool isNullOrBlank() {
    return this == null || this!.trim().isEmpty;
  }
}