import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/screens/home/home_controller.dart';
import 'package:flutter_login_ui/screens/home/page_1/views/page_1_screen.dart';
import 'package:flutter_login_ui/screens/home/profile/views/profile_screen.dart';
import 'package:flutter_login_ui/models/user_model.dart';
import 'package:get/get.dart';

import 'home_page/views/home_page_screen.dart';

class HomeScreen extends StatefulWidget {
  UserModel user;
  HomeScreen(UserModel _user){
    this.user = _user;
  }
  @override
  _HomeScreenState createState() => _HomeScreenState(this.user);
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

  _HomeScreenState(UserModel user){
    homeController.user = user;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screenOption = <Widget>[
      buildHomeScreen(context),
      buildPage1Screen(context),
      ProfileScreen(homeController.user),
    ];

    return GetBuilder<HomeController> (builder: (homeController) => Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.blueGrey[600],
        title: Text(
            'Sign out'
        ),
        leading: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          homeController.changTabIndex(index);
        },
        showUnselectedLabels: false,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        currentIndex: homeController.tabIndex,
      ),
      body: screenOption.elementAt(homeController.tabIndex),
    ));
  }
}
