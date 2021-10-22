import 'dart:async';
import 'dart:io';

import 'package:bugbusters/application.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Collections {
  Collections._();
  static const users = 'users';
  static const managers = 'managers';
  static const transactions = 'transactions';
  static const vehicles = 'vehicles';
}

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result> addVehicle(
      {required String uid, required String name, required String vid}) async {
    try {
      _firestore.collection(Collections.vehicles).add({
        'name': name,
        'vid': vid,
        'uid': uid,
        'dateAdded': Timestamp.now(),
      });
      return Result(code: ResultCode.success);
    } on FirebaseException catch (e) {
      return Result(code: ResultCode.firebase, message: e.message);
    } on PlatformException catch (e) {
      return Result(code: ResultCode.platform, message: e.message);
    } on SocketException catch (e) {
      return Result(code: ResultCode.socket, message: e.message);
    } on TimeoutException catch (e) {
      return Result(code: ResultCode.timeout, message: e.message);
    } catch (e) {
      return Result(code: ResultCode.exception, message: e.toString());
    }
  }
}
