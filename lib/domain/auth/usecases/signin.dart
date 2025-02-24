import 'package:cric/data/auth/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../common/helper/Failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../data/auth/models/base_response_model.dart';
import '../../../data/auth/models/signin_req_params.dart';
import '../../../service_locator.dart';
import '../repositories/auth.dart';


class SigninUseCase extends UseCase<dynamic,SignInReqParams> {

  @override
  Future<ApiResponse> call({SignInReqParams? params}) async {
    return await sl<AuthRepository>().signIn(params!);
  }
  
}