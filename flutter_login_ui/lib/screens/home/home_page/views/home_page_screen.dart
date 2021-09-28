import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/screens/background.dart';
import 'package:flutter_login_ui/screens/home/home_page/controllers/homepage_controller.dart';
import 'package:get/get.dart';



Widget buildHomeScreen(BuildContext context){
  final HomepageController homepageController = Get.put(HomepageController());

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Scaffold(
    body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            buildBackground(),
            Container(
              width: width,
              height: double.infinity,
              child: SingleChildScrollView(
               
                padding: EdgeInsets.all(10),
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: homepageController.controller,
                      decoration: InputDecoration(
                        labelText: 'Add new post',
                        labelStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        suffixIcon:  IconButton(
                          onPressed: () {
                          },
                          alignment: Alignment.center,
                          color: Colors.blue,
                          icon: Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ),
                    PostScreen(),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    )
  );
}