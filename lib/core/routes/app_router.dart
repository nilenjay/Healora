import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/splash_screen.dart';
import '../../features/home/presentation/pages/main_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/signup_screen.dart';
import '../../features/doctors/presentation/pages/doctor_detail_screen.dart';
import '../../features/appointments/presentation/pages/appointment_booking_screen.dart';
import '../../features/doctors/data/models/doctor.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final tabIndex = extra?['tabIndex'] as int? ?? 0;
          return MainScreen(initialTabIndex: tabIndex);
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/doctor-detail',
        builder: (context, state) {
          final doctor = state.extra as Doctor;
          return DoctorDetailScreen(doctor: doctor);
        },
      ),
      GoRoute(
        path: '/book-appointment',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final doctor = extra['doctor'] as Doctor;
          final slot = extra['slot'] as String;
          return AppointmentBookingScreen(doctor: doctor, slotTime: slot);
        },
      ),
    ],
  );
}
