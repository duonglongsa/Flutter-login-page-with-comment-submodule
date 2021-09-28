import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_login_ui/screens/signup/controllers/signup_controller.dart';
import 'package:flutter_login_ui/screens/background.dart';
import 'package:flutter_login_ui/screens/signup/views/signup_screen_widgets.dart';
import 'package:flutter_login_ui/utilities/style_constants.dart';

import 'package:get/get.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              buildBackground(),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      buildSignupEmailTF(signupController),
                      SizedBox(height: 20.0,),
                      buildSignupPasswordTF(signupController),
                      SizedBox(height: 20.0,),
                      buildConfirmPasswordTF(signupController),
                      SizedBox(height: 30.0,),
                      buildRegisterBtn(signupController),
                      buildBackToLoginBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
