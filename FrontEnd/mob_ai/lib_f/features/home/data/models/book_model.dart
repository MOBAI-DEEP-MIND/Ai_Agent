import '../../domain/entities/book.dart';

class BookModel extends Book {
  BookModel({
    
    required super.id,
    required super.title,
    required super.url,
    required super.description,
    required super.price, required super.publisher, required super.publicationDate,
  });
}
