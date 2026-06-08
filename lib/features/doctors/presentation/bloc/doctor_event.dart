import 'package:equatable/equatable.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object?> get props => [];
}

class LoadDoctors extends DoctorEvent {}

class SearchDoctors extends DoctorEvent {
  final String query;

  const SearchDoctors(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterDoctors extends DoctorEvent {
  final String specialization;

  const FilterDoctors(this.specialization);

  @override
  List<Object?> get props => [specialization];
}
