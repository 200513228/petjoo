import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/product/models/block_model.dart';
import 'package:petjoo/product/models/user_basic_model.dart';
import 'package:petjoo/product/models/user_model.dart';
import 'package:petjoo/product/network/requests.dart';

class UserProvider extends ChangeNotifier {
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userStream;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _blocksStream;
  UserModel? _user;
  List<BlockModel> _blocks = [];

  UserModel get user => _user!;
  bool get hasUser => _user != null;
  bool get hasTransport => _user != null && user.hasTransport;
  bool isUserExist = true;

  List<UserBasicModel> userInfos = [];

  set user(UserModel? data) => _user = data;

  List<BlockModel> get blocks => _blocks;

  UserProvider() {
    FirebaseAuth.instance.authStateChanges().listen((event) => event == null ? _stopListen() : _startListen());
  }

  void _startListen() {
    if (FirebaseAuth.instance.currentUser?.isAnonymous == true) {
      user = UserModel(email: "");
      notifyListeners();
      return;
    }
    if (_userStream != null) return;
    _userStream = Requests.getUserStream(FirebaseAuth.instance.currentUser!.uid).listen(_onUserNotify);
    _blocksStream = Requests.getBlocksStream(FirebaseAuth.instance.currentUser!.uid).listen(_onBlocksNotify);
  }

  void _stopListen() {
    _userStream?.cancel();
    _userStream = null;
    _user = null;

    _blocksStream?.cancel();
    _blocksStream = null;
    _blocks.clear();
  }

  void _onUserNotify(DocumentSnapshot<Map<String, dynamic>> event) {
    try {
      if (event.exists) {
        _user = UserModel.fromJson(event);
      } else {
        isUserExist = false;
      }
      notifyListeners();
    } catch (e) {
      log(e.toString());
      isUserExist = false;
      notifyListeners();
    }
  }

  void _onBlocksNotify(QuerySnapshot<Map<String, dynamic>> event) {
    try {
      _blocks = event.docs.map((e) => BlockModel.fromJson(e)).toList();
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  void addUserInfo(UserBasicModel userInfo) {
    userInfos.add(userInfo);
    notifyListeners();
  }
}
