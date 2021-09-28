import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/screens/home/profile/controllers/profile_controller.dart';

Widget buildInfoInListView({
  @required String category,
  @required TextEditingController controller,
  @required ProfileController profileController,
  Function(String) validate,
  bool isObscure,
  GlobalKey formKey,
  TextInputType keyboardType,
  }) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      category,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 14,
        color: Colors.white54,
      ),
    ),
    Container(
      height: 50,
      child: Form(
        key: formKey,
        child: TextFormField(
          validator: (value) => validate(value)??null,
          obscureText: isObscure??false,
          controller: controller,
          enabled: profileController.isEditing,
          keyboardType: keyboardType??TextInputType.text,
          //textCapitalization: TextCapitalization.words,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 16,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            errorStyle: TextStyle(

            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white54,
                width: 1.0,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white54,
                width: 1.0,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            )
          ),

        ),
      ),
    ),
    SizedBox(height: 10.0),
  ],
);
