import 'package:cric/common/helper/keys.dart';
import 'package:cric/data/auth/models/edit_profile_req_params.dart';
import 'package:cric/domain/auth/usecases/edit_profile_usecase.dart';
import 'package:dartz/dartz.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/helper/Failure.dart';
import '../../../domain/auth/repositories/auth.dart';
import '../../../service_locator.dart';
import '../models/base_response_model.dart';
import '../models/signin_req_params.dart';
import '../models/signup_req_params.dart';
import '../sources/auth_api_service.dart';

class AuthRepositoryImpl extends AuthRepository {


  @override
  Future<ApiResponse> signUp(SignupReqParams params) async {
    var data = await sl<AuthService>().signUp(params);
    if (data.success) {
      // Save token to SharedPreferences
      sl<SharedPreferences>().setString(keyToken, data.data[keyToken]);
    }

    return data;
  }

  @override
  Future<ApiResponse> signIn(SignInReqParams params) async {
    var data = await sl<AuthService>().signIn(params);
    if (data.success) {
      // Save token to SharedPreferences
      sl<SharedPreferences>().setString(keyToken, data.data[keyToken]);
    }

    return data;
  }

  @override
  Future<bool> isLoggedIn() async {
    var token =   sl<SharedPreferences>().getString(keyToken);
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<ApiResponse> editProfile(EditProfileReqParams params) async {
    print("tttttt${params}");
  var data = await sl<AuthService>().editProfile(params!);

    return data;

  }


}