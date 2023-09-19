import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barber_shop/src/core/ui/widgets/babershop_loader.dart';
import 'package:dw_barber_shop/src/core/ui/widgets/barbershop_nav_global_key.dart';
import 'package:dw_barber_shop/src/core/ui/widgets/barbershop_theme.dart';
import 'package:dw_barber_shop/src/features/auth/login/login_page.dart';
import 'package:dw_barber_shop/src/features/auth/register/user_register_page.dart';
import 'package:dw_barber_shop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BabershopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'Dw Barbershop',
          theme: BarbershopTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: BarbershopNavGlobalKey.instance.navKey,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/register/user': (_) => const UserRegisterPage(),
            '/auth/register/barbershop': (_) => const Text('Adm BarberShop'),
            '/home/adm': (_) => const Text('ADM'),
            '/home/employee': (_) => const Text('Employee'),
          },
        );
      },
    );
  }
}
