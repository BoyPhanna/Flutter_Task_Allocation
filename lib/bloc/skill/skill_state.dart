part of 'skill_bloc.dart';

sealed class SkillState extends Equatable {
  const SkillState();

  @override
  List<Object> get props => [];
}

final class SkillInitial extends SkillState {
  @override
  List<Object> get props => [];
}

class DisplaySkills extends SkillState {
  final List<Skill> skills;
  const DisplaySkills({required this.skills});
  @override
  List<Object> get props => [skills];
}

class DisplaySpecificSkill extends SkillState {
  final Skill skill;
  const DisplaySpecificSkill({required this.skill});
  @override
  List<Object> get props => [skill];
}
