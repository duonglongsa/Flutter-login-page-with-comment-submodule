import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_comment_package/models/post.dart';
import 'package:flutter_comment_package/models/reply_commet.dart';
import 'package:flutter_comment_package/models/root_comment.dart';
import 'package:flutter_login_ui/models/vote_model.dart';
import 'package:flutter_login_ui/screens/home/home_page/controllers/homepage_controller.dart';
import 'package:flutter_login_ui/screens/home/profile/controllers/profile_controller.dart';
import 'package:flutter_login_ui/screens/login/controllers/login_controller.dart';
import 'package:flutter_login_ui/screens/signup/controllers/signup_controller.dart';
import 'package:flutter_login_ui/utilities/local_storage.dart';
import 'package:flutter_login_ui/models/user_model.dart';

import 'package:http/http.dart' as http;

Future<String> photoUrl(String uID) async{
  final doc = await FirebaseFirestore.instance.collection('users')
      .doc(uID)
      .get();
  return doc['avatarUrl'];
}

Stream <List<Post>> postStream(){
  final snapshot = FirebaseFirestore.instance.collection('posts')
      .orderBy('timeCreated', descending: true)
      .snapshots();
  return snapshot.map((qShot) => qShot.docs.map(
          (doc) => Post.fromDocumentSnapshot(doc)).toList()
  );
}


Stream <List<RootComment>> commentStream(String postID){
  final snapshot = FirebaseFirestore.instance.collection('posts')
      .doc(postID)
      .collection('root_comments')
      .orderBy('timeCreated', descending: true)
      .snapshots();
  return snapshot.map((qShot) => qShot.docs.map(
          (doc) => RootComment.fromDocumentSnapshot(doc, postID)).toList()
  );
}

Stream <List<ReplyComment>> replyStream(String postID, String rootID){
  final snapshot = FirebaseFirestore.instance.collection('posts')
      .doc(postID)
      .collection('root_comments')
      .doc(rootID)
      .collection('reply_comments')
      .orderBy('timeCreated', descending: true)
      .snapshots();
  return snapshot.map((qShot) => qShot.docs.map(
          (doc) => ReplyComment.fromDocumentSnapshot(doc)).toList()
  );
}





Stream <List<VoteModel>> voteStream(){
  final snapshot = FirebaseFirestore.instance.collection('vote_event')
      .orderBy('totalVote', descending: true)
      .snapshots();
  return snapshot.map((qShot) => qShot.docs.map(
          (doc) => VoteModel.fromDocumentSnapshot(doc)).toList()
  );
}


Future<void> updateVote(String voteID, int totalVote) {
  return FirebaseFirestore.instance.collection('vote_event')
      .doc(voteID)
      .update({'totalVote': totalVote+1})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

Future<void> addRootComment(String comment, String uID, String postID) async {
  try {
    await  FirebaseFirestore.instance
        .collection("comments")
        .doc(postID)
        .collection("root_comments")
        .add({
      'dateCreated': Timestamp.now(),
      'content': comment,
      'userID':uID,
    });
  } catch(e) {
    print(e);
  }
}

Future<void> addReplyComment(String comment, String uID, String rootID, String postID) async {
  try {
    await  FirebaseFirestore.instance
        .collection("comments")
        .doc(postID)
        .collection("root_comments")
        .doc(rootID)
        .collection("reply_comments")
        .add({
      'rootID': rootID,
      'dateCreated': Timestamp.now(),
      'content': comment,
      'userID':uID,
    });
  } catch(e) {
    print(e);
  }
}

Future<void> deleteComment(String uid, String commentID) {
  return FirebaseFirestore.instance.collection('users')
      .doc(uid)
      .collection('comments')
      .doc(commentID)
      .delete()
      .then((value) => print("Comment Deleted"))
      .catchError((error) => print("Failed to delete comment: $error"));
}

Future<void> addComment(String comment, String uid) async {
  try {
    await  FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("comments")
        .add({
      'dateCreated': Timestamp.now(),
      'comment': comment,
    });
  } catch(e) {
    print(e);
  }
}



Future firebaseEditUser(ProfileController profileController) async {
  await FirebaseAuth.instance.currentUser.updateDisplayName(profileController.user.name);
  await FirebaseAuth.instance.currentUser.updatePhotoURL(profileController.user.photoUrl);
  await FirebaseAuth.instance.currentUser.updateEmail(profileController.user.email);
  await FirebaseAuth.instance.currentUser.updatePassword(profileController.user.password);
  FirebaseFirestore.instance
      .collection("users")
      .doc(profileController.user.id)
      .set({
    'userName': profileController.user.name,
    'avatarUrl': profileController.user.photoUrl,
  });

  //await FirebaseAuth.instance.currentUser.updatePhoneNumber(phoneCredential)
}

Future<bool> firebaseRegister(SignupController signupController) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signupController.user.email,
        password: signupController.user.password
    );

    FirebaseFirestore.instance
        .collection("users")
        .doc(userCredential.user.uid)
        .set({
      'userName': '',
      'avatarUrl': 'https://image.flaticon.com/icons/png/128/668/668709.png',
    });

    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> firebaseLogin(LoginController loginController) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginController.user.email,
        password: loginController.user.password
    );
    print(userCredential.user.uid);
    await loginController.initUser(userCredential);
    print(userCredential);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
    return false;
  }
}

/*

Future<int> editProfile(ProfileController profileController) async {
  var res = await http.post(Uri.parse("http://172.168.8.69:8080/change-user-info"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8',
        //token get from server
        'Authorization': 'Bearer ' + await tokenStorage.read(key: profileController.user.email)
      },
      body: <String, String>{
        'email': profileController.user.email,
        'password': profileController.user.password,
        'name': profileController.user.name,
        'phoneNumber': profileController.user.phoneNumber,
        'gender': profileController.user.gender
      });
  return res.statusCode;
}

Future<String> getRememberedPassword(String email) async {
  var res = await http.post(Uri.parse("http://172.168.8.69:8080/rememberme"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8',
        //token get from server
        'Authorization': 'Bearer ' + await tokenStorage.read(key: email)
      },
      body: <String, String>{
        'email': email
      });
  return jsonDecode(res.body).toString();
}

Future<int> login(LoginController loginController) async {
  var res = await http.post(Uri.parse("http://172.168.8.69:8080/signin"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
      body: <String, String>{
        'email': loginController.user.email,
        'password': loginController.user.password
      });
  if(loginController.rememberMe && res.statusCode == 200){
    var respond = await jsonDecode(res.body);
    await tokenStorage.write(key: loginController.user.email, value: respond['token']);
    loginController.user.name = respond['user']['name'];
    loginController.user.phoneNumber = respond['user']['phoneNumber'];
    loginController.user.gender = respond['user']['gender'];
    if(!hintEmail.contains(loginController.user.email))  hintEmail.add(loginController.user.email);
  }
  return res.statusCode;
}

Future<int> register(SignupController signupController) async {
  var res = await http.post(Uri.parse("http://172.168.8.69:8080/signup"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
      body: <String, String>{
        'email': signupController.user.email,
        'password': signupController.user.password
      });
  return res.statusCode;
}*/
