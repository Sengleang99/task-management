import 'package:flutter/material.dart';
import 'package:task/presentation/auth/widgets/divider.dart';
import 'package:task/presentation/auth/widgets/signup_link.dart';
import 'package:task/presentation/auth/widgets/text_field.dart';
import 'package:task/utils/validator.dart'; // Assuming this path for AuthField

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  // FocusNodes for each text field
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose all controllers and focus nodes to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    nameFocusNode.dispose();
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
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Create an Account',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  // Name input field
                  AuthField(
                    label: "Name",
                    hintText: "Enter your name",
                    controller: nameController,
                    focusNode: nameFocusNode,
                    validator: (value) => Validators.required(value, "Name"),
                  ),
                  const SizedBox(height: 20),
                  // Email input field
                  AuthField(
                      label: "Email",
                      hintText: "Enter your email",
                      controller: emailController,
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.email),
                  const SizedBox(height: 20),
                  // Password input field
                  AuthField(
                      label: "Password",
                      hintText: "Enter your password",
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      isObscureText: true,
                      validator: Validators.password),
                  const SizedBox(height: 30),
                  // Sign Up button
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
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white), // Button text style
                    ),
                  ),
                  const SizedBox(height: 20),
                  // "OR" divider
                  const divider(),

                  const SizedBox(height: 20),
                  // Sign Up with Google button
                  OutlinedButton.icon(
                    onPressed: () {
                      // Handle Google Sign Up
                    },
                    icon: Image.asset(
                      'assets/icons/google-logo-icon-gsuite-hd-70175.png',
                      width: 28,
                    ),
                    label: const Text(
                      "Sign Up with Google",
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
                  // Already have an account? Login link
                  const SignUpLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

