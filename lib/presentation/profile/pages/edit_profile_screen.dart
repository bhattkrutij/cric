import 'package:cric/common/helper/message/display_message.dart';
import 'package:cric/presentation/home/home.dart';
import 'package:cric/presentation/profile/bloc/edit_profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../common/helper/app_theme_calender.dart';
import '../../../common/helper/navigation/app_navigation.dart';
import '../../../common/helper/string_utils.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../service_locator.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _birthDayTextEditingController = TextEditingController();
  String? selectedRole;
  String? selectedGender;
  String? bdate;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<EditProfileCubit>())],
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
          child: Column(children: [
            _signupText(),
            const SizedBox(height: 30),
            _nameController(),
            const SizedBox(height: 30),
            _genderDropDown(),
            const SizedBox(height: 30),
            _roleDropDown(),
            const SizedBox(height: 30),
            _birthDayController(),
            const SizedBox(height: 30),
            _ediProfileButton(context),
          ]),
        ),
      ),
    );
  }

  Widget _signupText() {
    return const Text(
      editProfile,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }

  Widget _nameController() {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        String? error;
        if (state is EditProfileValidationFailure) {
          error = state.errors["name"];
        }
        return TextField(
          controller: _nameTextEditingController,
          decoration: InputDecoration(hintText: name, errorText: error),
        );
      },
    );
  }

  Widget _genderDropDown() {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        String? error;
        if (state is EditProfileValidationFailure) {
          error = state.errors["gender"];
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: "Select Gender",
                errorText: error, // Show validation error
              ),

              value: selectedGender, // Current selected value
              items: ["Male", "Female"]
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (value) {
                selectedGender = value; // Update local state
              },
            ),
          ],
        );
      },
    );
  }

  Widget _roleDropDown() {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        String? error;

        if (state is EditProfileValidationFailure) {
          error = state.errors["role"];
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: "Select Role",
                errorText: error, // Show validation error
              ),
              value: selectedRole, // Current selected value
              items: ["Batsman", "Bowler", "Wicket keeper"]
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                  .toList(),
              onChanged: (value) {
                selectedRole = value; // Update local state
              },
            ),
          ],
        );
      },
    );
  }

  Widget _birthDayController() {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        String? error;
        if (state is EditProfileValidationFailure) {
          error = state.errors["birthDate"];
          print("error");
        }
        return TextField(
            controller: _birthDayTextEditingController,
            decoration: InputDecoration(hintText: birthDate, errorText: error),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: commonAppThemeForCalender(),
                    child: child ?? Text(""),
                  );
                },
                initialDate: DateTime.now(),
                firstDate: DateTime(1960),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                _birthDayTextEditingController.text =
                    DateFormat('yyyy-MM-dd').format(picked); // Format date as yyyy-MM-dd
              }
            });
      },
    );
  }

  Widget _ediProfileButton(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileValidationSuccess) {
       //   DisplayMessage.errorMessage("validation sucess", context);
          print("req${_nameTextEditingController.text}--_${selectedGender}--${selectedRole}----${_birthDayTextEditingController.text}");
          context.read<EditProfileCubit>().updateUser(
              name: _nameTextEditingController.text, role: selectedRole, gender: selectedGender, birthday: _birthDayTextEditingController.text);
        }
        if (state is EditProfileSuccess) {
          print("----res${state.message}");
          DisplayMessage.errorMessage(state.message, context);
          AppNavigator.pushReplacement(context, HomePage());

        }
      },
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              context.read<EditProfileCubit>().validate({
                "name": _nameTextEditingController.text,
                "role": selectedRole ?? "",
                "gender": selectedGender ?? "",
                "birthDate": _birthDayTextEditingController.text ?? "",
              });
              // API call happens in BlocListener when ValidationSuccess is emitted
            },
            child: (state is EditProfileLoading)  ?CircularProgressIndicator(color: Colors.white,) :  Text(
              signUp,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
