import 'package:flutter/material.dart';

import '../../../../../core/theme/app_pallete.dart';
class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: TextField(
          onSubmitted: (_) {
            
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search, color: AppPallete.primaryColor),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
