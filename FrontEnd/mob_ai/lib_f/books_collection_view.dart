import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_pallete.dart';
import 'features/home/domain/entities/book.dart';

class BooksCollectionView extends StatelessWidget {
  const BooksCollectionView({
    super.key,
    required this.collectionName,
    required this.books,
  });
  final String collectionName;
  final List<Book> books;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: null,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.left_chevron,
            color: Color(0xFFE18673),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Book Collection",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE18673),
          ),
        ),
        backgroundColor: AppPallete.backgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final item = books[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            spacing: 10,
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
        ],
      ),
    );
  }
}
