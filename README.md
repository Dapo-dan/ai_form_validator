### **📂 `README.md`**

````md
# AI Form Validator 🧠 ✅

An AI-powered form validator for Flutter. Supports **email, phone numbers, addresses**, and more using **local validation + AI-powered suggestions**.

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  ai_form_validator: ^1.0.0
```
````

Run:

```sh
flutter pub get
```

## 🚀 **Usage**

### **1️⃣ Initialize the Validator**

```dart
final AIFormValidator validator = AIFormValidator(apiKey: "YOUR_OPENAI_API_KEY");
```

### **2️⃣ Use AIFormField in Your App**

```dart
AIFormField(
  label: "Email",
  fieldType: "email",
  validator: validator,
  controller: TextEditingController(),
);
```

## 🎯 **Features**

✔️ Supports **email, phone numbers, and addresses**.  
✔️ Provides **real-time AI-based validation**.  
✔️ Uses **flutter_secure_storage** to store API keys securely.  
✔️ **Customizable** and **easy to integrate**.

## 🔒 **Secure Your API Key**

To keep your API key safe, store it securely:

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

await storage.write(key: 'openai_api_key', value: "YOUR_SECRET_API_KEY");

String? apiKey = await storage.read(key: 'openai_api_key');
```

## 🎉 **Example App**

Check out a complete example in `example/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:ai_form_validator/ai_form_validator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AIFormValidator validator = AIFormValidator(apiKey: "YOUR_OPENAI_API_KEY");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: AIFormField(
            label: "Phone Number",
            fieldType: "phone",
            validator: validator,
            controller: TextEditingController(),
          ),
        ),
      ),
    );
  }
}
```

## 🛠 **Upcoming Features**

- ✅ More AI-based validation types.
- ✅ Auto-correction of invalid inputs.
- ✅ Multi-language support.

**📢 Contributions are welcome!**  
Star ⭐ the repo and feel free to submit PRs!

## 📝 **License**

MIT License. Free to use and modify.
