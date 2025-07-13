import 'package:flutter/material.dart';
import 'package:task/presentation/auth/widgets/divider.dart';
import 'package:task/presentation/auth/widgets/login_link.dart';
import 'package:task/presentation/auth/widgets/text_field.dart';
import 'package:task/utils/validator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // FocusNodes for each text field
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose all controllers and focus nodes to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (formKey.currentState?.validate() ?? false) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // Tapping outside the text fields will unfocus them and dismiss the keyboard
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey, // Assign the GlobalKey to the Form
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Login Account', // Changed title for Login screen
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  // Email input field
                  AuthField(
                    label: "Email",
                    hintText: "Enter your email",
                    controller: emailController,
                    focusNode: emailFocusNode, // Assign focus node
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 20),
                  // Password input field
                  AuthField(
                    label: "Password",
                    hintText: "Enter your password",
                    controller: passwordController,
                    focusNode: passwordFocusNode, // Assign focus node
                    isObscureText: true,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 30),
                  // Login button
                  ElevatedButton(
                    onPressed: _submitForm, // Call _submitForm on press
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Button background color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded button corners
                      ),
                    ),
                    child: const Text(
                      "Login", // Changed button text to Login
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white), // Button text style
                    ),
                  ),
                  // Forgot Password button
                  TextButton(
                    onPressed: () {
                      // Handle forgot password logic
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.blue), // Text button color
                    ),
                  ),
                  const SizedBox(height: 20),

                  // "OR" divider
                  const divider(),

                  const SizedBox(height: 20),
                  // Login with Google button
                  OutlinedButton.icon(
                    onPressed: () {
                      // Handle Google Login
                    },
                    icon: Image.asset(
                      'assets/icons/google-logo-icon-gsuite-hd-70175.png',
                      width: 28,
                    ),
                    label: const Text(
                      "Login with Google", // Changed button text to Login with Google
                      style: TextStyle(
                          color:
                              Colors.black87), // Text color for outlined button
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded button corners
                      ),
                      side:
                          const BorderSide(color: Colors.grey), // Border color
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  // Don't have an account? Register link
                  const LoginLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

