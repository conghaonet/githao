extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  String get nullSafety => this ?? '';
}