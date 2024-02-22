const String taskTable = 'tasks';

class TaskFields {
  static final List<String> value = [
    taid,
    taname,
    deadline,
    stid,
    availability
  ];
  static const String taid = 'taid';
  static const String taname = 'taname';
  static const String deadline = 'deadline';
  static const String stid = 'stid';
  static const String availability = 'availability';
}

class Task {
  final int? taid;
  final String taname;
  final DateTime deadline;
  final int stid;
  final int availability;
  const Task(
      {this.taid,
      required this.taname,
      required this.deadline,
      required this.stid,
      required this.availability});

  Task copy(
          {int? taid,
          String? taname,
          DateTime? deadline,
          int? stid,
          int? availability}) =>
      Task(
        taid: taid ?? this.taid,
        taname: taname ?? this.taname,
        deadline: deadline ?? this.deadline,
        stid: stid ?? this.stid,
        availability: availability ?? this.availability,
      );
  static Task fromJson(Map<String, Object?> json) => Task(
        taid: json[TaskFields.taid] as int?,
        taname: json[TaskFields.taname] as String,
        deadline: json[TaskFields.deadline] as DateTime,
        stid: json[TaskFields.stid] as int,
        availability: json[TaskFields.availability] as int,
      );

  Map<String, Object?> toJson() => {
        TaskFields.taid: taid,
        TaskFields.taname: taname,
        TaskFields.deadline: deadline,
        TaskFields.stid: stid,
        TaskFields.availability: availability,
      };
}
