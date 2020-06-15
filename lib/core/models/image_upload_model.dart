import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  Image imageFile;
  String imageUrl;
  Uint8List imageData;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageData,
    this.imageUrl,
  });
}