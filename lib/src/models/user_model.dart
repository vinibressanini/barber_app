sealed class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return switch (json["profile"]) {
      "ADM" => UserModelADM.fromMap(json),
      "EMPLOYEE" => UserModelEmployee.fromMap(json),
      _ => throw ArgumentError("[ERROR] Invalid Json")
    };
  }
}

class UserModelADM extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;

  UserModelADM({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours,
  });

  factory UserModelADM.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": final int id,
        "name": final String name,
        "email": final String email,
      } =>
        UserModelADM(
          id: id,
          name: name,
          email: email,
          avatar: json["avatar"],
          workDays: json["work_days"]?.cast<String>(),
          workHours: json["work_hours"]?.cast<int>(),
        ),
      _ => throw ArgumentError("[ERROR] Invalid JSON")
    };
  }
}

class UserModelEmployee extends UserModel {
  final int barbershopId;
  final List<String> workDays;
  final List<int> workHours;

  UserModelEmployee({
    required this.workDays,
    required this.workHours,
    required this.barbershopId,
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
  });

  factory UserModelEmployee.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": final int id,
        "barbershop_id": final int barbershopId,
        "name": final String name,
        "email": final String email,
        "work_days": final List<String> workDays,
        "work_hours": final List<int> workHours,
      } =>
        UserModelEmployee(
          id: id,
          barbershopId: barbershopId,
          name: name,
          email: email,
          workDays: workDays,
          workHours: workHours,
          avatar: json["avatar"],
        ),
      _ => throw ArgumentError("[ERROR] Invalid JSON")
    };
  }
}
