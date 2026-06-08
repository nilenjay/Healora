import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/doctor_repository.dart';
import 'doctor_event.dart';
import 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRepository doctorRepository;

  DoctorBloc({required this.doctorRepository}) : super(DoctorInitial()) {
    on<LoadDoctors>(_onLoadDoctors);
    on<SearchDoctors>(_onSearchDoctors);
    on<FilterDoctors>(_onFilterDoctors);
  }

  Future<void> _onLoadDoctors(LoadDoctors event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    try {
      final doctors = await doctorRepository.getDoctors();
      emit(DoctorLoaded(doctors));
    } catch (e) {
      emit(DoctorError('Failed to load doctors: \$e'));
    }
  }

  Future<void> _onSearchDoctors(SearchDoctors event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    try {
      final doctors = await doctorRepository.searchDoctors(event.query);
      emit(DoctorLoaded(doctors));
    } catch (e) {
      emit(DoctorError('Failed to search doctors: \$e'));
    }
  }

  Future<void> _onFilterDoctors(FilterDoctors event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    try {
      final doctors = await doctorRepository.getDoctorsBySpecialization(event.specialization);
      emit(DoctorLoaded(doctors));
    } catch (e) {
      emit(DoctorError('Failed to filter doctors: \$e'));
    }
  }
}
