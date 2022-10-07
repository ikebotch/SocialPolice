import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialpolice/src/res/enums.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilsUpload {
  static Future<File> pickImage({CameraType? source}) async {
    final picker = ImagePicker();
    var pickedFile = await picker.pickImage(
        source: source == CameraType.CAMERA
            ? ImageSource.camera
            : ImageSource.gallery);
    final File file = File(pickedFile!.path);
    return file;
  }

  static Future<File?> pickMedia({
    CameraType? source,
    Future<File?> Function(File file)? cropImage,
  }) async {
    final pickedFile = await ImagePicker().pickImage(
        source: source == CameraType.CAMERA
            ? ImageSource.camera
            : ImageSource.gallery);

    if (pickedFile == null) return null;
    if (cropImage == null) {
      return File(pickedFile.path);
    } else {
      final file = File(pickedFile.path);
      return cropImage(file);
    }
  }

  static Future<File> cropPredefinedImage(File imageFile) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
      ],
      uiSettings: [
        iosUiSettingsLocked(),
        androidUiSettingsLocked(),
      ],
    );
    return File(croppedImage!.path);
  }

  static IOSUiSettings iosUiSettingsLocked() => IOSUiSettings(
        aspectRatioLockEnabled: false,
        resetAspectRatioEnabled: false,
      );

  static AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      );

  static launc(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    }
  }
}
