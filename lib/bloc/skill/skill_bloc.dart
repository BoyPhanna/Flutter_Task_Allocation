import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_alowcation_app/models/skill.dart';
import 'package:task_alowcation_app/services/database_service.dart';

part 'skill_event.dart';
part 'skill_state.dart';

class SkillBloc extends Bloc<SkillEvent, SkillState> {
  SkillBloc() : super(SkillInitial()) {
    List<Skill> skills = [];
    Skill skill;
    on<AddSkill>((event, emit) async {
      await DatabaseServices.instance.createSkill(Skill(skname: event.skname));
    });

    on<UpdateSkill>((event, emit) async {
      await DatabaseServices.instance.updateSkill(student: event.skill);
    });

    on<FetchSkills>((event, emit) async {
      skills = await DatabaseServices.instance.readAllSkills();
      emit(DisplaySkills(skills: skills));
    });

    on<FetchSpecificSkill>((event, emit) async {
      skill = await DatabaseServices.instance.readSkill(skid: event.skid);
      emit(DisplaySpecificSkill(skill: skill));
    });

    on<DeleteSkill>((event, emit) async {
      await DatabaseServices.instance.deleteSkill(skid: event.skid);

      add(const FetchSkills());
    });
  }
}
