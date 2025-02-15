// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class CartView extends StatelessWidget {
//   const CartView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: null,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(
//             CupertinoIcons.left_chevron,
//             color: Color(0xFFE18673),
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Cart",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFFE18673),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: ,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common/widgets/custom_button.dart';
import 'core/theme/app_pallete.dart';
import 'features/home/domain/entities/book.dart';
import 'features/home/presentation/bloc/book_bloc.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  void initState() {
    super.initState();
   cartItems= BlocProvider.of<BookBloc>(context).booksInCart;
  }

  late List<Book> cartItems;

  double get totalAmount {
    return cartItems.fold(0, (sum, item) => sum + (item.price * 1));
  }

  int get totalItems {
    return cartItems.fold(0, (sum, item) => sum + 1);
  }

  void updateQuantity(int index, int delta) {
    setState(() {
      // cartItems[index].quantity = (cartItems[index].quantity + delta).clamp(
      //   1,
      //   99,
      // );
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,

        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "cart",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppPallete.primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Book Cover Image
                        Container(
                          width: 80,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://create.microsoft.com/_next/image?url=https%3A%2F%2Fcdn.create.microsoft.com%2Fimages%2Fimage-creator-T03_cat.webp&w=1920&q=90',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Book Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppPallete.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 4),

                              const SizedBox(height: 8),
                              Text(
                                '${item.price.toStringAsFixed(2)} DZD',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,

                                  color: AppPallete.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Quantity Controls
                                  Row(
                                    children: [
                                      _QuantityButton(
                                        icon: Icons.remove,
                                        onPressed:
                                            () => updateQuantity(index, -1),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          '4',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,

                                            color: AppPallete.primaryColor,
                                          ),
                                        ),
                                      ),
                                      _QuantityButton(
                                        icon: Icons.add,
                                        onPressed:
                                            () => updateQuantity(index, 1),
                                      ),
                                    ],
                                  ),
                                  // Delete Button
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => removeItem(index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Bottom Total and Checkout
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,

                        color: AppPallete.primaryColor,
                      ),
                    ),
                    Text(
                      '${totalAmount.toStringAsFixed(2)} DZD',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,

                        color: AppPallete.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomButton(
                  hintText: 'pay now',
                  onTap: () {},
                ), // Add Checkout Button
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        icon: Icon(icon, size: 16),
        onPressed: onPressed,
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      ),
    );
  }
}
