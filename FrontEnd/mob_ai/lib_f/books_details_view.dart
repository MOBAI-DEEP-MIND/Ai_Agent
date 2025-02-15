// import 'package:flutter/material.dart';

// import 'features/home/domain/entities/book.dart';

// class BookDetailsPage extends StatelessWidget {

//   const BookDetailsPage({super.key,required this.book});
//   final Book book;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Book Cover Image
//               Container(
//                 height: 300,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(
//                       'https://picsum.photos/400/600?random=1',
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),

//               // Title and Author
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Of the Dark Moon',
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Roboto',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'By Melissa Kieran',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.grey[600],
//                         fontFamily: 'OpenSans',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 24),

//               // Purchase Button
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFEA5455),
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {
//                       // Handle purchase
//                     },
//                     child: Text(
//                       'Purchase - \$10,000',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 32),

//               // Description Section
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Description',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Roboto',
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       'Of the Dark Moon by Melissa Kieran is a novella in the Wolves of Morai series, '
//                       'exploring the forbidden romance between Adrien, a wolf prince, and Ranna, '
//                       'a witch with dangerous secrets. Their love defies fate, challenging the '
//                       'boundaries between shifters and witches. As hidden truths surface, their '
//                       'bond is tested by betrayal.',
//                       style: TextStyle(
//                         fontSize: 16,
//                         height: 1.5,
//                         color: Colors.grey[700],
//                         fontFamily: 'OpenSans',
//                       ),
//                       textAlign: TextAlign.justify,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 32),

//               // Back Button
//               Center(
//                 child: TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text(
//                     'Go Back',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Color(0xFF2D4059),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common/widgets/custom_button.dart' show CustomButton;
import 'core/theme/app_pallete.dart';
import 'features/home/domain/entities/book.dart';
import 'features/home/presentation/bloc/book_bloc.dart';

class BookDetailsView extends StatefulWidget {
  const BookDetailsView({super.key, required this.book});
  final Book book;
  @override
  // ignore: library_private_types_in_public_api
  _BookDetailsViewState createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    // Approximate background color from screenshot

    return Scaffold(
      appBar: AppBar(
        foregroundColor: null,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.left_chevron,
            color: Color(0xFFE18673),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Book details",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE18673),
          ),
        ),
        backgroundColor: AppPallete.backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book Cover
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.4,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Title, Author, Rating, etc.
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.book.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFE18673),
                            ),
                          ),
                          const SizedBox(height: 4),

                          const SizedBox(height: 8),
                          // Rating + Purchases
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const SizedBox(width: 8),
                              Text(
                                'published at ${widget.book.publicationDate}',
                                style: TextStyle(
                                  fontSize: 14,

                                  color: Color(0xFFE18673),
                                ),
                              ),
                              Text(
                                '${widget.book.price.toString()} £',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,

                                  color: Color(0xFFE18673),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Quantity
                          Row(
                            children: [
                              const Text(
                                'Quantity',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,

                                  color: Color(0xFFE18673),
                                ),
                              ),
                              const SizedBox(width: 8),
                              _buildQuantityButton(
                                icon: Icons.remove,
                                onPressed: () {
                                  setState(() {
                                    if (_quantity > 1) {
                                      _quantity--;
                                    }
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  '$_quantity',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,

                                    color: Color(0xFFE18673),
                                  ),
                                ),
                              ),
                              _buildQuantityButton(
                                icon: Icons.add,
                                onPressed: () {
                                  setState(() {
                                    _quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Add to wish list
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Description
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE18673),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.book.description,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,

                    height: 2,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 44,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFFE18673)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Go back',
                        style: TextStyle(
                          color: Color(0xFFE18673),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    // Add to cart
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,

                      child: CustomButton(
                        hintText: 'Add to cart',
                        onTap: () {
                          context.read<BookBloc>().add(
                            AddBookToCart(widget.book),
                          );
                          context.read<BookBloc>().booksInCart.add(widget.book);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        iconSize: 16,
        padding: EdgeInsets.zero,
        icon: Icon(icon, color: Colors.black87),
        onPressed: onPressed,
      ),
    );
  }
}
