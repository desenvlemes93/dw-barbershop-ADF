import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barber_shop/src/core/exceptions/auth_exceptions.dart';
import 'package:dw_barber_shop/src/core/exceptions/respository_exception.dart';

import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/core/fp/nil.dart';
import 'package:dw_barber_shop/src/core/restClient/rest_client.dart';
import 'package:dw_barber_shop/src/model/user_model.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({
    required this.restClient,
  });
  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });

      return Sucess(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log(
            'Login ou senha invalidos',
            error: e,
            stackTrace: s,
          );
          return Failure(AuthUnauthorizedException());
        }
      }
      log(
        'Erro ao realizar login',
        error: e,
        stackTrace: s,
      );
      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }

  @override
  Future<Either<RespositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Sucess(
        UserModel.fromMap(data),
      );
    } on DioException catch (e, s) {
      log(
        'Erro ao buscaR USUARIO LOAGO',
        error: e,
        stackTrace: s,
      );
      return Failure(
        RespositoryException(message: 'Erro ao buscar usuario logado'),
      );
    } on ArgumentError catch (e, s) {
      log(
        'Invalie Jso',
        error: e,
        stackTrace: s,
      );
      return Failure(
        RespositoryException(message: e.message),
      );
    }
  }

  @override
  Future<Either<RespositoryException, Nil>> registerAdmin(
      ({String email, String name, String password}) userData) async {
    try {
      await restClient.unAuth.post('/users', data: {
        'name': userData.name,
        'email': userData.email,
        'password': userData.password,
        'profile': 'ADM'
      });
      return Sucess(nil);
    } on DioException catch (e, s) {
      log(
        'Erro ao registar usuario admin',
        error: e,
        stackTrace: s,
      );
      return Failure(RespositoryException(message: 'Erro ao cadastrar Adm'));
    }
  }
}
