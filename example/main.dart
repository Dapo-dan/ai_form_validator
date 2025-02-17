import 'package:flutter/material.dart';
import 'package:ai_form_validator/ai_form_validator.dart';
import 'package:ai_form_validator/ai_form_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final AIFormValidator validator = AIFormValidator(apiKey: "YOUR_OPENAI_API_KEY");

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("AI Form Validator")),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              AIFormField(
                label: "Email",
                fieldType: "email",
                validator: validator,
                controller: emailController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
