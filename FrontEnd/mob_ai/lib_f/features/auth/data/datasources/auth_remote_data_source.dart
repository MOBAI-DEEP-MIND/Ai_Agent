import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/secrets/app_secrets.dart';
import '../../../../init_dependencies.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<User> signUpWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  });
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  // Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImplementation({required this.dio});
  @override
  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      log('email: $email, password: $password');
      final response = await dio.post(
        AppSecrets.signInEndpoint,
        data: {"email": email, "password": password},
      );
      await serviceLocator<Box>().put("accesstoken", response.data['access']);
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<User> signUpWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      log('name: $username, email: $email, password: $password');
      final response = await dio.post(
        AppSecrets.signUpEndpoint,
        data: {"email": email, "username": username, "password": password},
      );
      log(response.data.toString());
      await serviceLocator<Box>().put("posterId", response.data["id"]);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      log(e.message!);
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
