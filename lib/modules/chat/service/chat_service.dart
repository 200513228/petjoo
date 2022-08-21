import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/modules/user/model/current_user.dart';

class ChatService {
  static var db = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> getChats() async {
    return await db
        .collection('chats')
        .where('userIds', arrayContains: CurrentUser.id)
        .get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String doc) async {
    return await db
        .collection('chats')
        .doc(doc)
        .collection('messages')
        .orderBy('date', descending: true)
        .get();
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      String userId) async {
    return await db.collection('users').doc(userId).get();
  }

  static Future<bool> sendMessage(Map<String, dynamic> map, String doc) async {
    await db.collection('chats').doc(doc).collection('messages').add(map);
    return false;
  }

  static Future readChat(String doc) async {
    var result = await db.collection('chats').doc(doc).get();
    Map map = result.data()!['lastMessage'];
    map['isReaded'] = true;
    await db.collection('chats').doc(doc).update({'lastMessage': map});
  }
}