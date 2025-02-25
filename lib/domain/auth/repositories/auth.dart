import 'package:cric/data/auth/models/edit_profile_req_params.dart';
import 'package:cric/domain/auth/usecases/edit_profile_usecase.dart';
import 'package:dartz/dartz.dart';


import '../../../data/auth/models/base_response_model.dart';
import '../../../data/auth/models/signin_req_params.dart';
import '../../../data/auth/models/signup_req_params.dart';

abstract class AuthRepository {

  Future<ApiResponse>signUp(SignupReqParams params);
  Future<ApiResponse> signIn(SignInReqParams params);
  Future<ApiResponse> editProfile(EditProfileReqParams params);
  Future<bool> isLoggedIn();
}