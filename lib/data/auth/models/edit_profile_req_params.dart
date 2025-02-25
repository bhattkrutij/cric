import '../../../common/helper/keys.dart';

class EditProfileReqParams {
  final String name;
  final String gender;
  final String role;
  final String birthday;
  EditProfileReqParams( {
    required this.name,
    required this.gender,
    required this.role,
    required this.birthday,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      keyName: name,
      keyGender: gender,
      keyRole: role,
      keyBirthday: birthday,
    };
  }
}