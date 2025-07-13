import 'package:flutter/material.dart';
import 'package:task/presentation/auth/auth_screen/forgot_password.dart';
import 'package:task/presentation/auth/ui/login.dart';
import 'package:task/presentation/auth/ui/register.dart';
import 'package:task/presentation/home/ui/home_screen.dart';
import 'package:task/routes/route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const Login());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const Login());
      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => const Register());
      case RouteNames.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
