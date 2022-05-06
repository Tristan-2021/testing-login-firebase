import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_login/cubit/loginusers_cubit.dart';

class Bienvenido extends StatelessWidget {
  const Bienvenido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('bienvenido'),
      ),
      body: Column(
        children: [
          const FittedBox(child: Text('Bienvenido')),
          TextButton(
              onPressed: () async {
                context.read<LoginusersCubit>().signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/inicio', (route) => false);
              },
              child: const Text('Cuenta de Usuario')),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/feets');
              },
              child: const Text('Feets')),
        ],
      ),
    );
  }
}
