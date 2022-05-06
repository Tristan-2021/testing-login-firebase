import 'package:flutter/material.dart';

import '../presentation/bloc_create_acount/view/create_acount.dart';
import '../presentation/bloc_login/view/splas_cream.dart';
import '../presentation/view/bienvenido.dart';
import '../presentation/view/otherview.dart';

class Routes {
  static Route<dynamic> get(RouteSettings settings) {
    {
      switch (settings.name) {
        case '/':
          return MaterialPageRoute(builder: (_) => const LoginInicio());
        case '/create_acount':
          return PageRouteBuilder(
              pageBuilder: (_, animate, secunradry) => const CreatAcount(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) => child);
        case '/bienvenido':
          return PageRouteBuilder(
              pageBuilder: (_, animate, secunradry) => const Bienvenido(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) => child);
        case '/feets':
          return MaterialPageRoute(builder: (_) => const Feets());

        default:
          return MaterialPageRoute(builder: (_) => const LoginInicio());
      }
    }
  }
}
