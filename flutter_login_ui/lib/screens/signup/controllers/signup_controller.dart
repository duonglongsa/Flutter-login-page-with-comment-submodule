import 'package:flutter/cupertino.dart';
import 'package:flutter_login_ui/models/user_model.dart';
import 'package:get/get.dart';

class SignupController extends GetxController{
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final confirmPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassWordController = TextEditingController();

  UserModel user = UserModel('','');

  String validateEmail(String value){
    if (value.isEmpty) {
      return 'Enter something';
    } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }

  String validatePassword(String value){
    if(value.isEmpty){
      return 'Please enter password!';
    } else if(value.length < 6){
      return "Password must be at least 6 characters!";
    } else {
      return null;
    }
  }

  String validateConfirmPassword(String value){
    if(confirmPassWordController.text != user.password){
      return 'Password mismatch!';
    } else {
      return null;
    }
  }

  bool validateSignup(){
    if (emailFormKey.currentState.validate()
        && passwordFormKey.currentState.validate()
        && confirmPasswordFormKey.currentState.validate()) {
      return true;
    }
    return false;
  }

}