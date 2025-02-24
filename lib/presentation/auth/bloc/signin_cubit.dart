import 'package:cric/presentation/auth/bloc/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/auth/models/base_response_model.dart';
import '../../../data/auth/models/signin_req_params.dart';
import '../../../domain/auth/usecases/signin.dart';
import '../../../service_locator.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  Future<void> signIn(String email, String password) async {
    emit(SignInLoading());
    try {
      ApiResponse response = await sl<SigninUseCase>().call(
        params: SignInReqParams(email: email, password: password),
      );
      if (response.success) {
        emit(SignInSuccess());
      } else {
        emit(SignInFailure(response.message)); // Show API error message
      }
    } catch (error) {
      emit(SignInFailure(error.toString()));
    }
  }
}
