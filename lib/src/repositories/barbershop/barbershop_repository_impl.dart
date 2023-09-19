import 'package:dio/dio.dart';
import 'package:dw_barber_shop/src/core/exceptions/respository_exception.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/core/restClient/rest_client.dart';
import 'package:dw_barber_shop/src/model/barbershop_model.dart';
import 'package:dw_barber_shop/src/model/user_model.dart';

import './barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restCli;
  BarbershopRepositoryImpl({
    required this.restCli,
  });
  @override
  Future<Either<RespositoryException, BarbershopModel>> getMyBarberShop(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelAdm():
        final Response(:data) = await restCli.auth.get(
          'barbershop',
          queryParameters: {
            'user_id': '#userAuthRef',
          },
        );
        return Sucess(BarbershopModel.fromMap(data));
      case UserModelEmployee():
        final Response(
          data: List(
            first: data,
          ),
        ) = await restCli.auth.get(
          'barbershop/${userModel.babershopId}',
        );
        return Sucess(BarbershopModel.fromMap(data));
    }
  }
}
