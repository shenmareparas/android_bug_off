import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage_files/models/user_model.dart';

class FirestoreuserData {
  Map<String, dynamic> data;

  FirestoreuserData({required this.data});

  static setData(CurrentUser user, String uid) async {
    var db = FirebaseFirestore.instance;
    var userData = await db.collection(uid).doc("profile").set({
      'firstName': user.firstName,
      'lastName': user.lastName,
      'phoneNumber': user.phoneNumber,
      'email': user.email,
      'profilePicture': user.profilePicture,
      'lastUpdated': DateTime.now().toIso8601String(),
    }).whenComplete(() {
      log("User Data Set");
    }).catchError((error, stackTrace) {
      log("Error: $error");
    });
  }

  static setOrders(CurrentUser user, String uid) async {
    var db = FirebaseFirestore.instance;

    var userData = await db.collection(uid).doc("orders").set({
      'data': user.orders,
    });
  }

  static setFavorites(CurrentUser user, String uid) async {
    var db = FirebaseFirestore.instance;

    var userData = await db.collection(uid).doc("favorites").set({
      'data': user.fav,
    });
  }

  static setMyCart(String uid) async {
    var db = FirebaseFirestore.instance;
    var userData = await db.collection(uid).doc("cart").set(
      {
        'data': CurrentUser.currentUser!.cart,
      },
    ).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        CurrentUser.currentUser!.cart.removeLast();
      },
    ).onError(
      (error, stackTrace) => (error, stackTrace) {
        log("Error: $error");
        log("Stack Trace: $stackTrace");
        CurrentUser.currentUser!.cart.removeLast();
      },
    );
  }

  static getProfileData(String uid) async {
    var db = FirebaseFirestore.instance;
    var userData = (await db.collection(uid).doc("profile").get()).data() ?? {};
    return userData;
  }

  static getOrders(String uid) async {
    var db = FirebaseFirestore.instance;
    var userData = await db.collection(uid).doc("orders").get();
    return userData.data()?['data'] ?? [];
  }

  static getFavorites(String uid) async {
    var db = FirebaseFirestore.instance;
    var userData = await db.collection(uid).doc("favorites").get();
    return userData.data()?['data'] ?? [];
  }

  static getMyCart(String uid) async {
    var db = FirebaseFirestore.instance;
    var userData = await db.collection(uid).doc("cart").get();
    return userData.data()?['data'] ?? [];
  }

  static setLastupdated(String uid) async {
    var db = FirebaseFirestore.instance;
    var userData = await db.collection(uid).doc("profile").update({
      'lastUpdated': DateTime.now().toIso8601String(),
    });
  }
}
