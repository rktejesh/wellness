import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wellness/data/api/api_helper.dart';
import 'package:wellness/data/model/user.dart';
import 'package:wellness/data/repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;
  DioClient dioClient;
  AuthBloc({required this.userRepository, required this.dioClient})
      : super(AuthInitial()) {
    on<AppLoaded>((event, emit) async {
      try {
        emit(LoadingAuthenticationState());
        bool isSignedIn = await userRepository.isSignedIn();
        if (isSignedIn) {
          User user = await userRepository.getCurrentUser();
          emit(AuthenticatedState(user: user));
          print('block says user is authenticated');
        } else {
          emit(UnauthenticatedLoginState());
          print('block says user is NOT authenticated');
        }
      } catch (e) {
        emit(ErrorAuthenticationState());
      }
    });

    on<UserUpdated>((event, emit) async {
      try {
        await userRepository.updateCurrentUser(event.item);
        emit(AuthenticatedState(user: event.item));
      } catch (e) {
        print(e);
      }
    });

    on<AppLoading>((event, emit) async {
      try {
        emit(LoadingAuthenticationState());
      } catch (e) {
        print(e);
      }
    });

    on<LoggedOut>((event, emit) async {
      try {
        await userRepository.signOut();
        emit(UnauthenticatedLoginState());
      } catch (e) {
        print(e);
      }
    });

    on<ChangAuthMethod>((event, emit) async {
      try {
        if (state is UnauthenticatedLoginState) {
          emit(UnauthenticatedRegisterState());
        } else {
          emit(UnauthenticatedLoginState());
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
