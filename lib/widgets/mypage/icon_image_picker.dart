import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IconImagePicker extends StatefulWidget {
  final TextEditingController iconUrlController;

  const IconImagePicker({
    super.key,
    required this.iconUrlController,
  });

  @override
  IconImagePickerState createState() => IconImagePickerState();
}

class IconImagePickerState extends State<IconImagePicker> {
  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('ギャラリーから選択'),
            onTap: () async {
              final XFile? photo =
                  await picker.pickImage(source: ImageSource.gallery);
              if (photo != null) {
                widget.iconUrlController.text = photo.path;
              }
              if (!context.mounted) return;
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('カメラで撮影'),
            onTap: () async {
              final XFile? photo =
                  await picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                widget.iconUrlController.text = photo.path;
              }
              if (!context.mounted) return;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
