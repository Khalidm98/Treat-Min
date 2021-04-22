import '../models/clinic_schedule.dart';

class ReservedSchedule {
  final String id;
  final String hospitalName;
  final String name;
  final String doctorSpecialty;
  final ClinicSchedule schedule;
  final bool isCurrentRes;
  final bool isClinic;
  ReservedSchedule(
      {this.id,
      this.name,
      this.doctorSpecialty,
      this.schedule,
      this.hospitalName,
      this.isCurrentRes,
      this.isClinic});
}

// class ReservedSORSchedule {
//   final String id;
//   final String hospitalName;
//   final String name;
//   final ClinicSchedule schedule;
//   final bool isCurrentRes;
//
//   ReservedSORSchedule(
//       this.id, this.name, this.schedule, this.hospitalName, this.isCurrentRes);
// }
