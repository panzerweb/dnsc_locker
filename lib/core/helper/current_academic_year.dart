String getAcademicYear() {
  final currentDate = DateTime.now();
  final currentYear = currentDate.year;

  return "${(currentYear - 1).toString()}-$currentYear";
}
