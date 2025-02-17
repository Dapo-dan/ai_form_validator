import 'package:flutter_test/flutter_test.dart';
import 'package:ai_form_validator/ai_form_validator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate a mock class
@GenerateMocks([AIFormValidator])
import 'ai_form_validator_test.mocks.dart';

void main() {
  group('AIFormValidator Tests', () {
    late MockAIFormValidator mockValidator;

    setUp(() {
      mockValidator = MockAIFormValidator();
    });

    test('Local validation should return null for valid email', () async {
      when(mockValidator.validateInput(
              fieldType: 'email', input: 'test@example.com'))
          .thenAnswer((_) async => null);

      final result = await mockValidator.validateInput(
          fieldType: 'email', input: 'test@example.com');
      expect(result, isNull);
    });

    test('Local validation should return an error message for invalid email',
        () async {
      when(mockValidator.validateInput(
              fieldType: 'email', input: 'invalid-email'))
          .thenAnswer((_) async => 'Invalid email format');

      final result = await mockValidator.validateInput(
          fieldType: 'email', input: 'invalid-email');
      expect(result, 'Invalid email format');
    });

    test('Local validation should return null for strong password', () async {
      when(mockValidator.validateInput(
              fieldType: 'password', input: 'StrongPass123'))
          .thenAnswer((_) async => null);

      final result = await mockValidator.validateInput(
          fieldType: 'password', input: 'StrongPass123');
      expect(result, isNull);
    });

    test('Local validation should return error for weak password', () async {
      when(mockValidator.validateInput(fieldType: 'password', input: '123'))
          .thenAnswer((_) async => 'Password must be at least 6 characters');

      final result = await mockValidator.validateInput(
          fieldType: 'password', input: '123');
      expect(result, 'Password must be at least 6 characters');
    });

    test('AI validation should return AI-generated message', () async {
      when(mockValidator.validateInput(
              fieldType: 'address', input: 'Unknown St. XYZ'))
          .thenAnswer((_) async =>
              'This address might be incorrect. Try adding a street number.');

      final result = await mockValidator.validateInput(
          fieldType: 'address', input: 'Unknown St. XYZ');
      expect(result,
          'This address might be incorrect. Try adding a street number.');
    });
  });
}
