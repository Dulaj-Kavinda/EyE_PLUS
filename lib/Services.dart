// ignore_for_file: file_names

import 'package:huawei_ml/mlapplication/ml_application.dart';
import 'package:huawei_ml/permissions/permission_client.dart';
import 'package:image_picker/image_picker.dart';

//Image Picker
Future<String> getImage(ImageSource imageSource) async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: imageSource);
  return pickedFile!.path;
}

//Permission
Future<void> checkPermission() async {
  final bool isCameraPermissionGranted =
  await MLPermissionClient().hasCameraPermission();
  if (!isCameraPermissionGranted) {
    final bool res = await MLPermissionClient()
        .requestPermission([MLPermission.camera, MLPermission.storage]);
  }
}

//API Key Set for using ML kit
setApiKey() async {
  await MLApplication().setApiKey(
      apiKey:
      "DAEDABkfUGf0NqIB0zpzuvwgOAy1mxVv5j29leVllo/ZK94983xZV4vzQHYmlPKqAwbt8F4sX8juLDqiheuHr+ALD+KkUb4/iOhEig==");
}