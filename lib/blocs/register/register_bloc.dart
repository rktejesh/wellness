import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/data/model/user.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegisterBloc() : super(RegistrationInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      try {
        emit(RegistrationLoading());
        Map<String, dynamic> data = event.formData;
        User? user = await ApiService().registerUser(data);
        if (user != null) {
          emit(RegistrationSuccess(user: user));
        } else {
          emit(const RegistrationFailure(error: ""));
        }
      } catch (e) {
        emit(RegistrationFailure(error: e.toString()));
      }
    });
  }
}
