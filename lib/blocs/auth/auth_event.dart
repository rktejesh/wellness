part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthEvent {}

class AppLoading extends AuthEvent {}

class UserUpdated extends AuthEvent {
  const UserUpdated(this.item);

  final User item;

  @override
  List<Object> get props => [item];
}

class ChangAuthMethod extends AuthEvent {}

class LoggedOut extends AuthEvent {}
