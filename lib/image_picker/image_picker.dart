import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            MaterialButton(
              color: Colors.blue,
              child: Text(
                'Pick Image from Gallery',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _pickImageFromGallery();
              },
            ),
            MaterialButton(
              color: Colors.red,
              child: Text(
                'Pick Image from Camera',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _pickImageFromCamera();
              },
            ),
            const SizedBox(height: 16),
            _selectedImage != null
                ? Image.file(_selectedImage!)
                : Text("Please selected an image")
          ]),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}
