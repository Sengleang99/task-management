import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task/routes/app_router.dart';
import 'package:task/routes/route_names.dart';
import 'package:task/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAgXijvO0DbZVPtHeBRZhhdeRprHSsED40',
          appId: '1:901441741209:android:ef13307df35fe8f6637308',
          messagingSenderId: '901441741209',
          projectId: 'task-management-f384e'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      title: 'Task Manager',
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
