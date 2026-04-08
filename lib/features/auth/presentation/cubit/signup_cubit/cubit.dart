import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/features/auth/domain/usecases/signup_usecase.dart';
import 'package:roasters/features/auth/presentation/cubit/signup_cubit/state.dart';

class SignUpCubit extends Cubit<SignUpState>{
 final SignupUseCase signupUseCase;
 SignUpCubit(this.signupUseCase):super(SignUpInitial());
 Future <void> SignUp({
   required String name,
   required String role,
   required String phone,
   required String email,
   required String password,
})async{
   emit(SignUpLoading());
   try {
     final message = await signupUseCase(
       name: name,
       phone: phone,
       email: email,
       password: password,
       role: role
     );

     emit(SignUpSuccess(("signup_success")));
   } catch (e) {
     emit(SignUpError(e.toString()));
   }
 }
}