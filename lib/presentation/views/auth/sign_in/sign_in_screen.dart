import 'package:default_app/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injector/injector.dart';

import '../../../../core/constants/constants.dart';
import '../../../app/bloc/app_bloc.dart';
import '../../../shared/buttons.dart';
import '../../../shared/inputs.dart';
import '../../../shared/loader.dart';
import '../sign_up/sign_up_screen.dart';
import 'bloc/sign_in_bloc.dart';
import 'widgets/password_input.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static const String routeName = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(
          authRepository: Injector.appInstance.get(),
          sessionRepository: Injector.appInstance.get()),
      child: LoginScreenUI(),
    );
  }
}

class SignInScreenUI extends StatelessWidget {
  const SignInScreenUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'SignIn Screen',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreenUI extends StatelessWidget {
  LoginScreenUI({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginData = <String, String>{};
    const emailKey = 'email';
    const passwordKey = 'password';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<SignInBloc, SignInState>(
        listenWhen: (previous, current) => current is! SignInLoading,
        listener: (context, state) {
          if (state is SignInSuccess) {
            context.read<AppBloc>().add(
                  AuthenticatedUser(),
                );
          }
          if (state is SignInFailed) {
            // showError(context: context, desc: state.message);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SafeArea(
          child: Stack(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                padding: const EdgeInsets.all(kPadding),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Spacer(),
                      Text(
                        nameApp,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        'Iniciar sesión',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Spacer(),
                      GenericInput(
                        fieldKey: emailKey,
                        hintText: 'user',
                        dataMap: loginData,
                      ),
                      const SizedBox(height: kPadding),
                      PasswordInput(
                        fieldKey: passwordKey,
                        hintText: 'password',
                        dataMap: loginData,
                      ),
                      const SizedBox(height: kPadding),
                      BlocBuilder<SignInBloc, SignInState>(
                        builder: (context, state) {
                          if (state is SignInLoading) {
                            return const LoaderWidget();
                          }
                          return LargeButton(
                            text: 'Sign In',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<SignInBloc>().add(
                                      SubmitForm(
                                        email: loginData[emailKey] ?? '',
                                        password: loginData[passwordKey] ?? '',
                                      ),
                                    );
                              }
                            },
                          );
                        },
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                        ),
                        onTap: () {
                          GoRouter.of(context).goNamed(SignUpScreen.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: kPadding / 2,
                            horizontal: kPadding,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: 'Don\'t have an account?',
                              style: Theme.of(context).textTheme.bodySmall,
                              children: [
                                TextSpan(
                                  text: ' Sign up',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
