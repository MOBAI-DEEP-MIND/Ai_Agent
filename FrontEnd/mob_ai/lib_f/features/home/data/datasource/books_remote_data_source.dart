import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/secrets/app_secrets.dart';
import '../../../../init_dependencies.dart';
import '../../domain/entities/book.dart';

abstract interface class BooksRemoteDataSource {
  Future<List<Book>> fetchBooks();
Future<List<Book>> fetchRecomendedBooks();
  Future<List<Book>> fetchBookByKeyWorld(String keyWord);
  Future<Book> addBookToCart(Book book);
  Future<Book> removeBookFromCart(Book book);
  Future<List<Book>> getBookInCart();
}

class BooksRemoteDataSourceImplementation implements BooksRemoteDataSource {
  final Dio dio;

  BooksRemoteDataSourceImplementation(this.dio);
  @override
  Future<List<Book>> fetchBooks() async {
    try {
      log(serviceLocator<Box>().get("accesstoken"));
      var options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${serviceLocator<Box>().get("accesstoken")}', // Set the content-length.
        },
      );
      Response response = await dio.get(
        AppSecrets.booksEndPoint,
        options: options,
      );

      List<Book> books = [];
      for (var book in response.data) {
        books.add(Book.fromMap(book as Map<String, dynamic>));
      }
      return books;
    } catch (e) {
      throw ServerException('Failed to fetch books');
    }
  }

  @override
  Future<Book> addBookToCart(Book book) async {
    try {
      var options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${serviceLocator<Box>().get("accesstoken")}', // Set the content-length.
        },
      );
      Response response = await dio.post(
        AppSecrets.addBookCart,
        data: {
          "book": [book.id],
          "user": serviceLocator<Box>().get("posterId"),
        },
        options: options,
      );
      return Book.fromMap(response as Map<String, dynamic>);
    } catch (e) {
      throw ServerException('Failed to fetch books');
    }
  }

  @override
  Future<List<Book>> fetchBookByKeyWorld(String keyWord) {
    // TODO: implement fetchBookByKeyWorld
    throw UnimplementedError();
  }

  @override
  Future<List<Book>> getBookInCart() async {
    try {
      var options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${serviceLocator<Box>().get("accesstoken")}', // Set the content-length.
        },
      );
      Response response = await dio.get(
        AppSecrets.booksEndPoint,
        options: options,
      );
      List<Book> books = [];
      for (var book in response.data) {
        books.add(Book.fromMap(book as Map<String, dynamic>));
      }

      return books;
    } catch (e) {
      throw ServerException('Failed to fetch books');
    }
  }

  @override
  Future<Book> removeBookFromCart(Book book) {
    // TODO: implement removeBookFromCart
    throw UnimplementedError();
  }
  
  @override
  Future<List<Book>> fetchRecomendedBooks() async{

    try {
      log(serviceLocator<Box>().get("accesstoken"));
      var options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${serviceLocator<Box>().get("accesstoken")}', // Set the content-length.
        },
      );
      Response response = await dio.get(
        AppSecrets.recommendedbooksEndPoint,
        options: options,
      );

      List<Book> books = [];
      for (var book in response.data) {
        books.add(Book.fromMap(book as Map<String, dynamic>));
      }
      return books;
    } catch (e) {
      throw ServerException('Failed to fetch books');
    }
  }
}
