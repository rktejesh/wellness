part of 'register_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegistrationEvent {
  final Map<String, dynamic> formData;

  RegisterButtonPressed({required this.formData});

  @override
  List<Object> get props => [formData];
}
