import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/secrets/app_secrets.dart';
import '../../../../init_dependencies.dart';
import '../../../home/domain/entities/book.dart';
import '../../domain/entity/message.dart';

abstract interface class AsisstantRemoteDataSource {
  Future<List<Book>> sendMessage({required Message message});
}

class AsisstantRemoteDataSourceImplementation
    implements AsisstantRemoteDataSource {
  final Dio dio;

  AsisstantRemoteDataSourceImplementation({required this.dio});

  @override
  Future<List<Book>> sendMessage({required Message message}) async {
    try {
      log('message: ${message.content} sender id ${message.senderId} ');
      var options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${serviceLocator<Box>().get("accesstoken")}', // Set the content-length.
        },
      );
      final response = await dio.post(
        AppSecrets .searchIA,
        options:  options,
        data: {'query': message.content, 'senderId': message.senderId},
      );

      List<Book> books = [];
      for (var book in response.data) {
        books.add(Book.fromMap(book as Map<String, dynamic>));
      }
      return books;
    } on DioException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('Failed to send message');
    }
  }
}
