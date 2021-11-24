import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prayers_application/data/repositories/user_repository.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  String emailErrorMessage = '';
  String passwordErrorMessage = '';
  String phoneErrorMessage = '';
  String nameErrorMessage = '';

  UserRepository userRepository = UserRepository();

  Future sigUp(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    bool isFormValid = validationSignUpData(email, password, name, phone);
    User? user;
    if (isFormValid) {
      emit(RegisterLoadingState());
      try {
        user = await userRepository.signUp(
            email: email, password: password, name: name, phone: phone);
      } catch (error) {
        emit(RegisterWrongCredintialState(error.toString()));
        return error;
      }
      emit(RegisterSuccessState(user!));
    } else {
      emit(RegisterValidationErrorState(emailErrorMessage, passwordErrorMessage,
          nameErrorMessage, phoneErrorMessage));
    }
  }

  bool validationSignUpData(
      String email, String password, String name, String phone) {
    bool isPasswordValid = validatePassword(password);
    bool isemailValid = validateEmail(email);
    bool isphoneValid = validatephone(phone);
    bool isnameValid = validatename(name);
    return isemailValid && isPasswordValid && isphoneValid && isnameValid;
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

  bool validatephone(String phone) {
    if (phone.toString().isEmpty || phone.toString() == '') {
      phoneErrorMessage = "Please enter the phone number";
      // "الرجاء ادخال رقم الهاتف";
      return false;
    } else if (phone.toString().length < 9) {
      phoneErrorMessage = "Please enter the phone number correctly";
      //"الرجاء ادخال رقم الهاتف بشكل صحيح";
      return false;
    } else {
      phoneErrorMessage = '';
      return true;
    }
  }

  bool validatename(String phone) {
    if (phone.isEmpty) {
      nameErrorMessage = "Please enter username";
      // "الرجاء ادخال اسم المستخدم";
      return false;
    } else if (phone.length < 4) {
      nameErrorMessage = "Username must be at least 4 characters long";
      //"يجب ان لا يقل اسم المستخدم عن 4 احرف";
      return false;
    } else {
      nameErrorMessage = '';
      return true;
    }
  }
}
