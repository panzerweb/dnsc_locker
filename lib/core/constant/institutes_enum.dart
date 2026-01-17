enum InstitutesEnum {
  instituteOfComputing(
    instituteId: 1,
    instituteCode: 'IC',
    displayName: 'Institute of Computing',
  ),
  instituteOfLeadershipAndGoodGovernance(
    instituteId: 2,
    instituteCode: 'ILEGG',
    displayName: 'Institute of Leadership and Good Governance',
  ),
  instituteOfTeachersEducation(
    instituteId: 3,
    instituteCode: 'ITED',
    displayName: 'Institute of Teachers Education',
  ),
  instituteOfAppliedAndAquaticSciences(
    instituteId: 4,
    instituteCode: 'IAAS',
    displayName: 'Institute of Aquatic and Applied Sciences',
  );

  const InstitutesEnum({
    required this.instituteId,
    required this.instituteCode,
    required this.displayName,
  });

  final int instituteId;
  final String instituteCode;
  final String displayName;
}
