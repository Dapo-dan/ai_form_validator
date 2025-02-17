// library ai_form_validator;

import 'dart:convert';
import 'package:http/http.dart' as http;

class AIFormValidator {
  final String apiKey;

  AIFormValidator({required this.apiKey});

  Future<String?> validateInput({
    required String fieldType,
    required String input,
  }) async {
    if (input.isEmpty) return 'This field cannot be empty';

    final localValidation = _localValidation(fieldType, input);
    if (localValidation != null) return localValidation;

    return await _aiValidation(fieldType, input);
  }

  String? _localValidation(String fieldType, String input) {
    switch (fieldType) {
      case 'email':
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        return emailRegex.hasMatch(input) ? null : 'Invalid email format';
      case 'password':
        return input.length >= 6 ? null : 'Password must be at least 6 characters';
      case 'phone':
        final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
        return phoneRegex.hasMatch(input) ? null : 'Invalid phone number';
      default:
        return null;
    }
  }

  Future<String?> _aiValidation(String fieldType, String input) async {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions");
    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-4",
        "messages": [
          {"role": "system", "content": "You are a smart form validator."},
          {"role": "user", "content": "Validate this $fieldType: '$input'."}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      return "AI validation failed, please check your input.";
    }
  }
}
