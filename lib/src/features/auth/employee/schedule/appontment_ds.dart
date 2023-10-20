import 'package:barber_app/src/models/schedule_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppontmentDs extends CalendarDataSource {
  final List<ScheduleModel> schedules;

  AppontmentDs(this.schedules);

  @override
  List<dynamic> get appointments => schedules.map((schedule) {
        final ScheduleModel(
          :clientName,
          date: DateTime(:year, :month, :day),
          :time
        ) = schedule;

        final startTime = DateTime(year, month, day, time, 0, 0);
        final endTime = DateTime(year, month, day, time + 1, 0, 0);

        return Appointment(
            startTime: startTime, endTime: endTime, subject: clientName);
      }).toList();
}
