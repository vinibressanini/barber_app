import 'package:barber_app/src/models/user_model.dart';

enum AdminHomeStateStatus {
  loaded,
  error,
}

class AdminHomeState {
  final AdminHomeStateStatus status;
  final List<UserModel> employees;

  AdminHomeState({required this.status, required this.employees});

  AdminHomeState copyWith(
      {AdminHomeStateStatus? status, List<UserModelEmployee>? employees}) {
    return AdminHomeState(
        status: status ?? this.status, employees: employees ?? this.employees);
  }
}
