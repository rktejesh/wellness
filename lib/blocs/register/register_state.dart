part of 'register_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final User user;
  const RegistrationSuccess({
    required this.user,
  });
}

class RegistrationFailure extends RegistrationState {
  final String error;

  const RegistrationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
