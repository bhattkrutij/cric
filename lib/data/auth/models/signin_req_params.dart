// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../common/helper/keys.dart';

class SignInReqParams {
  final String email;
  final String password;
 SignInReqParams({
    required this.email,
    required this.password
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      keyEmail: email,
      keyPassword: password,
    };
  }
}
