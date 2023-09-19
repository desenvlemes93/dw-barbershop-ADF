import 'package:dw_barber_shop/src/core/exceptions/respository_exception.dart';
import 'package:dw_barber_shop/src/core/exceptions/service_exception.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/core/fp/nil.dart';

abstract interface class UserRegisterAdmService {
  Future<Either<ServiceException, Nil>> execute(
      ({
        String name,
        String email,
        String password,
      }) userData);
}
