import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../doctors/presentation/bloc/doctor_bloc.dart';
import '../../../doctors/presentation/bloc/doctor_event.dart';
import '../../../doctors/presentation/bloc/doctor_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSpecialization = 'All';
  
  final List<String> _specializations = ['All', 'Cardiology', 'Pediatrics', 'Neurology', 'Dentistry'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      if (_selectedSpecialization == 'All') {
        context.read<DoctorBloc>().add(LoadDoctors());
      } else {
        context.read<DoctorBloc>().add(FilterDoctors(_selectedSpecialization));
      }
    } else {
      context.read<DoctorBloc>().add(SearchDoctors(query));
    }
  }

  void _onSpecializationSelected(String specialization) {
    setState(() {
      _selectedSpecialization = specialization;
      _searchController.clear();
    });
    
    if (specialization == 'All') {
      context.read<DoctorBloc>().add(LoadDoctors());
    } else {
      context.read<DoctorBloc>().add(FilterDoctors(specialization));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.favorite_rounded, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: AppSpacing.sm),
            const Text(
              'Healora',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find Care',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            
            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Doctors, specialties, or clinics...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.tune),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            
            const SizedBox(height: AppSpacing.lg),
            
            // Specializations
            Text(
              'Popular Specialties',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _specializations.length,
                itemBuilder: (context, index) {
                  final spec = _specializations[index];
                  final isSelected = _selectedSpecialization == spec;
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(spec),
                      selected: isSelected,
                      onSelected: (_) => _onSpecializationSelected(spec),
                      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade600,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: AppSpacing.lg),
            
            // Featured Doctors
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Rated Doctors',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            
            // BlocBuilder for Doctors
            BlocBuilder<DoctorBloc, DoctorState>(
              builder: (context, state) {
                if (state is DoctorInitial || state is DoctorLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DoctorError) {
                  return Center(child: Text(state.message));
                } else if (state is DoctorLoaded) {
                  if (state.doctors.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.xl),
                        child: Text('No doctors found.'),
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.doctors.length,
                    itemBuilder: (context, index) {
                      final doc = state.doctors[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: AppSpacing.md),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: const AssetImage('assets/images/doctor_placeholder.png'),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            doc.name,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.teal, size: 16),
                                            const SizedBox(width: 4),
                                            Text(doc.rating.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '\${doc.specialization} • \${doc.hospital}',
                                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'NEXT AVAIL: \${doc.availableSlots.isNotEmpty ? doc.availableSlots.first : "N/A"}',
                                        style: TextStyle(color: Colors.grey.shade700, fontSize: 11, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}