import 'package:flutter/material.dart';

import '../../theme/app_pallete.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, required this.hintText});
  final void Function()? onTap;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppPallete.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          hintText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
