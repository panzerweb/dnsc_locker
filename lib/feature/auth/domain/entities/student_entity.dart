class StudentEntity {
  final int id;
  final String programName;
  final String studentId;
  final String rfid;
  final String firstName;
  final String middleName;
  final String lastName;
  final String suffix;
  final String studentSet;
  final int studentLevel;
  final String studentStatus;
  final String? studentImage;
  final int program;
  final int user;

  StudentEntity({
    required this.id,
    required this.programName,
    required this.studentId,
    required this.rfid,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.suffix,
    required this.studentSet,
    required this.studentLevel,
    required this.studentStatus,
    this.studentImage,
    required this.program,
    required this.user,
  });
}
