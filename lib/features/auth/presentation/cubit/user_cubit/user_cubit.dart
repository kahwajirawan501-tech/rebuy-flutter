import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/features/auth/domain/entities/user_entity.dart';
import 'package:roasters/features/auth/domain/usecases/get_user_usecase.dart';

class UserCubit extends Cubit<User?> {
  final GetUserUseCase getUser;

  UserCubit(this.getUser) : super(null);

  Future<void> loadUser() async {
    final user = await getUser();
    emit(user);
  }
}