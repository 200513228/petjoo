import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petjoo/product/models/chat_model.dart';
import 'package:petjoo/product/models/message_model.dart';
import 'package:petjoo/product/models/user_basic_model.dart';
import 'package:petjoo/product/models/user_model.dart';
import 'package:petjoo/product/services/notification_service.dart';
import 'package:petjoo/modules/user/user_service.dart';

const String _users = "users";
const String _usersInfo = "users_info";
const String _chats = "chats";
const String _messages = "messages";
const String _blocks = "blocks";

class Requests {
  static Future<UserModel> getUser(String uid) async => UserModel.fromJson(
      await FirebaseFirestore.instance.collection(_users).doc(uid).get());
  static Future<UserBasicModel> getUserInfo(String uid) async =>
      UserBasicModel.fromJson(await FirebaseFirestore.instance
          .collection(_usersInfo)
          .doc(uid)
          .get());

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(
      String uid) {
    UserService.userid = uid;
    return FirebaseFirestore.instance.collection(_users).doc(uid).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getBlocksStream(
          String uid) =>
      FirebaseFirestore.instance
          .collection(_users)
          .doc(uid)
          .collection(_blocks)
          .where("users", isNotEqualTo: []).snapshots();

  static Future<void> createUser(UserModel user) => FirebaseFirestore.instance
      .collection(_users)
      .doc(user.id)
      .set(user.toJson());

  static Future<UserModel?> createUserIfNotExist(
      String id, String email) async {
    final doc = FirebaseFirestore.instance.collection(_users).doc(id);
    final token = await NotificationService.instance.token;
    return doc.get().then((value) async {
      if (value.exists) {
        await doc.update({"fcmToken": token});
        return UserModel.fromJson(value);
      }
      doc.set({"email": email, "fcmToken": token});
      return null;
    });
  }

  static Future<void> updateUser(UserModel data) => FirebaseFirestore.instance
      .collection(_users)
      .doc(data.id)
      .update(data.toJson());
  static Future<void> changeUserTransportStatus(String userId, bool value) =>
      FirebaseFirestore.instance
          .collection(_users)
          .doc(userId)
          .update({'hasTransport': value});

  static Future<void> changeUserPhoto(String userId, File file) async {
    final result = FirebaseStorage.instance
        .ref()
        .child("user_images")
        .child("$userId.jpg");
    await result.putFile(file);
    await FirebaseFirestore.instance
        .collection(_users)
        .doc(userId)
        .update({"image": await result.getDownloadURL()});
  }

  static Future<void> deleteUser(String userId) =>
      FirebaseFirestore.instance.collection(_users).doc(userId).delete();
  static Future<void> blockUser(String userId) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Future.wait([
      FirebaseFirestore.instance
          .collection(_users)
          .doc(userId)
          .collection(_blocks)
          .doc(currentUserId)
          .set({
        'users': FieldValue.arrayUnion([currentUserId])
      }),
      FirebaseFirestore.instance
          .collection(_users)
          .doc(currentUserId)
          .collection(_blocks)
          .doc(userId)
          .set({
        'users': FieldValue.arrayUnion([currentUserId])
      })
    ]);
  }

  static Future<void> unblockUser(String userId) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Future.wait([
      FirebaseFirestore.instance
          .collection(_users)
          .doc(userId)
          .collection(_blocks)
          .doc(currentUserId)
          .set({
        'users': FieldValue.arrayRemove([currentUserId])
      }),
      FirebaseFirestore.instance
          .collection(_users)
          .doc(currentUserId)
          .collection(_blocks)
          .doc(userId)
          .set({
        'users': FieldValue.arrayRemove([currentUserId])
      })
    ]);
  }

  static Future<void> removeUserFcm(String id) => FirebaseFirestore.instance
      .collection(_users)
      .doc(id)
      .update({'fcmToken': ''});

  //Chat

  static Stream<List<ChatModel>> getChats(String userId) {
    return FirebaseFirestore.instance
        .collection(_chats)
        .where("userIds", arrayContains: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => ChatModel.fromDocument(e)).toList());
  }

  static Future<void> createChat(ChatModel data) => FirebaseFirestore.instance
      .collection(_chats)
      .doc(data.id)
      .set(data.toJson());

  static Future<List<MessageModel>> getMessages(String chatId,
      {DocumentSnapshot? lastDocument, int limit = 50}) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection(_chats)
        .doc(chatId)
        .collection(_messages)
        .orderBy("date", descending: true);
    if (lastDocument != null) {
      query = query.endBeforeDocument(lastDocument);
    }
    query = query.limit(limit);
    return (await query.get())
        .docs
        .map((e) => MessageModel.fromDocument(e))
        .toList()
        .toList();
  }

  static Future<List<MessageModel>> getOldMessages(String chatId,
      {DocumentSnapshot? lastDocument, int limit = 50}) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection(_chats)
        .doc(chatId)
        .collection(_messages)
        .orderBy("date", descending: true);
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }
    query = query.limit(limit);
    return (await query.get())
        .docs
        .map((e) => MessageModel.fromDocument(e))
        .toList()
        .toList();
  }

  static Future<DocumentReference> createMessage(
          String chatId, MessageModel data) =>
      FirebaseFirestore.instance
          .collection(_chats)
          .doc(chatId)
          .collection(_messages)
          .add(data.toJson());
}
