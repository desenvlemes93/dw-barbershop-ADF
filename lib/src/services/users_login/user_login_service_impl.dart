import 'package:dw_barber_shop/src/core/constants/local_storage_keys.dart';
import 'package:dw_barber_shop/src/core/exceptions/auth_exceptions.dart';
import 'package:dw_barber_shop/src/core/exceptions/service_exception.dart';

import 'package:dw_barber_shop/src/core/fp/either.dart';

import 'package:dw_barber_shop/src/core/fp/nil.dart';
import 'package:dw_barber_shop/src/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;

  UserLoginServiceImpl({
    required this.userRepository,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Sucess(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Sucess(nil);
      case Failure(:final exception):
        switch (exception) {
          case AuthError():
            return Failure(ServiceException(message: 'Erro ao realizar login'));
          case AuthUnauthorizedException():
            return Failure(
                ServiceException(message: 'Login ou seneha inválidos'));
        }
    }
  }
}
