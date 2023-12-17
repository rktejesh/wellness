import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/data/model/user.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';

class RegisterFormBloc
    extends Bloc<RegistrationFormEvent, RegistrationFormState> {
  RegisterFormBloc() : super(RegistrationFormInitial()) {
    String _selectedUserType = '';

    on<RegisterUserTypeSelected>((event, emit) async {
      _selectedUserType = event.userType;
    });

    on<RegisterFormButtonPressed>((event, emit) async {
      try {
        emit(RegistrationFormLoading());
        Map<String, dynamic> data = event.formData;
        print(data);

        User? user = await ApiService().registerUser(data);
        if (user != null) {
          emit(RegistrationFormSuccess(user: user));
        } else {
          emit(const RegistrationFormFailure(error: ""));
        }
      } catch (e) {
        emit(RegistrationFormFailure(error: e.toString()));
      }
    });
  }
}
