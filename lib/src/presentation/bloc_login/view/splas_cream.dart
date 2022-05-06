import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utlis.dart';
import '../../../core/validaters.dart';
import '../cubit/loginusers_cubit.dart';

class LoginInicio extends StatelessWidget {
  const LoginInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: BlocConsumer<LoginusersCubit, LoginusersState>(
          listener: (context, state) {
        if (state.status.isAutenticate) {
          log('evento del Usuario ${state.usaurio.id}');
          Navigator.pushNamedAndRemoveUntil(
              context, '/bienvenido', (route) => false);
          // context.read<LoginusersCubit>().close();
        } else if (state.status.isNoatenticated) {
          showMessage(state.mensaje, scaffoldKey);
          // showBanner(context, state.mensaje);

        }
      }, builder: (context, state) {
        if (state.status.isIngresando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isNoatenticated || state.status.issaliendo) {
          // usar absorver pointer
          return FormLogin(
            formKey: formKey,
            mensaje: state.mensaje,
          );
        } else {
          return const Center();
        }
      }),
    );
  }

  void showMessage(String message, scaffoldKey) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(snackbar);
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({
    Key? key,
    required this.formKey,
    required this.mensaje,
  }) : super(key: key);
  final String mensaje;

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    String _email = '';
    String _passwor = '';
    return SafeArea(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            const Text(
              'Inicair Sesión',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 25.0),
            Container(
              margin: const EdgeInsets.all(10.0),
              color: colorshemazulclaro,
              child: TextFormField(
                key: keyemailInput,
                onSaved: (value) => _email = value ?? '',
                validator: (val) => validateEmail(val),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  // helperText: mensaje,
                  icon: Icon(
                    Icons.event_note,
                  ),
                  hintText: 'Ingrese su email',
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              margin: const EdgeInsets.all(10.0),
              color: colorshemazulclaro,
              child: TextFormField(
                key: keypaswordInput,
                obscureText: true,
                onSaved: (value) => _passwor = value ?? '',
                validator: (val) => validatePasword(val),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.security_rounded,
                  ),
                  hintText: 'Ingrese su contraseña',
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const SizedBox(height: 10.0),
            TextButton(
              key: keytextButton,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final form = formKey.currentState;
                  form!.save();
                  context
                      .read<LoginusersCubit>()
                      .isIngresar(_email.trim(), _passwor.trim());
                }
              },
              child: const Text(
                'Ingresar',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            TextButton(
              key: keytextcreateacount,
              onPressed: () {
                Navigator.pushNamed(context, '/create_acount');
              },
              child: const Text(
                'Crear Cuenta',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
