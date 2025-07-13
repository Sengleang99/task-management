import 'package:flutter/material.dart';

// ignore: camel_case_types
class divider extends StatelessWidget {
  const divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
            child: Divider(color: Colors.grey)), // Divider line
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("OR",
              style: TextStyle(color: Colors.grey)), // "OR" text
        ),
        Expanded(
            child: Divider(color: Colors.grey)), // Divider line
      ],
    );
  }
}
