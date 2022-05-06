import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_login/src/myapp/routes.dart';

import '../presentation/bloc_create_acount/cubit/createacount_cubit.dart';
import '../presentation/bloc_login/cubit/loginusers_cubit.dart';
import 'injeci.dart';

class MyApps extends StatelessWidget {
  const MyApps({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LoginusersCubit(
                  sl(),
                )..getUseres()),
        BlocProvider(
          create: (context) => CreateacountCubit(sl())..getCreateACountInial(),
        ),
      ],
      child: const Appview(),
    );
  }
}

class Appview extends StatelessWidget {
  const Appview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => Routes.get(settings),
    );
  }
}
