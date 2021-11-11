import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prayers_application/data/repositories/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  String emailErrorMessage = '';
  String passwordErrorMessage = '';

  UserRepository userRepository = UserRepository();

  Future login({required String email, required String password}) async {
    bool isFormValid = validationLoginData(email, password);
    User? user;
    if (isFormValid) {
      emit(LoginLoadingState());
      try {
        user = await userRepository.signInWithCredentials(email, password);
      } catch (error) {
        emit(LoginWrongCredintialState(error.toString()));
        return error;
      }
      emit(LoginSuccessState(user!));
    } else {
      emit(LoginValidationErrorState(emailErrorMessage, passwordErrorMessage));
    }
  }

  bool validationLoginData(String email, String password) {
    bool isemailValid = validateEmail(email);
    bool isPasswordValid = validatePassword(password);
    return isemailValid && isPasswordValid;
  }

  bool validatePassword(String password) {
    if (password.isEmpty || password == '') {
      passwordErrorMessage = "Please enter your password";
      //"الرجاء ادخال كلمة السر";
      return false;
    } else if (password.length < 6) {
      passwordErrorMessage = "Password must not be less than 6 characters";
      //"يجب ان لا تقل كلمة السر عن 6 احرف";
      return false;
    } else {
      passwordErrorMessage = '';
      return true;
    }
  }

  bool validateEmail(String email) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email.isEmpty || email == '') {
      emailErrorMessage = "Please enter your email";
      //"الرجاء الايميل الخاص بك";
      return false;
    } else if (!regex.hasMatch(email)) {
      emailErrorMessage = "Please enter the email correctly";
      //"الرجاء ادخال الايميل بشكل صحيح";
      return false;
    } else {
      emailErrorMessage = '';
      return true;
    }
  }
}
