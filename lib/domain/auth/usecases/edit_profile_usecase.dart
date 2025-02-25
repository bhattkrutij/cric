

import 'package:cric/core/usecase/usecase.dart';
import 'package:cric/data/auth/models/base_response_model.dart';
import 'package:cric/data/auth/models/edit_profile_req_params.dart';
import 'package:cric/domain/auth/repositories/auth.dart';

import '../../../service_locator.dart';

class EditProfileUsecase extends UseCase<dynamic,EditProfileReqParams> {

  @override
  Future<ApiResponse> call({EditProfileReqParams? params}) async {
    return await sl<AuthRepository>().editProfile(params!);
  }

}