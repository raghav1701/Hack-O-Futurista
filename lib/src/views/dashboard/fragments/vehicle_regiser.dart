import 'dart:io';
import 'dart:ui';

import 'package:bugbusters/application.dart';
import '../controller/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class VehicleRegistraionForm extends StatefulWidget {
  const VehicleRegistraionForm({Key? key}) : super(key: key);

  @override
  State<VehicleRegistraionForm> createState() => _VehicleRegistraionFormState();
}

class _VehicleRegistraionFormState extends State<VehicleRegistraionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final ProgressDialog progressDialog;

  String? name, vehicleId, image;

  void submit() {
    if (!_formKey.currentState!.validate()) return;
    if (image == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('Please upload your vehicle RC'),
          duration: Duration(seconds: 2),
        ));
      return;
    }
    _formKey.currentState!.save();
    FocusScope.of(context).unfocus();
    showConfirmDialog(
      context: context,
      title: 'Vehicle Registration',
      content:
          'By submitting this, you agree to our terms and conditions, your information will be sent to higher authorities to your confirm details?',
      onAccept: () async {
        await progressDialog.show();
        addVehicle(
          name: name!,
          vid: vehicleId!,
          img: image!,
        );
        await progressDialog.hide();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(
      context,
      isDismissible: false,
      type: ProgressDialogType.normal,
      customBody: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: Row(
          children: const [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text('Submitting Request...'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Registration'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: submit,
        label: const Text('  Submit  ', style: TextStyle(color: Colors.white)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AuthTextFormField(
                hintText: 'Full Name',
                onSaved: (val) => name = val,
                validator: validateName,
                horizontalPadding: 16.0,
              ),
              AuthTextFormField(
                hintText: 'Vehicle Number',
                onSaved: (val) => vehicleId = val,
                validator: validateVehicleID,
                horizontalPadding: 16.0,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                ),
                margin: const EdgeInsets.all(16.0),
                child: Visibility(
                  visible: image == null,
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        ImagePicker picker = ImagePicker();
                        var file =
                            await picker.pickImage(source: ImageSource.camera);
                        if (file != null) {
                          setState(() {
                            image = file.path;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(32.0),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Image.asset(
                              Assets.loginPageImage,
                              opacity:
                                  const AlwaysStoppedAnimation<double>(0.7),
                            ),
                            const Text(
                              'Upload RC Picture Here',
                              style: TextStyle(fontSize: 22.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  replacement: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                    child: Image.file(
                      File(image ?? Assets.welcomePageImage),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
