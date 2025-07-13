import 'package:flutter/material.dart';

// This is the custom AuthField widget.
// It encapsulates the common styling and validation logic for text input fields.
class AuthField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode; // Added FocusNode

  const AuthField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.focusNode, // Initialize FocusNode
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final showToggleIcon = widget.isObscureText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode, // Assign the FocusNode
          keyboardType: widget.keyboardType,
          obscureText: showToggleIcon ? _obscure : false,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)), // Added rounded corners
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.blue, width: 2), // Highlight on focus
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            suffixIcon: showToggleIcon
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey[600], // Icon color
                    ),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
