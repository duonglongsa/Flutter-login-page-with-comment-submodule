import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_ui/screens/home/profile/controllers/profile_controller.dart';
import 'package:flutter_login_ui/screens/home/profile/views/template_widgets.dart';
import 'package:flutter_login_ui/services/firebase_services.dart';
import 'package:get/get.dart';

Widget buildHomeAppBar(){
  return AppBar(
    toolbarHeight: 40,
    backgroundColor: Colors.blueGrey[600],
    title: Text(
      'Sign out'
    ),
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildAvatar(ProfileController profileController){
  return Container(
    width:105,
    height: 110,
    child: Stack(
      children: [
        CircleAvatar(
          radius: 50.0,
          backgroundColor: Colors.blue,
          backgroundImage: NetworkImage('https://image.flaticon.com/icons/png/128/668/668709.png'),
        ),
        if(profileController.isEditing) Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 35,
            ),
            onPressed: (){
              Get.defaultDialog(
                content: TextFormField(
                  controller: profileController.avatarUrlController,
                ),
                textConfirm: 'OK',
                onConfirm: (){
                  profileController.setAvatarUrl();
                  Get.back();
                }
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildUserInfo(ProfileController profileController, BuildContext context){
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: <Widget>[
      buildInfoInListView(
        category: 'Name',
        controller: profileController.nameController,
        profileController: profileController,
      ),
      /*if(profileController.isEditing)  buildGenderOption(context, profileController)
      else buildInfoInListView(
        category:'Gender',
        controller: profileController.genderController,
        profileController: profileController,
      ),*/
      buildInfoInListView(
        category:'Phone number',
        controller: profileController.phoneController,
        profileController: profileController,
        keyboardType: TextInputType.phone,
      ),
      buildInfoInListView(
        category: 'Email',
        controller: profileController.emailController,
        profileController: profileController,
        validate: profileController.validateEmail,
        formKey: profileController.emailFormKey,
      ),
      buildInfoInListView(
        category: 'Password',
        controller: profileController.passwordController,
        profileController: profileController,
        isObscure: !profileController.isEditing,
        validate: profileController.validatePassword,
        formKey: profileController.passwordFormKey,
      ),
    ],
  );
}

Widget buildEditProfileBtn(ProfileController homeController){
  return Container(
    height: 20,
    alignment: Alignment.centerRight,
    child: FlatButton.icon(
      onPressed: () => homeController.pressEditBtn(),
      padding: EdgeInsets.only(right: 0.0),
      icon: Icon(
        Icons.edit,
        color: Colors.white,
        size: 15,
      ),
      label: Text(
        'Edit profile',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
          fontStyle: FontStyle.italic,
          fontSize: 15,
        ),
      ),
    ),
  );
}

Widget buildSaveBtn(ProfileController profileController){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(
        style: ButtonStyle(
          enableFeedback: false,
          //backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: () {
          profileController.pressCancelBtn();
        },
        child: Text(
          'Cancel',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      SizedBox(width: 50,),
      TextButton(
        style: ButtonStyle(
          //backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: () async {
          if(profileController.isValidProfile()){
            profileController.editUser();
            await firebaseEditUser(profileController);
              Get.defaultDialog(
                  title: 'Successfully Changed!',
                  middleText: 'Successfully Changed!',
                  textConfirm: 'OK',
                  onConfirm: (){
                    Get.back();
                    profileController.pressOKBtn();
                  }
              );
          }
        },
        child: Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    ],
  );
}

Widget buildBottomBar(){
  return BottomNavigationBar(
    backgroundColor: Colors.blueGrey[900],
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        label: 'School',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.perm_identity),
        label: 'Profile',
      ),
    ],
    onTap: (int index){
      print(index);
    },
    selectedItemColor: Colors.amber[800],
    unselectedItemColor: Colors.white,
  );
}

