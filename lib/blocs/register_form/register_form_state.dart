part of 'register_form_bloc.dart';

abstract class RegistrationFormState extends Equatable {
  const RegistrationFormState();

  @override
  List<Object> get props => [];
}

class RegistrationFormInitial extends RegistrationFormState {}

class RegistrationFormLoading extends RegistrationFormState {}

class RegistrationFormSuccess extends RegistrationFormState {
  final User user;
  const RegistrationFormSuccess({
    required this.user,
  });
}

class RegistrationFormFailure extends RegistrationFormState {
  final String error;

  const RegistrationFormFailure({required this.error});

  @override
  List<Object> get props => [error];
}
