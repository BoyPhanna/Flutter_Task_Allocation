part of 'staff_bloc.dart';

abstract class StaffEvent extends Equatable {
  const StaffEvent();
}

class AddStaff extends StaffEvent {
  final String stname;
  final String gender;
  final String dob;
  final int skid;
  final String phone;
  final String address;
  const AddStaff(
      {required this.stname,
      required this.gender,
      required this.dob,
      required this.skid,
      required this.phone,
      required this.address});
  @override
  List<Object?> get props => [stname, gender, dob, skid, phone, address];
}

class UpdateStaff extends StaffEvent {
  final Staff staff;

  const UpdateStaff({required this.staff});
  @override
  List<Object?> get props => [staff];
}

class FetchStaffs extends StaffEvent {
  const FetchStaffs();
  @override
  List<Object?> get props => [];
}

class DeleteStaff extends StaffEvent {
  final int stid;
  const DeleteStaff({required this.stid});
  @override
  List<Object?> get props => [stid];
}

class FetchSpecificStaff extends StaffEvent {
  final int stid;
  const FetchSpecificStaff({required this.stid});
  @override
  List<Object?> get props => [stid];
}
