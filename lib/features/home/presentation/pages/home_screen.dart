import 'package:flutter/material.dart';
import 'package:healora/features/home/presentation/widgets/greeting_section.dart';
import 'package:healora/features/home/presentation/widgets/home_header.dart';
import '../../../../core/theme/app_spacing.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HomeHeader(),
              SizedBox(height: AppSpacing.xl,),
              GreetingSection(),
            ],
          ),
        ),
      ),
    );
  }
}