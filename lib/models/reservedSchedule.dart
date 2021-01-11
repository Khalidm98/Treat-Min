import 'package:treat_min/models/clinicSchedule.dart';

class ReservedSchedule {
  final String id;
  final String doctorName;
  final String doctorSpecialty;
  final ClinicSchedule schedule;

  ReservedSchedule(
      this.id, this.doctorName, this.doctorSpecialty, this.schedule);
}
