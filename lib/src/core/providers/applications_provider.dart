import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/core/restClient/rest_client.dart';
import 'package:dw_barber_shop/src/model/barbershop_model.dart';
import 'package:dw_barber_shop/src/model/user_model.dart';
import 'package:dw_barber_shop/src/repositories/barbershop/barbershop_repository.dart';
import 'package:dw_barber_shop/src/repositories/barbershop/barbershop_repository_impl.dart';
import 'package:dw_barber_shop/src/repositories/user_repository.dart';
import 'package:dw_barber_shop/src/repositories/user_repository_impl.dart';
import 'package:dw_barber_shop/src/services/users_login/user_login_service.dart';

import 'package:dw_barber_shop/src/services/users_login/user_login_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'applications_provider.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();
@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();
  return switch (result) {
    Sucess(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImpl(restCli: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarberShop(GetMyBarberShopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);
  final barberShopRepository = ref.watch(barbershopRepositoryProvider);
  final result = await barberShopRepository.getMyBarberShop(userModel);
  return switch (result) {
    Sucess(value: final barbershop) => barbershop,
    Failure(:final exception) => throw exception
  };
}
