part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccessState extends RegisterState {
  final User user;

  const RegisterSuccessState(this.user);
  @override
  List<Object> get props => [user];
}

class RegisterWrongCredintialState extends RegisterState {
  final String responseMessage;

  const RegisterWrongCredintialState(this.responseMessage);

  @override
  List<Object> get props => [responseMessage];
}

//error in validation
class RegisterValidationErrorState extends RegisterState {
  final String emailErrorMessag;
  final String passwordErrorMessag;
  final String nameErrorMessag;
  final String phoneErrorMessag;

  const RegisterValidationErrorState(this.emailErrorMessag,
      this.passwordErrorMessag, this.nameErrorMessag, this.phoneErrorMessag);

  @override
  List<Object> get props => [emailErrorMessag, passwordErrorMessag];
}
