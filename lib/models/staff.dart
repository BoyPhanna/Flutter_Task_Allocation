const String staffTable = 'staffs';

class StaffFields {
  static final List<String> value = [
    stid,
    stname,
    gender,
    dob,
    skid,
    phone,
    address
  ];
  static const String stid = 'stid';
  static const String stname = 'stname';
  static const String gender = 'gender';
  static const String dob = 'dob';
  static const String skid = 'skid';
  static const String phone = 'phone';
  static const String address = 'address';
}

class Staff {
  final int? stid;
  final String stname;
  final String gender;
  final String dob;
  final int skid;
  final String phone;
  final String address;
  const Staff({
    this.stid,
    required this.stname,
    required this.gender,
    required this.dob,
    required this.skid,
    required this.phone,
    required this.address,
  });

  Staff copy({
    int? stid,
    String? stname,
    String? gender,
    String? dob,
    int? skid,
    String? phone,
    String? address,
  }) =>
      Staff(
        stid: stid ?? this.stid,
        stname: stname ?? this.stname,
        gender: gender ?? this.gender,
        dob: dob ?? this.dob,
        skid: skid ?? this.skid,
        phone: phone ?? this.phone,
        address: address ?? this.address,
      );
  static Staff fromJson(Map<String, Object?> json) => Staff(
        stid: json[StaffFields.stid] as int?,
        stname: json[StaffFields.stname] as String,
        gender: json[StaffFields.gender] as String,
        dob: json[StaffFields.dob] as String,
        skid: json[StaffFields.skid] as int,
        phone: json[StaffFields.phone] as String,
        address: json[StaffFields.address] as String,
      );

  Map<String, Object?> toJson() => {
        StaffFields.stid: stid,
        StaffFields.stname: stname,
        StaffFields.gender: gender,
        StaffFields.dob: dob,
        StaffFields.skid: skid,
        StaffFields.phone: phone,
        StaffFields.address: address,
      };
}
