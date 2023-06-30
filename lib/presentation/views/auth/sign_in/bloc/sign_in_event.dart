part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}


class SubmitForm extends SignInEvent{

  final String email;
  final String password;

  SubmitForm({
    required this.email,
    required this.password,
  });
}
