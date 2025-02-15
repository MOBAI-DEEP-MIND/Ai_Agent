import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../search/presentation/views/widgets/custom_search_bar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key,required this.busketOnPressed});
  final Function()? busketOnPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProfileAvatar(),

        // CustomSearchBar(),
        GestureDetector(onTap: busketOnPressed,child: _buildNavIcon(Icons.shopping_cart_rounded, 'Messaging')),
      ],
    );
  }

  Widget _buildNavIcon(IconData icon, String tooltip) {
    return Icon(icon, size: 35, color: AppPallete.primaryColor);
  }

  void _handleIconPress(String tooltip) {
    // Handle icon taps
    print('$tooltip tapped!');
  }

  Widget _buildProfileAvatar() {
    return GestureDetector(
      onTap: () => _showProfileMenu(),
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircleAvatar(
          radius: 14,
          backgroundColor: Colors.grey[300],
          backgroundImage: NetworkImage(
            'https://randomuser.me/api/portraits/men/1.jpg',
          ), // Replace with your image
        ),
      ),
    );
  }

  void _showProfileMenu() {
    // Show profile dropdown menu
  }
}
