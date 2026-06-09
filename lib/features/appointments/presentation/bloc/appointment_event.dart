import 'package:equatable/equatable.dart';
import '../../data/models/appointment.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object?> get props => [];
}

class LoadAppointments extends AppointmentEvent {}

class BookAppointment extends AppointmentEvent {
  final Appointment appointment;

  const BookAppointment(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

class CancelAppointment extends AppointmentEvent {
  final String appointmentId;

  const CancelAppointment(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}

class DeleteAppointment extends AppointmentEvent {
  final String appointmentId;

  const DeleteAppointment(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}

class RescheduleAppointment extends AppointmentEvent {
  final String appointmentId;
  final String newTime;

  const RescheduleAppointment(this.appointmentId, this.newTime);

  @override
  List<Object?> get props => [appointmentId, newTime];
}
