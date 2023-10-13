enum EmployeeRegisterStateStatus {
  initial,
  success,
  failure,
}

class EmployeeRegisterState {
  final EmployeeRegisterStateStatus status;
  final List<String> workDays;
  final List<int> workHours;
  final bool isAdmRegister;

  EmployeeRegisterState.initial()
      : this(
          status: EmployeeRegisterStateStatus.initial,
          isAdmRegister: false,
          workDays: <String>[],
          workHours: <int>[],
        );

  EmployeeRegisterState(
      {required this.status,
      required this.workDays,
      required this.workHours,
      required this.isAdmRegister});

  EmployeeRegisterState copyWith(
      {EmployeeRegisterStateStatus? status,
      List<String>? workDays,
      List<int>? workHours,
      bool? isAdmRegister}) {
    return EmployeeRegisterState(
        status: status ?? this.status,
        workDays: workDays ?? this.workDays,
        workHours: workHours ?? this.workHours,
        isAdmRegister: isAdmRegister ?? this.isAdmRegister);
  }
}
