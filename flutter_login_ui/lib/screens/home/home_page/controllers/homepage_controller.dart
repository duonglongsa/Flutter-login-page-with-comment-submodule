import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_login_ui/screens/login/controllers/login_controller.dart';
import 'package:flutter_login_ui/services/firebase_services.dart';
import 'package:get/get.dart';

class HomepageController extends GetxController{

   /* final commentList = <CommentModel>[].obs;

    List<CommentModel> get comments => commentList.value;*/

    TextEditingController controller = new TextEditingController();
    bool isShowReply = false;

    /*void onInit(){
        String uid = Get.find<LoginController>().user.id;
        commentList.bindStream(testStream(uid));
    }*/

    void tapShowReply() {
        isShowReply = !isShowReply;
        update();
        print(isShowReply);
    }


}