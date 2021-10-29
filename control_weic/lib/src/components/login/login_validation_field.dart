class LoginValidationField {
  validationEmail(String? value) {
    if (!value!.contains('@') || value.length < 11) {
      return 'email invalido';
    }
  }

  validationPassword(String? value) {
    if (value!.length < 8) {
      return 'passoword invalido';
    }
  }
}
