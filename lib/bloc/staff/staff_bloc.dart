import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_alowcation_app/bloc/task/task_event.dart';
import 'package:task_alowcation_app/models/skill.dart';
import 'package:task_alowcation_app/models/staff.dart';
import 'package:task_alowcation_app/services/database_service.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  StaffBloc() : super(StaffInitial()) {
    List<Staff> staffs = [];
    Staff staff;

    on<AddStaff>((event, emit) async {
      await DatabaseServices.instance.createStaff(Staff(
          stname: event.stname,
          gender: event.gender,
          dob: event.dob,
          skid: event.skid,
          phone: event.phone,
          address: event.address));
    });

    on<UpdateStaff>((event, emit) async {
      await DatabaseServices.instance.updateStarff(staff: event.staff);
      add(const FetchStaffs());
    });

    on<FetchStaffs>((event, emit) async {
      staffs = await DatabaseServices.instance.readAllStaffs();
      List<Skill> skills = [];

      int men = 0;
      int women = 0;
      int orther = 0;

      for (int i = 0; i < staffs.length; i++) {
        if (staffs[i].gender == 'M') {
          men++;
        }
        if (staffs[i].gender == 'F') {
          women++;
        } else if (staffs[i].gender == 'O') {
          orther++;
        }
        if (staffs.isNotEmpty) {
          skills.add(
              await DatabaseServices.instance.readSkill(skid: staffs[i].skid));
        }
      }

      emit(DisplayStaffs(
          staffs: staffs,
          skills: skills,
          men: men,
          women: women,
          orther: orther));
    });

    on<FetchSpecificStaff>((event, emit) async {
      staff = await DatabaseServices.instance.readStaff(stid: event.stid);
      emit(DisplaySpecificStaff(staff: staff));
    });

    on<DeleteStaff>((event, emit) async {
      await DatabaseServices.instance.deleteStaff(stid: event.stid);

      add(const FetchStaffs());
    });
  }
}
