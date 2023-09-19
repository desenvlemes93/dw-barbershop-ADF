import 'package:dw_barber_shop/src/core/exceptions/auth_exceptions.dart';
import 'package:dw_barber_shop/src/core/exceptions/respository_exception.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/core/fp/nil.dart';
import 'package:dw_barber_shop/src/model/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
  Future<Either<RespositoryException, UserModel>> me();
  Future<Either<RespositoryException, Nil>> registerAdmin(
      ({
        String email,
        String name,
        String password,
      }) userData);
}
