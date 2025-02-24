import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/auth/models/base_response_model.dart';
import '../../../data/auth/models/signup_req_params.dart';
import '../../../service_locator.dart';
import '../repositories/auth.dart';


class SignupUseCase extends UseCase<dynamic,SignupReqParams> {
  
  @override
  Future<ApiResponse> call({SignupReqParams? params}) async {
    return await sl<AuthRepository>().signUp(params!);
  }
  
}