import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barber_shop/src/core/exceptions/service_exception.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/core/providers/applications_provider.dart';
import 'package:dw_barber_shop/src/features/auth/login/login_state.dart';
import 'package:dw_barber_shop/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandle = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);
    final result = await loginService.execute(email, password);

    switch (result) {
      case Sucess():
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarberShopProvider);
        final userModel = await ref.read(getMeProvider.future);
        switch (userModel) {
          case UserModelAdm():
            state = state.copyWith(status: LoginStateStatus.admLogin);
          case UserModelEmployee():
            state = state.copyWith(status: LoginStateStatus.employeee);
        }

        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }
    loaderHandle.close();
  }
}
