import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/repositories/doctor_repository.dart';
import '../models/doctor.dart';

class LocalDoctorRepository implements DoctorRepository {
  // Using a hardcoded JSON string here for the sake of the local mock data requirement, 
  // but it could easily be loaded from assets/json/doctors.json
  final String _mockJsonData = '''
  [
    {
      "id": "1",
      "name": "Dr. Michael Chen",
      "specialization": "Cardiology",
      "hospital": "Mount Sinai Hospital",
      "experience": "15+ Years",
      "rating": 4.9,
      "fee": 150,
      "imageUrl": "assets/images/male_doctor1.png",
      "availableSlots": ["09:00 AM", "10:30 AM", "02:00 PM"]
    },
    {
      "id": "2",
      "name": "Dr. Emily Rodriguez",
      "specialization": "Pediatrics",
      "hospital": "Wellness Clinic",
      "experience": "10+ Years",
      "rating": 4.8,
      "fee": 120,
      "imageUrl": "assets/images/female_doctor1.png",
      "availableSlots": ["11:00 AM", "01:00 PM", "04:30 PM"]
    },
    {
      "id": "3",
      "name": "Dr. Sarah Jenkins",
      "specialization": "Neurology",
      "hospital": "City Hospital",
      "experience": "12+ Years",
      "rating": 4.7,
      "fee": 200,
      "imageUrl": "assets/images/female_doctor2.png",
      "availableSlots": ["08:30 AM", "03:00 PM"]
    },
    {
      "id": "4",
      "name": "Dr. James Smith",
      "specialization": "Dentistry",
      "hospital": "Smile Care",
      "experience": "8+ Years",
      "rating": 4.6,
      "fee": 90,
      "imageUrl": "assets/images/male_doctor2.png",
      "availableSlots": ["10:00 AM", "12:00 PM", "05:00 PM"]
    }
  ]
  ''';

  List<Doctor>? _cachedDoctors;

  Future<List<Doctor>> _loadDoctors() async {
    if (_cachedDoctors != null) return _cachedDoctors!;
    
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    final List<dynamic> jsonList = json.decode(_mockJsonData);
    _cachedDoctors = jsonList.map((json) => Doctor.fromJson(json)).toList();
    return _cachedDoctors!;
  }

  @override
  Future<List<Doctor>> getDoctors() async {
    return await _loadDoctors();
  }

  @override
  Future<List<Doctor>> searchDoctors(String query) async {
    final doctors = await _loadDoctors();
    if (query.isEmpty) return doctors;
    
    final lowerQuery = query.toLowerCase();
    return doctors.where((doc) {
      return doc.name.toLowerCase().contains(lowerQuery) || 
             doc.specialization.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<List<Doctor>> getDoctorsBySpecialization(String specialization) async {
    final doctors = await _loadDoctors();
    return doctors.where((doc) => doc.specialization == specialization).toList();
  }
}
