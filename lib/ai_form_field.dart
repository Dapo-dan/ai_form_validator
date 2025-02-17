import 'package:flutter/material.dart';
import 'ai_form_validator.dart';

class AIFormField extends StatefulWidget {
  final String label;
  final String fieldType;
  final AIFormValidator validator;
  final TextEditingController controller;

  const AIFormField({
    super.key,
    required this.label,
    required this.fieldType,
    required this.validator,
    required this.controller,
  });

  @override
  State<AIFormField> createState() => _AIFormFieldState();
}

class _AIFormFieldState extends State<AIFormField> {
  String? errorMessage;

  void _validate() async {
    final validationMsg = await widget.validator.validateInput(
      fieldType: widget.fieldType,
      input: widget.controller.text,
    );
    setState(() {
      errorMessage = validationMsg;
    });
  }

  TextInputType _getKeyboardType() {
    switch (widget.fieldType) {
      case "email":
        return TextInputType.emailAddress;
      case "phone":
        return TextInputType.phone;
      case "address":
        return TextInputType.streetAddress;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextField(
          controller: widget.controller,
          keyboardType: _getKeyboardType(),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            errorText: errorMessage,
          ),
          onChanged: (_) => _validate(),
        ),
      ],
    );
  }
}
