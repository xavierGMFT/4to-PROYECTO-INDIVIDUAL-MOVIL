class Validators {
  // Validacion de email
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
        .hasMatch(value)) {
      return 'Por favor ingrese un email válido';
    }
    return null;
  }

  // Validacion de contraseña
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  // Validación de nombre de usuario
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre es requerido';
    }
    if (value.contains(' ')) {
      return 'El nombre no puede contener espacios';
    }
    return null;
  }

  // Validación de dirección
  static String? addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'La dirección es requerida';
    }
    return null;
  }

  // Validación de teléfono
  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de teléfono es requerido';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Por favor ingrese un número de teléfono válido';
    }
    return null;
  }
}
