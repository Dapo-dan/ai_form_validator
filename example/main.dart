import 'package:ai_form_validator/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:ai_form_validator/ai_form_validator.dart';
import 'package:ai_form_validator/ai_form_field.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? apiKey = await SecureStorage.getApiKey();

  if (apiKey == null) {
    apiKey = "YOUR_OPENAI_API_KEY"; // Replace with real key
    await SecureStorage.saveApiKey(apiKey);
  }

  runApp(MyApp(apiKey: apiKey));
}

class MyApp extends StatelessWidget {
  final String apiKey;

  MyApp({super.key, required this.apiKey});

  final TextEditingController emailController = TextEditingController();
  final AIFormValidator validator =
      AIFormValidator(apiKey: "YOUR_OPENAI_API_KEY");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("AI Form Validator Secure Example")),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String? result = await validator.validateInput(
                    fieldType: "email",
                    input: emailController.text,
                  );
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result ?? "Valid email!")),
                  );
                },
                child: Text("Validate"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
