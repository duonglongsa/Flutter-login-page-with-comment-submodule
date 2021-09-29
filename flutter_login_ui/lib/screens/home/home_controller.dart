import 'package:flutter_login_ui/models/user_model.dart';
import 'package:flutter_login_ui/services/firebase_services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  UserModel user;
  int tabIndex = 2;

  void changTabIndex(index){
    tabIndex = index;
    update();
  }

}