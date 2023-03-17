import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/blog/model/blog_topic_model.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlogService {
  static var db = FirebaseFirestore.instance;
  static bool checkAlert = false;
  static SharedPreferences? prefs;

  static Future prefsCheck() async {
    prefs = await SharedPreferences.getInstance();
    checkAlert = prefs!.getBool('checkAlert') ?? false;
  }

  static void prefsSet() {
    prefs!.setBool('checkAlert', true);
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getTopics() async {
    return await db.collection('blog').orderBy('date', descending: true).get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUserTopics(
      String uid) async {
    var data = await db
        .collection('blog')
        .where('userId', isEqualTo: uid)
        .orderBy('date', descending: true)
        .get();
    return data;
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

  static Future<String> updateMessage(
      String topicId, String msgId, String newMessage) async {
    try {
      await db
          .collection('blog')
          .doc(topicId)
          .collection('messages')
          .doc(msgId)
          .update({'message': newMessage});
      return 'OKAY';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future newBlog(Map<String, dynamic> blogData, String firstMsg) async {
    try {
      var result = await db.collection('blog').add(blogData);
      sendMessage({
        'message': firstMsg,
        'userId': CurrentUser.id,
        'date': Timestamp.now()
      }, result.id);
      var data = await db.collection('blog').doc(result.id).get();
      return BlogTopicModel.fromDS(data);
    } on Exception catch (e) {
      log(e.toString());
      return 'ERROR';
    }
  }

  static Future deleteBlog(String docid) async {
    await db.collection('blog').doc(docid).delete();
  }
}
