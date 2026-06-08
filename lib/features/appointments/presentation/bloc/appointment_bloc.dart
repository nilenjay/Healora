import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/appointment_repository.dart';
import 'appointment_event.dart';
import 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository appointmentRepository;

  AppointmentBloc({required this.appointmentRepository}) : super(AppointmentInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
    on<BookAppointment>(_onBookAppointment);
    on<CancelAppointment>(_onCancelAppointment);
  }

  Future<void> _onLoadAppointments(LoadAppointments event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    try {
      final appointments = await appointmentRepository.getAppointments();
      emit(AppointmentLoaded(appointments));
    } catch (e) {
      emit(AppointmentError('Failed to load appointments: \$e'));
    }
  }

  Future<void> _onBookAppointment(BookAppointment event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    try {
      await appointmentRepository.addAppointment(event.appointment);
      final appointments = await appointmentRepository.getAppointments();
      emit(AppointmentLoaded(appointments));
    } catch (e) {
      emit(AppointmentError('Failed to book appointment: \$e'));
    }
  }

  Future<void> _onCancelAppointment(CancelAppointment event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    try {
      await appointmentRepository.cancelAppointment(event.appointmentId);
      final appointments = await appointmentRepository.getAppointments();
      emit(AppointmentLoaded(appointments));
    } catch (e) {
      emit(AppointmentError('Failed to cancel appointment: \$e'));
    }
  }
}
