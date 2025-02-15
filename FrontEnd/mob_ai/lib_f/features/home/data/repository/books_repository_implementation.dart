import 'package:fpdart/src/either.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/book.dart';
import '../../domain/repository/books_repository.dart';
import '../datasource/books_remote_data_source.dart';

class BooksRepositoryImplementation implements BooksRepository {
  final BooksRemoteDataSource booksRemoteDataSource;

  BooksRepositoryImplementation(this.booksRemoteDataSource);
  @override
  Future<Either<Failure, List<Book>>> fetchBooks() async {
    try {
      final books = await booksRemoteDataSource.fetchBooks();
      return Right(books);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Book>> addBookToMyCart(Book book)async {
    try {
      final addedbook = await booksRemoteDataSource.addBookToCart(book);
      return Right(addedbook);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Book>> fetchBookByKeyWorld(String keyWord) {
    // TODO: implement fetchBookByKeyWorld
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<Book>>> getCartBooks()async {
    try {
      final addedbook = await booksRemoteDataSource.getBookInCart();
      return Right(addedbook);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Book>>> fetchRecomendedBooks()async {
     try {
      final books = await booksRemoteDataSource.fetchRecomendedBooks();
      return Right(books);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
