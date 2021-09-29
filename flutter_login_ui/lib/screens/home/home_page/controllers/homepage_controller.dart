import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_comment_package/flutter_comment_package.dart';
import 'package:flutter_comment_package/models/post.dart';
import 'package:flutter_comment_package/models/root_comment.dart';

import 'package:flutter_login_ui/screens/login/controllers/login_controller.dart';
import 'package:flutter_login_ui/services/firebase_services.dart';
import 'package:get/get.dart';

class HomepageController extends GetxController{

   final postList = <Post>[].obs;
   List<Post> get posts => postList.value;

   TextEditingController postTextController = new TextEditingController();

   /* VoidCallback onCommentTap(String postID, context){
      comments.clear();
      commentList.bindStream(commentStream(postID));
      for(RootComment comment in comments){
        comment.replyList.bindStream(replyStream(postID, comment.commentId));
      }

      final CommentController commentController = Get.put(CommentController());

      WidgetsBinding.instance.addPostFrameCallback((_){
        showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Obx(() => CommentScreenWidget(
              context: context,
              isReplying: commentController.isReplying,
              commentTextController: commentController.commentTextController,
              roots: this.comments,
              onReplyTap: () {
                print("3");
                commentController.isReplying.value = true;
              },
            ),),
          )
        );

      });

    }*/


}