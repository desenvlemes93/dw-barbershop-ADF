import 'package:dw_barber_shop/src/core/providers/applications_provider.dart';
import 'package:dw_barber_shop/src/services/user_register/user_register_service.dart';
import 'package:dw_barber_shop/src/services/user_register/user_register_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_provider.g.dart';

@riverpod
UserRegisterAdmService userRegisterAdmService(UserRegisterAdmServiceRef ref) =>
    UserRegisterAdmServiceImpl(
      userRepository: ref.watch(userRepositoryProvider),
      userLoginService: ref.watch(userLoginServiceProvider),
    );
