import 'package:cric/common/bloc/validation/validation_cubit.dart';
import 'package:cric/common/bloc/validation/validation_state.dart';
import 'package:cric/common/helper/keys.dart';
import 'package:cric/common/helper/string_utils.dart';
import 'package:cric/presentation/auth/bloc/signup_cubit.dart';
import 'package:cric/presentation/auth/bloc/signup_state.dart';
import 'package:cric/presentation/auth/pages/signin.dart';
import 'package:cric/presentation/profile/edit_profile_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_button/reactive_button.dart';

import '../../../common/helper/message/display_message.dart';
import '../../../common/helper/navigation/app_navigation.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../data/auth/models/signup_req_params.dart';
import '../../../domain/auth/usecases/signup.dart';
import '../../../service_locator.dart';
import '../../home/home.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<SignUpCubit>()), BlocProvider(create: (_) => sl<ValidationCubit>())],
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signupText(),
              const SizedBox(
                height: 30,
              ),
              _emailField(),
              const SizedBox(
                height: 20,
              ),
              _passwordField(),
              const SizedBox(
                height: 60,
              ),
              _signupButton(context),
              const SizedBox(
                height: 20,
              ),
              _signinText(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupText() {
    return const Text(
      signUp,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }

  Widget _emailField() {
    return BlocBuilder<ValidationCubit, ValidationState>(
      builder: (context, state) {
        String? error;
        if (state is ValidationError) {
          error = state.errors[keyEmail];
        }
        return TextField(
          controller: _emailController,
          decoration: InputDecoration(hintText: email, errorText: error),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<ValidationCubit, ValidationState>(
      builder: (context, state) {
        String? error;
        if (state is ValidationError) {
          error = state.errors[keyPassword];
        }
        return TextField(
          controller: _passwordController,
          decoration: InputDecoration(hintText: password, errorText: error),
        );
      },
    );
  }

  Widget _signupButton(BuildContext context) {
    return BlocListener<ValidationCubit, ValidationState>(
      listener: (context, validationState) {
        if (validationState is ValidationSuccess) {
          context.read<SignUpCubit>().signUp(_emailController.text, _passwordController.text);
        }
      },
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            AppNavigator.pushAndRemove(context, const EditProfileScreen());
          } else if (state is SignUpFailure) {
            DisplayMessage.errorMessage(state.error, context);
          }
        },
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 50,

            child: ElevatedButton(
              onPressed: () {
                context.read<ValidationCubit>().validate({
                  keyEmail: _emailController.text,
                  keyPassword: _passwordController.text,
                });
                // API call happens in BlocListener when ValidationSuccess is emitted
              },
              child: state is SignUpLoading
                  ? const CircularProgressIndicator()
                  : const Text(signIn, style: TextStyle(color: Colors.white),),
            ),
          );
        },
      ),
    );
  }

  Widget _signinText(BuildContext context) {
    return Text.rich(TextSpan(children: [
      const TextSpan(text: dontHaveAnAcc),
      TextSpan(
          text: signIn,
          style: const TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.push(context, SignInPage());
            })
    ]));
  }
}
