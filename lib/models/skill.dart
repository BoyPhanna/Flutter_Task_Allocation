const String skillTable = 'skills';

class SkillFields {
  static final List<String> value = [skid, skname];
  static const String skid = 'skid';
  static const String skname = 'skname';
}

class Skill {
  final int? skid;
  final String skname;
  const Skill({this.skid, required this.skname});

  Skill copy({int? skid, String? skname}) => Skill(
        skid: skid ?? this.skid,
        skname: skname ?? this.skname,
      );
  static Skill fromJson(Map<String, Object?> json) => Skill(
        skid: json[SkillFields.skid] as int?,
        skname: json[SkillFields.skname] as String,
      );

  Map<String, Object?> toJson() => {
        SkillFields.skid: skid,
        SkillFields.skname: skname,
      };
}
