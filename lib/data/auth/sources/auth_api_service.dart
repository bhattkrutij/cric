import 'package:cric/common/helper/keys.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/api_url.dart';
import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';
import '../models/base_response_model.dart';
import '../models/signin_req_params.dart';
import '../models/signup_req_params.dart';


abstract class AuthService {

   Future<ApiResponse> signUp(SignupReqParams params);


  Future<ApiResponse> signIn(SignInReqParams params);
}


class AuthApiServiceImpl extends AuthService {


  // @override
  // Future<Either> signUp(SignupReqParams params) async {
  //   try {
  //
  //     var response = await sl<DioClient>().post(
  //         ApiUrl.signup,
  //       data: params.toMap()
  //     );
  //     return Right(response);
  //
  //   } on DioException catch(e) {
  //     print("---------catch------${e.toString()}");
  //     return Left(e.response!.data[keyMessage]);
  //   }
  // }
  @override
  Future<ApiResponse> signUp(SignupReqParams params) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.signup,
        data: params.toMap(),
      );

      return ApiResponse.fromJson(response.data); // Success response
    } on DioException catch (e) {
      print("---------catch------${e.toString()}");

      String errorMessage = e.response?.data['message'] ?? 'Something went wrong';
      return ApiResponse.error(errorMessage); // Error response
    }
  }



  @override
  Future<ApiResponse> signIn(SignInReqParams params) async {
     try {

      var response = await sl<DioClient>().post(
        ApiUrl.signin,
        data: params.toMap()
      );
      print("status code${response.statusCode}");
      return ApiResponse.fromJson(response.data); // Extract `.data`

    } on DioException catch(e) {
       print("---------catch------${e.response}----${e.response!.statusCode}");
       String errorMessage = e.response?.data?['message'] ?? 'Something went wrong';
       return ApiResponse.error(errorMessage);
    }
  }


}