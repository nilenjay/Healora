import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/doctors/data/repositories/local_doctor_repository.dart';
import 'features/doctors/presentation/bloc/doctor_bloc.dart';
import 'features/doctors/presentation/bloc/doctor_event.dart';
import 'features/appointments/data/repositories/local_appointment_repository.dart';
import 'features/appointments/presentation/bloc/appointment_bloc.dart';
import 'features/appointments/presentation/bloc/appointment_event.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HealoraApp());
}

class HealoraApp extends StatelessWidget {
  const HealoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DoctorBloc>(
          create: (context) => DoctorBloc(
            doctorRepository: LocalDoctorRepository(),
          )..add(LoadDoctors()),
        ),
        BlocProvider<AppointmentBloc>(
          create: (context) => AppointmentBloc(
            appointmentRepository: LocalAppointmentRepository(),
          )..add(LoadAppointments()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Healora',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}