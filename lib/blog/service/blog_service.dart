import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/blog/model/blog_topic_model.dart';

class BlogService {
  static var db = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> getTopics() async {
    return await db.collection('blog').orderBy('date', descending: true).get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String docid) async {
    return await db
        .collection('blog')
        .doc(docid)
        .collection('messages')
        .orderBy('date')
        .get();
  }

  static Future<String> sendMessage(
      Map<String, dynamic> msgModel, String docid) async {
    try {
      await db
          .collection('blog')
          .doc(docid)
          .collection('messages')
          .add(msgModel);
      return 'OKAY';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future newBlog(Map<String, dynamic> blogData, String firstMsg) async {
    try {
      var result = await db.collection('blog').add(blogData);
      sendMessage({'message': firstMsg, 'date': Timestamp.now()}, result.id);
      var data = await db.collection('blog').doc(result.id).get();
      return BlogTopicModel.fromDS(data);
    } on Exception catch (e) {
      log(e.toString());
      return 'ERROR';
    }
  }
}
