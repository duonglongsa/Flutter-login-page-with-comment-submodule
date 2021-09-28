import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_login_ui/screens/signup/controllers/signup_controller.dart';
import 'package:flutter_login_ui/utilities/style_constants.dart';
import 'package:flutter_login_ui/services/firebase_services.dart';

import 'package:get/get.dart';

Widget buildSignupEmailTF(SignupController signupController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Email',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      Form(
        key: signupController.emailFormKey,
        child: TextFormField(
          controller: TextEditingController(text: signupController.user.email),
          onChanged: (value) {
            signupController.user.email = value;
          },
          validator: (value) => signupController.validateEmail(value),
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: emailInputDecoration,
        ),
      ),

    ],
  );
}

Widget buildSignupPasswordTF(SignupController signupController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Password',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      Form(
        key: signupController.passwordFormKey,
        child: TextFormField(
          controller: signupController.passwordController,
          obscureText: true,
          onChanged: (value) {
            signupController.user.password = value;
          },
          validator: (value)=> signupController.validatePassword(value),
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: passwordInputDecoration,
        ),
      ),
    ],
  );
}

Widget buildConfirmPasswordTF(SignupController signupController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Confirm Password',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      Form(
        key: signupController.confirmPasswordFormKey,
        child: TextFormField(
          controller: signupController.confirmPassWordController,
          obscureText: true,
          validator: (value) => signupController.validateConfirmPassword(value),
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: passwordInputDecoration,
        ),
      ),
    ],
  );
}

Widget buildRegisterBtn(SignupController signupController) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    // ignore: deprecated_member_use
    child: RaisedButton(
      elevation: 5.0,
      onPressed: () async {
        if (signupController.validateSignup()) {
          await firebaseRegister(signupController);
          /*var statusCode = await register(signupController);
          if(statusCode == 200) {
            Get.defaultDialog(
                title: 'Successful register',
                middleText: 'Back to login page?',
                textConfirm: 'OK',
                onConfirm: (){
                  Get.back();
                },
                textCancel: 'Cancel',
                onCancel: (){
                }
            );
          } else {
            Get.defaultDialog(
                title: 'Fail to register',
                middleText: 'Email was used!',
                textConfirm: 'OK',
                onConfirm: (){
                  Get.back();
                },
            );
          }*/
        }
      },
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      child: Text(
        'REGISTER',
        style: TextStyle(
          color: Color(0xFF527DAA),
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    ),
  );
}

Widget buildBackToLoginBtn() {
  return GestureDetector(
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Have an Account? ',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: 'Sign In',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            //TextSpan onTap
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                Get.back();
              },
          ),
        ],
      ),
    ),
  );
}