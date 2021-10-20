import 'dart:async';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/application.dart';

class FirebaseFunctionService {
  static final _functions = FirebaseFunctions.instance;

  Future<Result> upvotePost(String postId) async {
    try {
      await _functions
        .httpsCallable(
          'upvote',
          options: HttpsCallableOptions(
            timeout: const Duration(seconds: 20),
          ),
        ).call({
          'id': postId,
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
