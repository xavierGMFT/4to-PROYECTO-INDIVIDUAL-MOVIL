import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future<File?> pickImageUser(BuildContext context) async {
  File? image;
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 50,
  );

  if (pickedFile != null) {
    image = File(pickedFile.path);
  }

  return image;
}
