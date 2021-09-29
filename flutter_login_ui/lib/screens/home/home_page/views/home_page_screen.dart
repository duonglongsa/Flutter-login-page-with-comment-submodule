import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_comment_package/services/firebase_services.dart';
import 'package:flutter_comment_package/views/post_screen.dart';
import 'package:flutter_comment_package/models/user.dart';

import 'package:flutter_login_ui/models/user_model.dart';
import 'package:flutter_login_ui/screens/background.dart';
import 'package:flutter_login_ui/screens/home/home_controller.dart';

import 'package:flutter_login_ui/screens/home/home_page/controllers/homepage_controller.dart';
import 'package:flutter_login_ui/screens/home/profile/controllers/profile_controller.dart';
import 'package:flutter_login_ui/services/firebase_services.dart';
import 'package:get/get.dart';
import 'package:flutter_comment_package/controllers/post_controller.dart';

Widget buildHomeScreen(BuildContext context){
  final HomepageController homepageController = Get.put(HomepageController());
  final PostController postController = Get.put(PostController(PostUser(
    Get.find<HomeController>().user.id,
    Get.find<HomeController>().user.name,
    Get.find<HomeController>().user.photoUrl,
  ),));

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
                      controller: homepageController.postTextController,
                      decoration: InputDecoration(
                        labelText: 'Add new post',
                        labelStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        suffixIcon:  IconButton(
                          onPressed: () async {
                            UserModel user =  Get.find<ProfileController>().user;
                            addPost(homepageController.postTextController.text,
                                user.id,
                                user.name,
                                await photoUrl(user.id),
                            );
                            homepageController.postTextController.text = '';
                          },
                          alignment: Alignment.center,
                          color: Colors.blue,
                          icon: Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ),

                   SizedBox(height: 20,),

                   PostScreen(
                     context: context,
                     postController: postController,
                   ),
                   /* Obx(() => ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homepageController.posts.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            title: PostWidget(
                              context: context,
                              userName: homepageController.posts[index].userName,
                              avatarUrl: homepageController.posts[index].avatarUrl,
                              post: homepageController.posts[index],
                              onCommentTap: () => homepageController.onCommentTap(homepageController.posts[index].contentId, context),
                            ),
                          );
                        }
                    ),),*/
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