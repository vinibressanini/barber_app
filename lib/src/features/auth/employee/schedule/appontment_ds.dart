import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppontmentDs extends CalendarDataSource {
  @override
  List<dynamic> get appointments => [
        Appointment(
            startTime: DateTime.now(),
            endTime: DateTime.now().add(
              const Duration(hours: 1),
            ),
            subject: "Testando"),
        Appointment(
            startTime: DateTime.now().add(
              const Duration(hours: 1),
            ),
            endTime: DateTime.now().add(
              const Duration(hours: 2),
            ),
            subject: "Messi"),
      ];
}
