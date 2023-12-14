import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wellness/data/api/api_service.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardFetchData>((event, emit) async {
      try {
        emit(DashboardLoading());
        String? profile = await ApiService().getProfile();
        if (profile != null) {
          emit(DashboardLoaded(profile));
        } else {
          emit(const DashboardFailure(error: ""));
        }
      } catch (e) {
        emit(DashboardFailure(error: e.toString()));
      }
    });
  }
}
