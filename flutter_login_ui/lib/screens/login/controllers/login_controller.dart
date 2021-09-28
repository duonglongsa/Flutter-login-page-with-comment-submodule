import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_ui/models/user_model.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  UserModel user = new UserModel('','');
  bool rememberMe = false;

  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscureText = true;

  void initUser(UserCredential userCredential){
    user.id = userCredential.user.uid;
    user.name = userCredential.user.displayName;
    user.phoneNumber = userCredential.user.phoneNumber;
    user.photoUrl = userCredential.user.photoURL;
  }

  void rememberPassword(bool value){
    rememberMe = value;
    update();
  }

  void obscurePassword(){
    obscureText = !obscureText;
    update();
  }

  void getUser(){
    user.email = emailController.text;
    user.password = passwordController.text;
  }

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

}