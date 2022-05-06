import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utlis.dart';
import '../../../core/validaters.dart';
import '../cubit/createacount_cubit.dart';

class CreatAcount extends StatelessWidget {
  const CreatAcount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final scaffoldKeys = GlobalKey<ScaffoldState>();
    // return Scaffold();
    return Scaffold(
      key: scaffoldKeys,
      appBar: AppBar(
        title: const Text(
          'Crear Cuenta',
          style: TextStyle(fontSize: 18.0),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<CreateacountCubit, CreateacountState>(
          listener: (context, state) {
        if (state.status.isSuccesful) {
          showMessage(state.mensaje, scaffoldKeys);
        }
      }, builder: (context, state) {
        if (state.status.iscargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return FormCreateACount(
          formKey: formKey,
          mensaje: state.mensaje,
        );
      }),
    );
  }

  void showMessage(String message, scaffoldKey) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(snackbar);
  }
}

class FormCreateACount extends StatelessWidget {
  const FormCreateACount({
    Key? key,
    required this.formKey,
    this.mensaje = '',
  }) : super(key: key);
  final String mensaje;

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    String _email = 'vacio';
    String _passwor = 'vacio';
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
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
              decoration: InputDecoration(
                helperText: mensaje,
                icon: const Icon(
                  Icons.security_rounded,
                ),
                hintText: 'Ingrese su contraseña',
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          TextButton(
            key: keytextButton,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                //Todo para las pruebas se hacce está validación

                context
                    .read<CreateacountCubit>()
                    .getCreateACount(_email.trim(), _passwor.trim());
              }
            },
            child: const Text(
              'Crear Cuenta',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
