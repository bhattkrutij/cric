import 'package:cric/data/auth/models/signup_req_params.dart';
import 'package:cric/domain/auth/usecases/signup.dart';
import 'package:cric/presentation/auth/bloc/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/auth/models/base_response_model.dart';
import '../../../service_locator.dart';

class SignUpCubit extends Cubit<SignUpState>{
  SignUpCubit():super(SignUpInitial());
  Future<void> signUp(String email, String password) async {
    emit(SignUpLoading());
    try {
      ApiResponse response = await sl<SignupUseCase>().call(
        params: SignupReqParams(email: email, password: password),
      );
      if (response.success) {
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure(response.message)); // Show API error message
      }
    } catch (error) {
      emit(SignUpFailure(error.toString()));
    }
  }
}