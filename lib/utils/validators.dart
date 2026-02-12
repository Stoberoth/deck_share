class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email requis";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Format d\'email invalide";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Mot de passe requis";
    }
    if (value.length < 6) {
      return "Mot de passe trop court (minimum 6 caractère)";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password)
  {
    if (value == null || value.isEmpty)
    {
      return "Confirmation requise";
    }
    if (value != password)
    {
      return "Les mots de passe ne correspondent pas ";
    }
    return null;
  }
}
