import 'package:flutter/material.dart';
import 'package:task/presentation/auth/ui/register.dart';

class LoginLink extends StatelessWidget {
  const LoginLink({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "), // Changed text
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Register()),
            );
          },
          child: const Text(
            "Register", // Changed text
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

