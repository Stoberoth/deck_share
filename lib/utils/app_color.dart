/// Palette de couleurs de l'application - Thème sombre violet
/// Basée sur les maquettes design/ai_design/v1/
import 'dart:ui';

class AppColors {
  // ============================================
  // FONDS (Backgrounds)
  // ============================================

  /// Fond principal de l'application (le plus foncé)
  /// Usage : Scaffold, fond de page, arrière-plan général
  static const background = Color.fromARGB(255, 28, 15, 59);

  /// Fond des cartes et conteneurs
  /// Usage : Cards, ListTiles, conteneurs de contenu, modals
  static const surface = Color.fromARGB(255, 48, 37, 85);

  /// Fond des éléments interactifs ou surélevés
  /// Usage : Champs de texte, dropdowns, chips inactifs, sections
  static const surfaceVariant = Color(0xFF2D2D41);

  // ============================================
  // ACCENTS (Couleurs principales)
  // ============================================

  /// Couleur d'accent principale - Violet
  /// Usage : Boutons, FAB, onglets actifs, liens, éléments sélectionnés,
  ///         indicateurs de progression, switches actifs
  static const primary = Color.fromARGB(255, 118, 71, 240);

  /// Couleur d'accent claire - Violet clair
  /// Usage : Hover states, bordures actives, icônes secondaires,
  ///         texte sur fond foncé quand primary est trop vif
  static const primaryLight = Color.fromARGB(255, 77, 56, 116);

  // ============================================
  // STATUTS (Feedback utilisateur)
  // ============================================

  /// Succès - Vert
  /// Usage : Badge "Empruntée", "Rendu", validation, messages de succès,
  ///         indicateurs positifs, checkmarks
  static const success = Color(0xFF22C55E);

  /// Attention - Orange
  /// Usage : Badge "En retard", avertissements, rappels,
  ///         éléments nécessitant attention
  static const warning = Color(0xFFF97316);

  /// Erreur - Rouge
  /// Usage : Messages d'erreur, validation échouée, suppression,
  ///         alertes critiques
  static const error = Color(0xFFEF4444);

  // ============================================
  // TEXTES
  // ============================================

  /// Texte principal - Blanc
  /// Usage : Titres, texte important, contenu principal
  static const textPrimary = Color(0xFFFFFFFF);

  /// Texte secondaire - Gris clair
  /// Usage : Sous-titres, descriptions, labels, métadonnées,
  ///         texte d'aide, placeholders
  static const textSecondary = Color(0xFF9CA3AF);

  /// Texte désactivé - Gris foncé
  /// Usage : Éléments désactivés, texte très secondaire,
  ///         hints dans les champs de texte
  static const textDisabled = Color(0xFF6B7280);
}