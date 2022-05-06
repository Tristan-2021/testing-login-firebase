const String pattern =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$";
final RegExp regex = RegExp(pattern);

String? validateEmail(String? value) {
  if (value == null || !regex.hasMatch(value)) {
    return 'Correo no válido.';
  } else {
    return null;
  }
}

String? validatePasword(String? value) {
  if (value != null) {
    if (value.length > 3) {
      return null;
    } else {
      return 'contraseña muy corta';
    }
  } else {
    return null;
  }
}
