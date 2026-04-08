import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/features/auth/domain/usecases/verification_uscase.dart';
import 'package:roasters/features/auth/presentation/cubit/verification_cubit/state.dart';

class VerificationCubit extends Cubit<VerificationState>{
  final VerificationUsCase verificationUsCase;
  VerificationCubit(this.verificationUsCase):super(VerificationInitial());
  Future<void>verifyEmail({
    required String email,
    required String code,
})async{
    emit(VerificationLoading());

    try {
      final user = await verificationUsCase(
        email: email,
        code: code
      );

      emit(VerificationSuccess("verification_success"));
    } catch (e) {
      emit(VerificationError(e.toString()));
    }
}
}