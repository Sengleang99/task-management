import 'package:flutter/material.dart';
import 'package:task/presentation/auth/widgets/text_field.dart';
import 'package:task/utils/validator.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final FocusNode emailFocusNode = FocusNode();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Enter your email to reset password",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              AuthField(
                  label: "Email",
                  hintText: "Enter your email",
                  controller: emailController,
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email),
              const SizedBox(height: 20),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button background color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Rounded button corners
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Password reset link sent!")),
                    );
                  }
                },
                child: const Text("Send Reset Link"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
