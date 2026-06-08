import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+1 234 567 8900 | john.doe@example.com',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            
            // Sections
            _buildProfileSection(
              context,
              title: 'Health Records',
              icon: Icons.medical_information,
              items: ['Medical History', 'Test Reports', 'Prescriptions'],
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildProfileSection(
              context,
              title: 'Insurance',
              icon: Icons.health_and_safety,
              items: ['Health Insurance', 'Billing History'],
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildProfileSection(
              context,
              title: 'General',
              icon: Icons.settings,
              items: ['Help & Support', 'Terms & Conditions', 'Logout'],
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<String> items,
    bool isLogout = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: AppSpacing.sm),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: items.map((item) {
              final isLast = items.last == item;
              final isLogoutItem = isLogout && isLast;
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      item,
                      style: TextStyle(
                        color: isLogoutItem ? Colors.red : Colors.black87,
                        fontWeight: isLogoutItem ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {},
                  ),
                  if (!isLast) Divider(height: 1, color: Colors.grey.shade200),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
