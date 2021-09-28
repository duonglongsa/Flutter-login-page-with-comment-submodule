import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/screens/home/profile/controllers/profile_controller.dart';
import 'package:flutter_login_ui/screens/home/profile/views/profile_screen_widgets.dart';
import 'package:flutter_login_ui/models/user_model.dart';
import 'package:flutter_login_ui/screens/background.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  UserModel user;
  ProfileScreen(UserModel user){
    this.user = user;
  }
  @override
  _ProfileScreenState createState() => _ProfileScreenState(this.user);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  _ProfileScreenState(UserModel user){
    profileController.init(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child:  Stack(
            children: <Widget>[
              buildBackground(),
              Container(
                height: double.infinity,
                //alignment: Alignment.center,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  child: GetBuilder<ProfileController>(builder: (homeController) => Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      buildAvatar(profileController),
                      SizedBox(height: 20,),
                      if(homeController.isEditing) SizedBox(height: 20,),
                      if(!homeController.isEditing) buildEditProfileBtn(homeController),
                      buildUserInfo(homeController, context),
                      SizedBox(height: 20,),
                      if(homeController.isEditing) buildSaveBtn(homeController),
                    ],
                  ),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
