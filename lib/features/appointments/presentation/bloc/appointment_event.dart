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
