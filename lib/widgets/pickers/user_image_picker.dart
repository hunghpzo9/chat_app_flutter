import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicer extends StatefulWidget {
  final Function(File pickedImage) imagePickFn;

  UserImagePicer(this.imagePickFn);

  @override
  State<UserImagePicer> createState() => _UserImagePicerState();
}

class _UserImagePicerState extends State<UserImagePicer> {
  File? _pickedImage;

  Future<void> _pickImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    File file = File(pickedImage!.path);
    setState(() {
      _pickedImage = file;
    });
    widget.imagePickFn(file);
  }

  void _showDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    await _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.pink,
                        ),
                        onPressed: () async {
                          await _pickImage(ImageSource.camera);
                          Navigator.of(context).pop();
                        },
                      ),
                      Text("Camera"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.image,
                          color: Colors.pink,
                        ),
                        onPressed: () async {
                          await _pickImage(ImageSource.gallery);
                          Navigator.of(context).pop();
                        },
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: () {
            _showDialog(context);
          },
          label: Text('Add avatar'),
          icon: Icon(Icons.image),
        ),
      ],
    );
  }
}
