import 'package:cric/common/helper/string_utils.dart';
import 'package:cric/presentation/auth/bloc/signin_cubit.dart';
import 'package:cric/presentation/auth/bloc/signin_state.dart';
import 'package:cric/presentation/auth/pages/signup.dart';
import 'package:cric/presentation/profile/pages/edit_profile_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_button/reactive_button.dart';

import '../../../common/bloc/validation/validation_cubit.dart';
import '../../../common/bloc/validation/validation_state.dart';
import '../../../common/helper/keys.dart';
import '../../../common/helper/message/display_message.dart';
import '../../../common/helper/navigation/app_navigation.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../data/auth/models/signin_req_params.dart';
import '../../../domain/auth/usecases/signin.dart';
import '../../../service_locator.dart';
import '../../home/home.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ValidationCubit>()),
        BlocProvider(create: (_) => sl<SignInCubit>())
      ],
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signInText(),
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
              _signInButton(context),
              const SizedBox(
                height: 20,
              ),
              _signupText(context)
            ],
          )
        ),
      ),
    );
  }

  Widget _signInText() {
    return const Text(
      signIn,
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

  Widget _signInButton(BuildContext context) {
    return BlocListener<ValidationCubit, ValidationState>(
      listener: (context, validationState) {
        if (validationState is ValidationSuccess) {
          context.read<SignInCubit>().signIn(
            _emailController.text,
            _passwordController.text,
          );
        }
      },
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            AppNavigator.pushAndRemove(context,  EditProfileScreen());
          } else if (state is SignInFailure) {
            DisplayMessage.errorMessage(state.error, context);
          }
        },
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 50,

            child: ElevatedButton(
              onPressed: () {
                context.read<ValidationCubit>().validate({
                  keyEmail: _emailController.text,
                  keyPassword: _passwordController.text,
                });
                // API call happens in BlocListener when ValidationSuccess is emitted
              },
              child: state is SignInLoading
                  ? const CircularProgressIndicator()
                  : const Text(signIn,style: TextStyle(color: Colors.white),),
            ),
          );
        },
      ),
    );
  }
  Widget _signupText(BuildContext context) {
    return Text.rich(TextSpan(children: [
      const TextSpan(text: dontHaveAnAcc),
      TextSpan(
          text: signUp,
          style: const TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.push(context, SignupPage());
            })
    ]));
  }
}
