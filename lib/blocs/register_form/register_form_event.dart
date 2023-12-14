part of 'register_form_bloc.dart';

abstract class RegistrationFormEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterUserTypeSelected extends RegistrationFormEvent {
  final String userType;

  RegisterUserTypeSelected(this.userType);

  @override
  List<Object> get props => [userType];
}

class RegisterFormButtonPressed extends RegistrationFormEvent {
  final Map<String, dynamic> formData;

  RegisterFormButtonPressed({required this.formData});

  @override
  List<Object> get props => [formData];
}
