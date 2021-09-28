import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_login_ui/screens/login/controllers/login_controller.dart';
import 'package:flutter_login_ui/screens/background.dart';
import 'package:flutter_login_ui/screens/login/views/login_screen_widgets.dart';

import 'package:get/get.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              //gradient background
              buildBackground(),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: GetBuilder<LoginController>(builder: (loginController) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      buildLoginEmailTF(loginController),
                      SizedBox(height: 30.0,),
                      buildLoginPasswordTF(loginController),
                      buildForgotPasswordBtn(),
                      buildRememberMeCheckbox(loginController),
                      buildLoginBtn(loginController),
                      buildHeadToSignupBtn(context),
                    ],
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
