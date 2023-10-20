class ScheduleModel {
  final int id;
  final int barbershopId;
  final int userId;
  final String clientName;
  final DateTime date;
  final int time;

  ScheduleModel(
      {required this.id,
      required this.barbershopId,
      required this.userId,
      required this.clientName,
      required this.date,
      required this.time});

  factory ScheduleModel.fromMap(Map<String, dynamic> json) {
    switch (json) {
      case {
          "id": int id,
          "barbershop_id": int barbershopId,
          "user_id": int userId,
          "client_name": String clientName,
          "date": String date,
          "time": int time,
        }:
        return ScheduleModel(
          id: id,
          barbershopId: barbershopId,
          userId: userId,
          clientName: clientName,
          date: DateTime.parse(date),
          time: time,
        );
      case _:
        throw ArgumentError("[ERROR] Erro ao mapear o modelo. JSON inválido");
    }
  }
}
