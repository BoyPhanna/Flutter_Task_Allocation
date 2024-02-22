part of 'staff_bloc.dart';

sealed class StaffState extends Equatable {
  const StaffState();

  @override
  List<Object> get props => [];
}

final class StaffInitial extends StaffState {
  @override
  List<Object> get props => [];
}

class DisplayStaffs extends StaffState {
  final List<Staff> staffs;
  final List<Skill> skills;
  final int men;
  final int women;
  final int orther;
  const DisplayStaffs(
      {required this.staffs,
      required this.skills,
      required this.men,
      required this.women,
      required this.orther});
  @override
  List<Object> get props => [staffs, skills, men, women, orther];
}

class DisplaySpecificStaff extends StaffState {
  final Staff staff;
  const DisplaySpecificStaff({required this.staff});
  @override
  List<Object> get props => [staff];
}
