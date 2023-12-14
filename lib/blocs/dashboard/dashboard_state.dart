part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final String data;
  const DashboardLoaded(this.data);
}

class DashboardFailure extends DashboardState {
  final String error;

  const DashboardFailure({required this.error});

  @override
  List<Object> get props => [error];
}
