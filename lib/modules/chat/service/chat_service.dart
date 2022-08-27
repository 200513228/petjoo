import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/modules/chat/model/chat_model.dart';
import 'package:petjoo/modules/user/model/current_user.dart';

class ChatService {
  static var db = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> getChats() async {
    return await db
        .collection('chats')
        .where('userIds', arrayContains: CurrentUser.id)
        .get();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String doc) {
    return db
        .collection('chats')
        .doc(doc)
        .collection('messages')
        .orderBy('date', descending: true)
        .snapshots();
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

  static Future<String?> findChat(String userid) async {
    var result = await db
        .collection('chats')
        .where('userIds', isEqualTo: [CurrentUser.id, userid]).get();
    if (result.docs.isNotEmpty) {
      return result.docs.first.id;
    } else {
      var result2 = await db
          .collection('chats')
          .where('userIds', isEqualTo: [userid, CurrentUser.id]).get();
      return result2.docs.isEmpty ? null : result.docs.first.id;
    }
  }

  static Future<ChatModel> getOnes(String docid) async {
    var result = await db.collection('chats').doc(docid).get();
    return ChatModel.fromDS(result);
  }
}
