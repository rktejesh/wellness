import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/data/model/user.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';

class RegisterFormBloc
    extends Bloc<RegistrationFormEvent, RegistrationFormState> {
  RegisterFormBloc() : super(RegistrationFormInitial()) {
    String selectedUserType = '';

    on<RegisterUserTypeSelected>((event, emit) async {
      selectedUserType = event.userType;
    });

    on<RegisterFormButtonPressed>((event, emit) async {
      try {
        emit(RegistrationFormLoading());
        Map<String, dynamic> data = event.formData;
        print(data);

        // String? res = await ApiService().setProfile(data, selectedUserType);
        // if (res != null) {
        //   emit(RegistrationFormSuccess(res: res));
        // } else {
        //   emit(const RegistrationFormFailure(error: ""));
        // }
      } catch (e) {
        emit(RegistrationFormFailure(error: e.toString()));
      }
    });
  }
}
