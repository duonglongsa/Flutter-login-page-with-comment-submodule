import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_ui/models/vote_model.dart';
import 'package:flutter_login_ui/screens/login/controllers/login_controller.dart';
import 'package:flutter_login_ui/services/firebase_services.dart';
import 'package:get/get.dart';

class VoteController extends GetxController{

  final voteList = <VoteModel>[].obs;
  int votedIndex;


  List<VoteModel> get votes => voteList.value;

  TextEditingController controller = new TextEditingController();

  void onInit(){
    String uid = Get.find<LoginController>().user.id;
    voteList.bindStream(voteStream());

  }

  void vote(int index){
    if(index == this.votedIndex){
      updateVote(votes[votedIndex].contentId, votes[votedIndex].totalVote - 1);
    } else {
      updateVote(votes[votedIndex].contentId, votes[votedIndex].totalVote - 1);
      updateVote(votes[index].contentId, votes[index].totalVote + 1);
      this.votedIndex = index;
    }
  }


}