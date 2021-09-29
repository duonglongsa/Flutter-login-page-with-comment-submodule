import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/screens/home/page_1/controllers/vote_controller.dart';
import 'package:flutter_login_ui/services/firebase_services.dart';
import 'package:get/get.dart';

import '../../../background.dart';

Widget buildPage1Screen(BuildContext context){
  final VoteController voteController = Get.put(VoteController());

  return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                buildBackground(),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(

                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      /*children: [
                        Obx(() => ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            //scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: voteController.votes.length,
                            itemBuilder: (_, index) {
                              return ListTile(
                                title: Row(
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text(
                                        voteController.votes[index].content,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    TextButton(
                                      onPressed: (){
                                        updateVote(voteController.votes[index].contentId, voteController.votes[index].totalVote);
                                      },
                                      child: Text(
                                        voteController.votes[index].totalVote.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                        ),
                        ),
                      ],*/
                    ),
                  ),
                ),
              ],
            )
        ),
      )
  );
}