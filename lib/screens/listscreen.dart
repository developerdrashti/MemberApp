import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String _base64Image="";
  File? galleryFile;
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final File imageFile = File(pickedImage.path);
      final bytes = await imageFile.readAsBytes();
      final imageName = path.basename(pickedImage.path);

      setState(() {
        _base64Image = base64Encode(bytes);
        galleryFile = File(pickedImage!.path);
        print("abcdefghijklmnopqrstuvwxyz");
        print(imageFile);
      });print(_base64Image);
      print(bytes);
      print(pickedImage.path);
      print("ONLY IMNAGE NAME PRINT ");
      print(imageName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          child: Text('Select Image'),
        ),
        SizedBox(height: 20),
        if (_base64Image != null)
          Image.memory(
            base64Decode(_base64Image),
            fit: BoxFit.cover,
            height: 200,
          ),
      ],
    );
  }
}
