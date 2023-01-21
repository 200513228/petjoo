import 'package:cloud_firestore/cloud_firestore.dart';

class BlogService {
  static var db = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> getTopics() async {
    return await db.collection('blog').get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String docid) async {
    return await db.collection('blog').doc(docid).collection('messages').get();
  }
}
