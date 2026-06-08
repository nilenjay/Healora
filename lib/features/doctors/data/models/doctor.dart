import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String id;
  final String name;
  final String specialization;
  final String hospital;
  final String experience;
  final double rating;
  final int fee;
  final String imageUrl;
  final List<String> availableSlots;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.hospital,
    required this.experience,
    required this.rating,
    required this.fee,
    required this.imageUrl,
    required this.availableSlots,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
      hospital: json['hospital'],
      experience: json['experience'],
      rating: json['rating'].toDouble(),
      fee: json['fee'],
      imageUrl: json['imageUrl'],
      availableSlots: List<String>.from(json['availableSlots']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'hospital': hospital,
      'experience': experience,
      'rating': rating,
      'fee': fee,
      'imageUrl': imageUrl,
      'availableSlots': availableSlots,
    };
  }

  @override
  List<Object?> get props => [id, name, specialization, hospital, experience, rating, fee, imageUrl, availableSlots];
}
