import 'dart:io';

import 'package:chatapp_2025/common/shared/commen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/auth/bloc/auth_bloc.dart';

Future<void> showUpdatephotoURLModelBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Profile photo"),
            Row(
              children: [
                PickProfileImage(
                  onTap: () {},
                  icon: Icons.photo_camera,
                  name: "Camera",
                ),
                const SizedBox(width: 40),
                PickProfileImage(
                  onTap: () {
                    selectImageFromGallery(context);
                  },
                  icon: Icons.photo,
                  name: "Gallery",
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void selectImageFromGallery(BuildContext context) async {
  File? image = await pickImageFromGallery(context);
  if (image != null) {
    cropImage(image.path).then((value) {
      if (value != null) {
        BlocProvider.of<AuthBloc>(
          context,
        ).add(UpdatephotoURL(path: value.path));
      }
      Navigator.pop(context);
    });
  }
}

class PickProfileImage extends StatelessWidget {
  final VoidCallback onTap;
  final String name;
  final IconData icon;

  const PickProfileImage({
    super.key,
    required this.onTap,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 10, top: 30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Icon(icon, color: Colors.amber),
          ),
        ),
        Text(name),
      ],
    );
  }
}
