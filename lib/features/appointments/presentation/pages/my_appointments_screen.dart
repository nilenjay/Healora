import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/appointment_card.dart';
import '../bloc/appointment_bloc.dart';
import '../bloc/appointment_event.dart';
import '../bloc/appointment_state.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Appointments'),
          centerTitle: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: BlocBuilder<AppointmentBloc, AppointmentState>(
          builder: (context, state) {
            if (state is AppointmentInitial || state is AppointmentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AppointmentError) {
              return Center(child: Text(state.message));
            } else if (state is AppointmentLoaded) {
              final upcomingAppointments = state.appointments.where((a) => a.status != 'Cancelled').toList();
              final pastAppointments = state.appointments.where((a) => a.status == 'Cancelled').toList();

              return TabBarView(
                children: [
                  _buildAppointmentList(context, upcomingAppointments, isPast: false),
                  _buildAppointmentList(context, pastAppointments, isPast: true),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildAppointmentList(BuildContext context, List appointments, {required bool isPast}) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: AppSpacing.md),
            Text(
              isPast ? 'No past appointments' : 'No upcoming appointments',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return AppointmentCard(
          appointment: appointment,
          onCancel: isPast ? null : () {
            _showCancelDialog(context, appointment.id);
          },
          onDelete: !isPast ? null : () {
            _showDeleteDialog(context, appointment.id);
          },
          onReschedule: isPast ? null : () {
            _showRescheduleDialog(context, appointment.id, appointment.time);
          },
        );
      },
    );
  }

  void _showCancelDialog(BuildContext context, String appointmentId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text('Are you sure you want to cancel this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AppointmentBloc>().add(CancelAppointment(appointmentId));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Appointment cancelled successfully.')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String appointmentId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Appointment'),
        content: const Text('Are you sure you want to permanently delete this appointment from your history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AppointmentBloc>().add(DeleteAppointment(appointmentId));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Appointment deleted successfully.')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showRescheduleDialog(BuildContext context, String appointmentId, String currentTime) {
    final List<String> availableSlots = [
      '09:00 AM',
      '10:30 AM',
      '01:00 PM',
      '03:30 PM',
      '05:00 PM'
    ];
    // Remove the current time so they don't reschedule to the same time
    availableSlots.remove(currentTime);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select New Time',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: availableSlots.map((slot) {
                    return ActionChip(
                      label: Text(slot),
                      onPressed: () {
                        Navigator.pop(ctx);
                        context.read<AppointmentBloc>().add(RescheduleAppointment(appointmentId, slot));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Appointment rescheduled to \$slot')),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
        );
      },
    );
  }
}
