import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IconImagePicker extends StatefulWidget {
  final void Function(File?) onImagePicked;

  const IconImagePicker({
    super.key,
    required this.onImagePicked,
  });

  @override
  IconImagePickerState createState() => IconImagePickerState();
}

class IconImagePickerState extends State<IconImagePicker> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: source);
    if (file != null) {
      final pickedFile = File(file.path);
      widget.onImagePicked(pickedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('ギャラリーから選択'),
            onTap: () async {
              await _pickImage(ImageSource.gallery);
              if (!context.mounted) return;
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('カメラで撮影'),
            onTap: () async {
              await _pickImage(ImageSource.camera);
              if (!context.mounted) return;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
