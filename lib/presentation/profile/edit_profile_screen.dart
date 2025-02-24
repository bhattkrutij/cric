import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/configs/theme/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Edit profile screen",
          style: TextStyle(fontSize: 16, color: AppColors.primary),
        ),
      ),
    );
  }
}
