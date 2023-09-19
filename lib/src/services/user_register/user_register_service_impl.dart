import 'package:dw_barber_shop/src/core/exceptions/service_exception.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/core/fp/nil.dart';
import 'package:dw_barber_shop/src/repositories/user_repository.dart';
import 'package:dw_barber_shop/src/services/users_login/user_login_service.dart';

import './user_register_service.dart';

class UserRegisterAdmServiceImpl implements UserRegisterAdmService {
  final UserRepository userRepository;
  final UserLoginService userLoginService;
  UserRegisterAdmServiceImpl({
    required this.userRepository,
    required this.userLoginService,
  });
  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userData) async {
    final registerResult = await userRepository.registerAdmin(userData);
    switch (registerResult) {
      case Sucess():
        return userLoginService.execute(
          userData.email,
          userData.password,
        );
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
