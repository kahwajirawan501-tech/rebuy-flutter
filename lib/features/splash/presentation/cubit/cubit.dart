import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:roasters/features/splash/presentation/cubit/states.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthLocalDataSource localDataSource;

  SplashCubit(this.localDataSource) : super(SplashInitial());

  void start() async {
    await Future.delayed(const Duration(seconds: 2));
    final token = await localDataSource.getToken();
    if (token != null) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
    emit(SplashCompleted());
  }
}