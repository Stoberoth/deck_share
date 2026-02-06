# Refactoring Atomic Design - UI

Ce document liste les modifications recommandées pour que le dossier `lib/ui` respecte pleinement les principes de l'Atomic Design.

---

## Structure actuelle

```
ui/
├── atom/
│   ├── base_button.dart
│   ├── base_card.dart
│   ├── base_dismissible.dart      ⚠️ À déplacer
│   ├── base_floating_action_button.dart
│   ├── base_icon_button.dart
│   ├── base_list_tile.dart        ⚠️ À déplacer (optionnel)
│   └── base_text_field.dart
├── molecules/
│   ├── card_list_view.dart        ⚠️ À déplacer
│   └── search_bar.dart
├── organisms/
│   └── base_app_bar.dart
└── templates/
    ├── base_template.dart
    └── home_template.dart
```

---

## Fichiers à déplacer

### 1. `base_dismissible.dart` : atom → molecules

**Chemin actuel** : `lib/ui/atom/base_dismissible.dart`  
**Nouveau chemin** : `lib/ui/molecules/base_dismissible.dart`

**Raison** : Ce widget compose plusieurs atoms (`BaseButton`) et contient une logique de dialogue. Ce n'est plus un élément atomique indivisible.

**Fichiers à mettre à jour après déplacement** :
- `lib/ui/molecules/card_list_view.dart` → Modifier l'import

```dart
// Avant
import 'package:deck_share/ui/atom/base_dismissible.dart';

// Après
import 'package:deck_share/ui/molecules/base_dismissible.dart';
```

---

### 2. `base_list_tile.dart` : atom → molecules (optionnel)

**Chemin actuel** : `lib/ui/atom/base_list_tile.dart`  
**Nouveau chemin** : `lib/ui/molecules/base_list_tile.dart`

**Raison** : Ce widget combine `Padding` + `Card` + `ListTile`. Selon une interprétation stricte de l'Atomic Design, c'est une molecule.

**Note** : Ce déplacement est optionnel. Si tu considères que `ListTile` est l'élément de base et que le styling fait partie de son essence, tu peux le laisser dans atoms.

**Fichiers à mettre à jour après déplacement** :
- `lib/ui/molecules/card_list_view.dart` → Modifier l'import

---

### 3. `card_list_view.dart` : molecules → organisms

**Chemin actuel** : `lib/ui/molecules/card_list_view.dart`  
**Nouveau chemin** : `lib/ui/organisms/card_list_view.dart`

**Raisons** :
- Compose plusieurs molecules/atoms (BaseDismissible, BaseListTile)
- Contient de la logique métier (showDialog, setState, gestion de liste)
- Représente une section UI complète et autonome

**Fichiers à mettre à jour après déplacement** :
- Rechercher tous les imports de ce fichier dans le projet et les mettre à jour

---

## Nouveaux composants à créer

### Atoms à créer

#### `lib/ui/atom/base_image.dart`

Widget réutilisable pour afficher des images avec gestion du chargement et des erreurs.

```dart
import 'package:flutter/material.dart';

class BaseImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const BaseImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ?? 
          Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / 
                    loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? 
          const Icon(Icons.broken_image, color: Colors.grey);
      },
    );
  }
}
```

---

#### `lib/ui/atom/base_text.dart`

Widget texte stylisé réutilisable avec différents styles prédéfinis.

```dart
import 'package:flutter/material.dart';
import 'package:deck_share/utils/app_color.dart';

enum TextStyleType { title, subtitle, body, caption, label }

class BaseText extends StatelessWidget {
  final String text;
  final TextStyleType styleType;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const BaseText({
    super.key,
    required this.text,
    this.styleType = TextStyleType.body,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getStyle(context),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle _getStyle(BuildContext context) {
    final textColor = color ?? AppColors.textPrimary;
    
    switch (styleType) {
      case TextStyleType.title:
        return TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      case TextStyleType.subtitle:
        return TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor.withOpacity(0.7),
        );
      case TextStyleType.body:
        return TextStyle(
          fontSize: 14,
          color: textColor,
        );
      case TextStyleType.caption:
        return TextStyle(
          fontSize: 12,
          color: textColor.withOpacity(0.6),
        );
      case TextStyleType.label:
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        );
    }
  }
}
```

---

### Molecules à créer

#### `lib/ui/molecules/stat_card.dart`

Pour les cartes statistiques ("Prêts actifs: 4", "Emprunts actifs: 2").

