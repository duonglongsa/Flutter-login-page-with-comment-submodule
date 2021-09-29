import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_ui/models/user_model.dart';
import 'package:flutter_login_ui/services/firebase_services.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{

  List<String> gender = ['Male', 'Female', 'Others'];
  int genderIndex;

  UserModel user = UserModel('','');

  bool isEditing = false;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController avatarUrlController = new TextEditingController();

  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }


  void init(UserModel user) async {
    this.user = user;
    emailController.text = user.email;
    passwordController.text = user.password;
    nameController.text = user.name;
    phoneController.text = user.phoneNumber;
    user.photoUrl = await photoUrl(user.id);

  }

  void editUser(){
    user.email = emailController.text;
    user.password = passwordController.text;
    user.name = nameController.text;
    user.phoneNumber = phoneController.text;
  }

  void pressEditBtn(){
    isEditing = true;
    update();
  }

  void pressOKBtn(){
    isEditing = false;
    update();
  }

  void pressCancelBtn(){
    isEditing = false;
    nameController.text = user.name;
    phoneController.text = user.phoneNumber;
    emailController.text = user.email;
    passwordController.text = user.password;
    avatarUrlController.text = user.photoUrl;
    this.isValidProfile();
    update();
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

  String validatePassword(String value){
    if(value.isEmpty){
      return 'Please enter password!';
    } else if(value.length < 6){
      return "Password must be at least 6 characters!";
    } else {
      return null;
    }
  }

  void setAvatarUrl(){
    update();
  }

  bool isValidProfile(){
    return emailFormKey.currentState.validate() && passwordFormKey.currentState.validate();
  }

}