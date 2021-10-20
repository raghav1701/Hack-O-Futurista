import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/application.dart';
import 'package:url_launcher/url_launcher.dart';

Future<Result> launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
    return Result(code: ResultCode.success);
  } else {
    return Result(
        code: ResultCode.exception, message: 'Failed to open required app.');
  }
}

Future<Result> callto(String phone) async {
  var url = 'tel://$phone';
  if (await canLaunch(url)) {
    await launch(url);
    return Result(code: ResultCode.success);
  } else {
    return Result(code: ResultCode.exception, message: 'Failed to open phone');
  }
}

Future<Result> launchMaps(GeoPoint source, GeoPoint destination) async {
  var url = "http://maps.google.com/maps?saddr=" +
      source.latitude.toString() + "," +
      source.longitude.toString() + "&daddr=" +
      destination.latitude.toString() + "," +
      destination.longitude.toString();
  if (await canLaunch(url)) {
    await launch(url);
    return Result(code: ResultCode.success);
  } else {
    return Result(code: ResultCode.exception, message: 'Failed to open maps');
  }
}

Future<Result> mailTo(
    {required String email,
    required String subject,
    required String body}) async {
  var url = 'mailto:$email?subject=$subject&body=$body';
  if (await canLaunch(url)) {
    await launch(url);
    return Result(code: ResultCode.success);
  } else {
    return Result(code: ResultCode.exception, message: 'Failed to open email.');
  }
}
