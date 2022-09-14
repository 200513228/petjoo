import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/chat/model/chat_model.dart';
import 'package:petjoo/user/model/current_user.dart';

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

  // static Stream<QuerySnapshot<Map<String, dynamic>>> getAdverts(String doc) {
  //   return db
  //       .collection('chats')
  //       .doc(doc)
  //       .collection('adverts')
  //       .orderBy('date', descending: true)
  //       .snapshots();
  // }

  static Future<QuerySnapshot<Map<String, dynamic>>> getAdverts(
      String doc) async {
    return await db
        .collection('chats')
        .doc(doc)
        .collection('adverts')
        .orderBy('date', descending: true)
        .get();
  }

  static Future<String> sendMessage(
      Map<String, dynamic> map, ChatModel model, String reciverId) async {
    await db
        .collection('chats')
        .doc(model.id)
        .get()
        .then((value) async => value.exists == false
            ? await db.collection('chats').doc(model.id).set({
                'id': model.id,
                'userIds': [CurrentUser.id, reciverId]
              })
            : null);
    await db.collection('chats').doc(model.id).collection('messages').add(map);
    return 'SEND';
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

  static Future<Map<String, String>> getAdvertInfo(
      String type, String id) async {
    String image = '';
    String title = '';
    var result = await db.collection(type).doc(id).get();
    var data = result.data() as dynamic;
    title = data['title'] ?? '';
    image = data['images'][0] ?? '';

    return {'image': image, 'title': title};
  }
}
