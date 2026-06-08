import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final String id;
  final String doctorId;
  final String doctorName;
  final String patientName;
  final String patientPhone;
  final String patientAge;
  final String patientGender;
  final String date;
  final String time;
  final String status;

  const Appointment({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.patientName,
    required this.patientPhone,
    required this.patientAge,
    required this.patientGender,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      patientName: json['patientName'],
      patientPhone: json['patientPhone'],
      patientAge: json['patientAge'],
      patientGender: json['patientGender'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'patientName': patientName,
      'patientPhone': patientPhone,
      'patientAge': patientAge,
      'patientGender': patientGender,
      'date': date,
      'time': time,
      'status': status,
    };
  }

  Appointment copyWith({
    String? id,
    String? doctorId,
    String? doctorName,
    String? patientName,
    String? patientPhone,
    String? patientAge,
    String? patientGender,
    String? date,
    String? time,
    String? status,
  }) {
    return Appointment(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
      patientAge: patientAge ?? this.patientAge,
      patientGender: patientGender ?? this.patientGender,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, doctorId, doctorName, patientName, patientPhone, patientAge, patientGender, date, time, status];
}
