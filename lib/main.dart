import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const HealoraApp());
}

class HealoraApp extends StatelessWidget{
  const HealoraApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      title: 'Healora',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}