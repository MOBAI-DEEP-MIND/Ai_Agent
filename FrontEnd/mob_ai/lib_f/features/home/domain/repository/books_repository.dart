import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/book.dart';

abstract interface  class BooksRepository {
  Future<Either<Failure, List<Book>>> fetchBooks();

  Future<Either<Failure, List<Book>>> fetchRecomendedBooks();
  Future<Either<Failure, Book>> fetchBookByKeyWorld(String keyWord);
  Future<Either<Failure, Book>> addBookToMyCart(Book book);
  Future<Either<Failure,List< Book>>> getCartBooks();
}