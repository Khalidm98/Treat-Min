import '../models/clinic_schedule.dart';

class ReservedSchedule {
  final String id;
  final String hospitalName;
  final String doctorName;
  final String doctorSpecialty;
  final ClinicSchedule schedule;

  ReservedSchedule(this.id, this.doctorName, this.doctorSpecialty,
      this.schedule, this.hospitalName);
}
