import 'dart:async';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:bugbusters/application.dart';

class FirebaseFunctionService {
  static final _functions = FirebaseFunctions.instance;

  Future<Result> enterParking(
      {required String parkId,
      required String name,
      required String vehicleId,
      List<int>? slot}) async {
    try {
      await _functions
          .httpsCallable(
        'enterParking',
        options: HttpsCallableOptions(
          timeout: const Duration(seconds: 40),
        ),
      )
          .call({
        'pid': parkId,
        'pname': name,
        'vehicleId': vehicleId,
        'slot': slot,
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

  Future<Result> exitParking(
      {required String parkId, required String vehicleId}) async {
    try {
      await _functions
          .httpsCallable(
        'exitParking',
        options: HttpsCallableOptions(
          timeout: const Duration(seconds: 40),
        ),
      )
          .call({
        'pid': parkId,
        'vehicleId': vehicleId,
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

  Future<Result> bookSlot(
      {required String tid,
      required String parkId,
      required List<int> slot}) async {
    try {
      await _functions
          .httpsCallable(
        'bookSlot',
        options: HttpsCallableOptions(
          timeout: const Duration(seconds: 40),
        ),
      )
          .call({
        'tid': tid,
        'pid': parkId,
        'slot': slot,
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
