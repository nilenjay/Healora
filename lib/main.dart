import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const HealoraApp());
}

class HealoraApp extends StatelessWidget{
  const HealoraApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Healora',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      home: const HomeScreen(),
    );
  }
}