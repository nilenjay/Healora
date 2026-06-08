import '../../data/models/doctor.dart';

abstract class DoctorRepository {
  Future<List<Doctor>> getDoctors();
  Future<List<Doctor>> searchDoctors(String query);
  Future<List<Doctor>> getDoctorsBySpecialization(String specialization);
}
