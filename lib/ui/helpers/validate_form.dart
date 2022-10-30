import 'package:form_field_validator/form_field_validator.dart';

final validatedEmail = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: 'Enter a valid email')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(4, errorText: 'Minimum 4 characters')
]);
