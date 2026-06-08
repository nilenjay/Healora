import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../models/appointment.dart';

class LocalAppointmentRepository implements AppointmentRepository {
  static const String _storageKey = 'healora_appointments';

  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<List<Appointment>> getAppointments() async {
    final prefs = await _getPrefs();
    final String? data = prefs.getString(_storageKey);
    
    if (data == null || data.isEmpty) {
      return [];
    }

    final List<dynamic> jsonList = json.decode(data);
    return jsonList.map((json) => Appointment.fromJson(json)).toList();
  }

  @override
  Future<void> addAppointment(Appointment appointment) async {
    final appointments = await getAppointments();
    appointments.add(appointment);
    
    final prefs = await _getPrefs();
    final String data = json.encode(appointments.map((a) => a.toJson()).toList());
    await prefs.setString(_storageKey, data);
  }

  @override
  Future<void> cancelAppointment(String id) async {
    final appointments = await getAppointments();
    final index = appointments.indexWhere((a) => a.id == id);
    
    if (index != -1) {
      // Update status to Cancelled instead of deleting, to keep history
      appointments[index] = appointments[index].copyWith(status: 'Cancelled');
      
      final prefs = await _getPrefs();
      final String data = json.encode(appointments.map((a) => a.toJson()).toList());
      await prefs.setString(_storageKey, data);
    }
  }
}
