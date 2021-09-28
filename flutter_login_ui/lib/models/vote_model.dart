import 'package:cloud_firestore/cloud_firestore.dart';

class VoteModel {
  String content;
  String contentId;
  int totalVote;

  VoteModel(this.content, this.contentId, this.totalVote);

  VoteModel.fromDocumentSnapshot(
      QueryDocumentSnapshot snapshot,
      ) {
    contentId = snapshot.id;
    content = snapshot.get('content');
    totalVote = snapshot.get('totalVote');
  }

}

