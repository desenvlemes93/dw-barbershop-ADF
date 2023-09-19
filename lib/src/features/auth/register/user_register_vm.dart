import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/core/providers/applications_provider.dart';
import 'package:dw_barber_shop/src/features/auth/register/user_register_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_vm.g.dart';

enum UserRegisterStateStatus {
  initial,
  success,
  error,
}

@riverpod
class UserRegisterVm extends _$UserRegisterVm {
  @override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial;
  Future<void> register({
    required String name,
    required String email,
    required String senha,
  }) async {
    final userRegisterService = ref.watch(userRegisterAdmServiceProvider);
    final userData = (
      name: name,
      email: email,
      password: senha,
    );

    final registerResult =
        await userRegisterService.execute(userData).asyncLoader();
    switch (registerResult) {
      case Sucess():
        ref.invalidate(getMeProvider);
        state = UserRegisterStateStatus.success;
      case Failure():
        state = UserRegisterStateStatus.error;
    }
  }
}
