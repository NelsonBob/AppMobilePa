// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/data/storage/secure_storage.dart';
import 'package:flutter_application_1/domain/services/auth_services.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<OnLoginEvent>(_onLogin);
    on<OnCheckingLoginEvent>(_onCheckingLogin);
    on<OnLogOutEvent>(_onLogOut);
  }

  Future<void> _onLogin(OnLoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingAuthentication());

      final data = await authServices.login(event.email, event.password);

      await Future.delayed(const Duration(milliseconds: 2000));

      if (data.token != null) {
        await secureStorage.deleteSecureStorage();

        await secureStorage.persistenToken(data.token!);

        emit(SuccessAuthentication());
      } else {
        emit(FailureAuthentication(data.message));
      }
    } catch (e) {
      emit(FailureAuthentication(e.toString()));
    }
  }

  Future<void> _onCheckingLogin(
      OnCheckingLoginEvent event, Emitter<AuthState> emit) async {
    try {
      await Future.delayed(const Duration(milliseconds: 850));

      if (await secureStorage.readToken() != null) {
        final data = await authServices.renewLogin();

        if (data.token != null) {
          await secureStorage.persistenToken(data.token!);

          emit(SuccessAuthentication());
        } else {
          await secureStorage.deleteSecureStorage();
          emit(LogOut());
        }
      } else {
        await secureStorage.deleteSecureStorage();
        emit(LogOut());
      }
    } catch (e) {
      await secureStorage.deleteSecureStorage();
      emit(LogOut());
    }
  }

  Future<void> _onLogOut(OnLogOutEvent event, Emitter<AuthState> emit) async {
    await secureStorage.deleteSecureStorage();
    emit(LogOut());
  }
}
