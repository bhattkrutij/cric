
import 'package:cric/common/bloc/validation/validation_state.dart';
import 'package:cric/common/helper/keys.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidationCubit extends Cubit<ValidationState>{
   ValidationCubit() : super(ValidationInitial());
   void validate(Map<String,String>fields){
     final Map<String, String> errors = {};

     fields.forEach((key, value) {
       if (value.isEmpty) {
         errors[key] = "$key is required";
       } else if (key == keyEmail && !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
         errors[key] = "Enter a valid email";
       } else if (key == keyPassword && value.length < 6) {
         errors[key] = "Password must be at least 6 characters";
       }
     });

     if (errors.isNotEmpty) {
       emit(ValidationError(errors));
     } else {
       emit(ValidationSuccess());
     }
   }
   }

