import 'package:flutter/material.dart';
import 'package:task/presentation/auth/ui/login.dart';

class SignUpLink extends StatelessWidget {
  const SignUpLink({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? "),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Login()),
            );
          },
          child: const Text(
            "Login",
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
