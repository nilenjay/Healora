import '../../data/models/appointment.dart';

abstract class AppointmentRepository {
  Future<List<Appointment>> getAppointments();
  Future<void> addAppointment(Appointment appointment);
  Future<void> cancelAppointment(String id);
  Future<void> deleteAppointment(String id);
  Future<void> rescheduleAppointment(String id, String newTime);
}
