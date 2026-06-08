import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';

class GreetingSection extends StatelessWidget{
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Morning,',
          style: Theme.of(context).textTheme.bodyLarge,
        ),

        const SizedBox(height: AppSpacing.sm,),

        Text(
          'Sarah Jenkins',
          style: Theme.of(context).textTheme.headlineLarge,
        )
      ],
    );
  }
}