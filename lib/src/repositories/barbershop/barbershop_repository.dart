import 'package:dw_barber_shop/src/core/exceptions/respository_exception.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/model/barbershop_model.dart';

import '../../model/user_model.dart';

abstract interface class BarbershopRepository {
  Future<Either<RespositoryException, BarbershopModel>> getMyBarberShop(
      UserModel userModel);
}
