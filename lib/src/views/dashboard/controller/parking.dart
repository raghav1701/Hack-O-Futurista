import 'package:bugbusters/application.dart';

void parkVehicle(String vid, ProgressDialog progressDialog) async {
  await progressDialog.show();
  await FirebaseFunctionService().enterParking(
    parkId: FirebaseAuthService.user!.uid,
    name: FirebaseAuthService.user!.displayName!,
    vehicleId: vid,
  );
  await progressDialog.hide();
}

void exitParking(String vid, ProgressDialog progressDialog) async {
  await progressDialog.show();
  await FirebaseFunctionService().exitParking(
    parkId: FirebaseAuthService.user!.uid,
    vehicleId: vid,
  );
  await progressDialog.hide();
}
