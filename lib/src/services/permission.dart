import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  final Permission permission;

  PermissionHandler(this.permission);

  Future<bool> verifyAndRequest() async {
    var status = await permission.isGranted || await permission.isLimited;
    if (!status) {
      var value = await permission.request();
      if (value == PermissionStatus.granted || value == PermissionStatus.limited) {
        status = true;
      }
    }
    return status;
  }
}
