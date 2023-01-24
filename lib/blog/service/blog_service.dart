import 'package:cloud_firestore/cloud_firestore.dart';

class BlogService {
  static var db = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> getTopics() async {
    return await db.collection('blog').get();
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
}
