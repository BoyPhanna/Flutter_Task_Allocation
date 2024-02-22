part of 'skill_bloc.dart';

abstract class SkillEvent extends Equatable {
  const SkillEvent();
}

class AddSkill extends SkillEvent {
  final String skname;

  const AddSkill({required this.skname});
  @override
  List<Object?> get props => [skname];
}

class UpdateSkill extends SkillEvent {
  final Skill skill;

  const UpdateSkill({required this.skill});
  @override
  List<Object?> get props => [skill];
}

class FetchSkills extends SkillEvent {
  const FetchSkills();
  @override
  List<Object?> get props => [];
}

class DeleteSkill extends SkillEvent {
  final int skid;
  const DeleteSkill({required this.skid});
  @override
  List<Object?> get props => [skid];
}

class FetchSpecificSkill extends SkillEvent {
  final int skid;
  const FetchSpecificSkill({required this.skid});
  @override
  List<Object?> get props => [skid];
}
