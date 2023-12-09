import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wellness/data/api/api_helper.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/data/model/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // UserRepository userRepository;
  DioClient dioClient = DioClient.instance;
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      try {
        emit(LoginLoading());
        Map<String, dynamic> data = {
          'identifier': event.email,
          'password': event.password
        };
        User? user = await ApiService().loginUser(data);
        if (user != null) {
          emit(LoginSuccess(user: user));
        } else {
          emit(const LoginFailure(error: "Login failed"));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
