import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/bloc/validation/validation_state.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());
  void validate(Map<String, String> fields) {
    final Map<String, String> errors = {};
    fields.forEach((key, value) {
      if (value.isEmpty) {
        errors[key] = "$key is required";
      } else if (key == "name" && value.length < 3) {
        errors[key] = "Name must be 3 characters atleast";
      }
      // Validate gender dropdown
      if (!fields.containsKey("gender") || fields["gender"] == null || fields["gender"]!.isEmpty) {
        errors["gender"] = "Gender is required";
      } print(errors["gender"]);
      // Validate role dropdown
      if (!fields.containsKey("role") || fields["role"] == null || fields["role"]!.isEmpty) {
        errors["role"] = "Role is required";
        print(errors["role"]);
      }
    });
    if (errors.isNotEmpty) {
      emit(EditProfileValidationFailure(errors));
    } else {
      emit(EditProfileValidationSuccess());
    }
  }
}
