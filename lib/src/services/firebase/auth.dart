import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bugbusters/application.dart';

typedef _OnStartCallback = Future<void> Function();
typedef _OnFinishCallback = Future<void> Function(
    User? user, Map<String, Object>? additionalData);
typedef _OnErrorCallback = Future<void> Function(
    ResultCode code, String? message);

class FirebaseAuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// This function triggers when processing is just started;
  final _OnStartCallback onStart;

  /// This function triggers when processing is finished;
  final _OnFinishCallback onFinish;

  /// This function triggers whenever an exception occurs;
  final _OnErrorCallback onError;

  FirebaseAuthService({
    required this.onStart,
    required this.onFinish,
    required this.onError,
  });

  Future<void> createUser(
      {required String email,
      required String password,
      Map<String, Object>? additional}) async {
    await _authenticateUser(
        operation: 0, email: email, password: password, additional: additional);
  }

  Future<void> loginUser(
      {required String email,
      required String password,
      Map<String, Object>? additional}) async {
    await _authenticateUser(
        operation: 1, email: email, password: password, additional: additional);
  }

  Future<void> _authenticateUser(
      {required int operation,
      required String email,
      required String password,
      Map<String, Object>? additional}) async {
    await onStart();
    try {
      UserCredential user;
      if (operation == 1) {
        user = await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .timeout(const Duration(seconds: 20));
      } else {
        user = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password)
            .timeout(const Duration(seconds: 20));
      }
      if (user.user != null) {
        await onFinish(user.user, null);
      } else {
        throw 'Unknown Error';
      }
    } on FirebaseAuthException catch (e) {
      await onError(ResultCode.firebase, e.message);
    } on SocketException catch (e) {
      await onError(ResultCode.socket, e.message);
    } on PlatformException catch (e) {
      await onError(ResultCode.socket, e.message);
    } on TimeoutException catch (e) {
      await onError(ResultCode.timeout, e.message);
    } catch (e) {
      await onError(ResultCode.exception, e.toString());
    }
  }

  Future<void> googleOAuth() async {
    await onStart();
    try {
      var googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        var googleAuth = await googleUser.authentication;
        var credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        var user = await _firebaseAuth.signInWithCredential(credential);
        if (user.user != null) {
          await onFinish(user.user, null);
        } else {
          throw 'Unknown Error';
        }
      } else {
        await onError(ResultCode.timeout, 'Process terminated');
      }
    } on FirebaseAuthException catch (e) {
      await onError(ResultCode.firebase, e.message);
    } on PlatformException catch (e) {
      await onError(ResultCode.socket, e.message);
    } on SocketException catch (e) {
      await onError(ResultCode.socket, e.message);
    } on TimeoutException catch (e) {
      await onError(ResultCode.timeout, e.message);
    } catch (e) {
      await onError(ResultCode.exception, e.toString());
    }
  }

  static Future<Map<String, dynamic>?> getCustomClaims() async {
    var token = await _firebaseAuth.currentUser?.getIdTokenResult();
    return token?.claims;
  }

  static Future<String> getUserRole() async {
    var claims = await getCustomClaims();
    return claims?['role'];
  }

  static Future<int> getUserAccessLevel() async {
    var claims = await getCustomClaims();
    return claims?['accessLevel'];
  }

  static User? get user => _firebaseAuth.currentUser;
}
