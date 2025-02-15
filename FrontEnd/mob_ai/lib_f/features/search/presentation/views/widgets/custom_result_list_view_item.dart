import 'package:flutter/material.dart';

import '../../../../../books_details_view.dart';
import '../../../../home/domain/entities/book.dart';

class CustomResultListViewItem extends StatelessWidget {
  const CustomResultListViewItem({super.key, required this.book});
  final Book book;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => BookDetailsView(book: book,)));
        // GoRouter.of(context).push(AppRouter.KBookDetailsView, extra: book);
      },
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            // CustomBookImage(
            //   imageUrl: book.volumeInfo.imageLinks.thumbnail ?? '',
            // ),
            Image.asset('assets/images/images.jpeg'),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      
                    ),
                  ),
                  const SizedBox(height: 4),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Free",
                        style: TextStyle(fontSize: 16),
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
  }
}
