import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/screens/home/home_screen.dart';

import 'package:flutter_login_ui/screens/login/controllers/login_controller.dart';
import 'package:flutter_login_ui/screens/signup/views/signup_screen.dart';
import 'package:flutter_login_ui/utilities/style_constants.dart';
import 'package:flutter_login_ui/services/firebase_services.dart';
import 'package:flutter_login_ui/utilities/local_storage.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

Widget buildLoginEmailTF(LoginController loginController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Email',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      Form(
        key: loginController.loginFormKey,
        child: TypeAheadFormField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: loginController.emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            onEditingComplete:  () async {
              loginController.passwordController.text = await rememberedAccount.read(key: loginController.emailController.text);
            },
            decoration: emailInputDecoration,
          ),
          validator: (value) => loginController.validateEmail(value),
          hideOnLoading: true,
          noItemsFoundBuilder: (value){
            return null;
          },
          suggestionsCallback: (pattern) {
            return  hintEmail.where((element) => element.startsWith(pattern) && element!='');
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) async {
            loginController.emailController.text = suggestion;
            loginController.passwordController.text = await rememberedAccount.read(key: loginController.emailController.text);
          },

        ),
      ),

    ],
  );
}

Widget buildLoginPasswordTF(LoginController loginController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Password',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      TextFormField(
        obscureText: loginController.obscureText,
        controller: loginController.passwordController,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
            fillColor: Colors.white24,
            filled: true,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                loginController.obscureText? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                color: Colors.white,
              ),
              onPressed: (){
                loginController.obscurePassword();
              },
            ),
            hintText: 'Enter your Password',
            hintStyle: kHintTextStyle,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                width: 0.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                width: 0.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            )
        ),
      ),
    ],
  );
}

Widget buildLoginBtn(LoginController loginController) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    // ignore: deprecated_member_use
    child: RaisedButton(
      elevation: 5.0,
      onPressed: () async {
        loginController.getUser();
        if (loginController.loginFormKey.currentState.validate()) {
          var isLogin = await firebaseLogin(loginController);
          if(isLogin){
            if(loginController.rememberMe){
              rememberedAccount.write(key: loginController.user.email, value: loginController.user.password);
              if(!hintEmail.contains(loginController.user.email)) hintEmail.add(loginController.user.email);
            }
            Get.to(() => HomeScreen(loginController.user));
          }else {
            Get.defaultDialog(
                title: 'Failed to login',
                middleText: 'Incorrect email or password!',
                textConfirm: 'OK',
                onConfirm: (){
                  Get.back();
                }
            );
          }
        }
      },
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      child: Text(
        'LOGIN',
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

Widget buildForgotPasswordBtn() {
  return Container(
    alignment: Alignment.centerRight,
    // ignore: deprecated_member_use
    child: FlatButton(
      onPressed: () => print('Forgot Password Button Pressed'),
      padding: EdgeInsets.only(right: 0.0),
      child: Text(
        'Forgot Password?',
        style: kLabelStyle,
      ),
    ),
  );
}

Widget buildRememberMeCheckbox(LoginController loginController) {
  return Container(
    height: 20.0,
    child: Row(
      children: <Widget>[
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Checkbox(
            value: loginController.rememberMe,
            checkColor: Colors.green,
            activeColor: Colors.white,
            onChanged: (value) {
              loginController.rememberPassword(value);
            },
          ),
        ),
        Text(
          'Remember me',
          style: kLabelStyle,
        ),
      ],
    ),
  );
}

Widget buildHeadToSignupBtn(BuildContext context) {
  return GestureDetector(
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an Account? ',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            //TextSpan onTap
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                Get.to(() => SignUpScreen());
              },
          ),
        ],
      ),
    ),
  );
}