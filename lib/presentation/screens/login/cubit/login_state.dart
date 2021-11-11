part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  final User user;

  const LoginSuccessState(this.user);
  @override
  List<Object> get props => [user];
}

class LoginWrongCredintialState extends LoginState {
  final String responseMessage;

  const LoginWrongCredintialState(this.responseMessage);

  @override
  List<Object> get props => [responseMessage];
}

//error in validation
class LoginValidationErrorState extends LoginState {
  final String emailErrorMessag;
  final String passwordErrorMessag;

  const LoginValidationErrorState(
      this.emailErrorMessag, this.passwordErrorMessag);

  @override
  List<Object> get props => [emailErrorMessag, passwordErrorMessag];
}
