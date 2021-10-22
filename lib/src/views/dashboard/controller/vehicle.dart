import 'package:bugbusters/application.dart';

void addVehicle({
  required String name,
  required String vid,
  required String img,
}) async {
  FirestoreService().addVehicle(
    uid: FirebaseAuthService.user!.uid,
    name: name,
    vid: vid,
  );
}
