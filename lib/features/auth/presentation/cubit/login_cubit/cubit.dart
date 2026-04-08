import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/features/auth/domain/usecases/login_usecase.dart';
import 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      final user = await loginUseCase(
        email: email,
        password: password,
      );

      emit(LoginSuccess("login_success"));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}