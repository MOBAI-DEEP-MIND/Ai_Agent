import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../books_details_view.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../domain/entities/book.dart';

class BookCollections extends StatelessWidget {
  const BookCollections({
    super.key,
    required this.collectionName,
    required this.books,
  });
  final String collectionName;
  final List<Book> books;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text(
                collectionName, // Use parameter instead of hardcoded text
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,

                  color: AppPallete.primaryColor,
                ),
              ),
              const Spacer(),
              const Icon(
                CupertinoIcons.right_chevron,
                color: AppPallete.primaryColor,
              ),
            ],
          ),
        ),
SizedBox(height: 10,),
        SizedBox(
          height: 200, // Explicit height for horizontal ListView
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:books.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) =>BookDetailsView(book:books[index] ,)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/images.jpeg',
                          width: 100, // Fixed width for each item
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        books[index].title.length > 10 ?'${books[index].title.substring( 0,  10)}...': books[index].title, 
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppPallete.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
