import 'package:firebase_auth/firebase_auth.dart';

class AuthErrorHandling {
  static String getErrorMessage(dynamic error)
  {
    if(error is FirebaseAuthException)
    {
      return _mapFirebaseError(error.code);
    }
    else
    {
      return "Une erreur inattendue s'est produite";
    }
  }

  static String _mapFirebaseError(String code)
  {
    switch(code)
    {
      case 'user-not-found':
        return 'Aucun utilisateur trouvé';
      case 'wrong-password':
        return "Mot de passe incorrect";
      case 'invalid-email':
        return "Format d'email invalide";
      case 'user-disabled':
        return "Ce compte a été désactivé";
      case 'invalid-credential':
        return "Identifiants invalides";

      case 'email-already-in-use':
        return "Cet email est déjà utilisé";
      case 'weak-password':
        return "Mot de passe trop faible";
      case 'operation-not-allowed':
        return "Inscription désactivée temporairement";

      case 'network-request-failed':
        return "Erreur de connexion. Vérifiez votre internet";
      case 'too-many-requests':
        return "Trop de tentatives. Réessayez plus tard";
      case 'requires-recent-login':
        return "Veuillez vous reconnecter pour continuer";
      
      default:
        return "Erreur d'authentification ($code)";

    }
  }
}