```dart
import 'package:flutter/material.dart';
import 'package:deck_share/utils/app_color.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).primaryColorLight,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: AppColors.textPrimary),
            const SizedBox(height: 8),
            Text(
              '$label: $value',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

#### `lib/ui/molecules/confirmation_dialog.dart`

Dialogue de confirmation réutilisable (extrait de BaseDismissible).

```dart
import 'package:flutter/material.dart';
import 'package:deck_share/ui/atom/base_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String? message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    super.key,
    required this.title,
    this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: message != null ? Text(message!) : null,
      actions: [
        BaseButton(
          label: confirmLabel,
          onPressed: () {
            Navigator.of(context).pop(true);
            onConfirm?.call();
          },
        ),
        BaseButton(
          label: cancelLabel,
          onPressed: () {
            Navigator.of(context).pop(false);
            onCancel?.call();
          },
        ),
      ],
    );
  }

  /// Méthode statique pour afficher facilement le dialogue
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    String? message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
      ),
    );
  }
}
```

---

#### `lib/ui/molecules/segmented_control.dart`

Pour le switch "Prêtés / Empruntés".

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deck_share/utils/app_color.dart';

class BaseSegmentedControl<T> extends StatelessWidget {
  final T groupValue;
  final Map<T, String> segments;
  final ValueChanged<T?> onValueChanged;
  final Color? backgroundColor;
  final Color? thumbColor;

  const BaseSegmentedControl({
    super.key,
    required this.groupValue,
    required this.segments,
    required this.onValueChanged,
    this.backgroundColor,
    this.thumbColor,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<T>(
      groupValue: groupValue,
      backgroundColor: backgroundColor ?? 
        Theme.of(context).colorScheme.secondary.withOpacity(0.3),
      thumbColor: thumbColor ?? Theme.of(context).primaryColorLight,
      children: segments.map(
        (key, value) => MapEntry(
          key,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              value,
              style: TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ),
      ),
      onValueChanged: onValueChanged,
    );
  }
}
```

---

#### `lib/ui/molecules/loan_card_item.dart`

Pour un élément de prêt individuel (basé sur le design).

```dart
import 'package:flutter/material.dart';
import 'package:deck_share/ui/atom/base_image.dart';
import 'package:deck_share/utils/app_color.dart';

enum LoanStatus { onTime, warning, overdue }

class LoanCardItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int cardCount;
  final String borrowerName;
  final int daysSince;
  final DateTime expectedReturn;
  final LoanStatus status;
  final VoidCallback? onTap;

  const LoanCardItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.cardCount,
    required this.borrowerName,
    required this.daysSince,
    required this.expectedReturn,
    this.status = LoanStatus.onTime,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: BaseImage(
                  imageUrl: imageUrl,
                  width: 60,
                  height: 84,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              // Contenu
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        _buildStatusIndicator(),
                      ],
                    ),
                    const SizedBox(height: 4),
                    _buildInfoRow(Icons.copy, '$cardCount cartes'),
                    _buildInfoRow(Icons.person_outline, 'Prêté à: $borrowerName'),
                    _buildInfoRow(Icons.access_time, 'Depuis $daysSince jours'),
                    _buildInfoRow(
                      Icons.calendar_today,
                      'Retour prévu: ${_formatDate(expectedReturn)}',
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    Color color;
    switch (status) {
      case LoanStatus.onTime:
        color = Colors.green;
        break;
      case LoanStatus.warning:
        color = Colors.orange;
        break;
      case LoanStatus.overdue:
        color = Colors.red;
        break;
    }
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textPrimary.withOpacity(0.7)),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textPrimary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonth(date.month)}';
  }

  String _getMonth(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
```

---

## Structure cible finale

```
ui/
├── atom/
│   ├── base_button.dart
│   ├── base_card.dart
│   ├── base_floating_action_button.dart
│   ├── base_icon_button.dart
│   ├── base_image.dart              ← NOUVEAU
│   ├── base_text.dart               ← NOUVEAU
│   └── base_text_field.dart
├── molecules/
│   ├── base_dismissible.dart        ← DÉPLACÉ depuis atom/
│   ├── base_list_tile.dart          ← DÉPLACÉ depuis atom/ (optionnel)
│   ├── base_segmented_control.dart  ← NOUVEAU
│   ├── confirmation_dialog.dart     ← NOUVEAU
│   ├── loan_card_item.dart          ← NOUVEAU
│   ├── search_bar.dart
│   └── stat_card.dart               ← NOUVEAU
├── organisms/
│   ├── base_app_bar.dart
│   └── card_list_view.dart          ← DÉPLACÉ depuis molecules/
└── templates/
    ├── base_template.dart
    └── home_template.dart
```

---

## Ordre des tâches recommandé

1. [ ] Créer `lib/ui/atom/base_image.dart`
2. [ ] Créer `lib/ui/atom/base_text.dart`
3. [ ] Déplacer `base_dismissible.dart` vers molecules/
4. [ ] Mettre à jour les imports de `base_dismissible.dart`
5. [ ] Créer `lib/ui/molecules/confirmation_dialog.dart`
6. [ ] Créer `lib/ui/molecules/stat_card.dart`
7. [ ] Créer `lib/ui/molecules/base_segmented_control.dart`
8. [ ] Créer `lib/ui/molecules/loan_card_item.dart`
9. [ ] Déplacer `card_list_view.dart` vers organisms/
10. [ ] Mettre à jour les imports de `card_list_view.dart`
11. [ ] (Optionnel) Déplacer `base_list_tile.dart` vers molecules/

---

## Notes

- Les nouveaux composants sont basés sur le design `loan_list_ui_design.png`
- Les couleurs utilisent `AppColors` de `lib/utils/app_color.dart`
- Adapter les styles selon ton thème et tes besoins spécifiques
