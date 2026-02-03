# Plan de Développement - Fonctionnalité Prêts de Cartes

## Vue d'ensemble

Cette fonctionnalité permet de gérer les prêts de cartes Magic entre joueurs, avec intégration à la wishlist existante.

> **Note** : Une base existe déjà dans `lib/share_cards/`. Ce plan indique ce qui est fait et ce qu'il reste à faire.

---

## État actuel du projet

### Ce qui est fait ✅

| Élément | Fichier | Statut |
|---------|---------|--------|
| Modèle ShareCards | `lib/share_cards/domain/share_cards_model.dart` | ✅ Bien placé |
| Enum ShareCardsStatus | `lib/share_cards/domain/share_cards_model.dart` | ✅ |
| Champs enrichis | `title`, `expectedReturnDate`, `returnedAt`, `status`, `notes` | ✅ |
| Repository interface | `lib/share_cards/data/share_card_repository.dart` | ✅ |
| Repository local | `lib/share_cards/data/share_card_local_repository.dart` | ✅ |
| Services | `lib/share_cards/application/share_cards_services.dart` | ✅ Complet |
| Controller | `lib/share_cards/presentation/controller/share_cards_controller.dart` | ✅ Complet |
| Page liste | `lib/share_cards/presentation/page/home_share_cards.dart` | ✅ Stats + Tabs |
| Page création | `lib/share_cards/presentation/page/loan_creation_page.dart` | ✅ Complet |
| Page détail | `lib/share_cards/presentation/page/share_cards_details_page.dart` | ⚠️ Partiel |
| Widget liste | `lib/share_cards/presentation/widget/share_cards_list.dart` | ✅ |
| Scryfall picker | `lib/scryfall_searcher/` | ✅ Complet |
| Composants UI | `lib/ui/` | ✅ Atoms, molecules, organisms, templates |
| Navigation | `lib/home/home.dart` | ✅ Bottom nav avec ShareCards |
| Thème couleurs | `lib/utils/app_color.dart` | ✅ Palette sombre violet |
| DatePicker | `lib/ui/molecules/molecule_date_picker.dart` | ✅ Nouveau |
| LoanSubtitle | `lib/ui/molecules/molecule_loan_subtitle.dart` | ✅ Nouveau |
| ShadowImage | `lib/ui/molecules/molecule_shadow_image.dart` | ✅ Nouveau |
| LoanCard | `lib/ui/organisms/organism_loan_card.dart` | ✅ Nouveau |
| LoanList Template | `lib/ui/templates/template_loan_list.dart` | ✅ Nouveau |

### Ce qui reste à faire ❌

| Élément | Description |
|---------|-------------|
| Page détail | Titre du prêt, badge statut, boutons actions (marquer rendu, prolonger), section notes |
| Gestion contacts | Modèle Contact + repository + services (optionnel) |
| Intégration Wishlist | Badge "Empruntée" sur les cartes |

---

## Phase 1 : Corrections urgentes ✅ TERMINÉE

### Étape 1.1 : Déplacer le modèle ✅ FAIT

**Action** : ~~Déplacer `.cursor/rules/share_cards_model.dart` vers `lib/share_cards/domain/share_cards_model.dart`~~

Le modèle est maintenant dans `lib/share_cards/domain/share_cards_model.dart`

---

### Étape 1.2 : Enrichir le modèle ShareCards ✅ FAIT

**Fichier** : `lib/share_cards/domain/share_cards_model.dart`

**Tous les champs sont présents** :
- `id` ✅
- `title` ✅
- `expectedReturnDate` ✅
- `returnedAt` ✅
- `status` ✅
- `notes` ✅
- `lender` ✅
- `applicant` ✅
- `lendingCards` ✅
- `lendingDate` ✅

**Enum créé** ✅ :
```dart
enum ShareCardsStatus {
  active,    // Prêt en cours
  returned,  // Prêt rendu
  overdue,   // Prêt en retard
}
```

**Getter `isOverdue`** ✅ implémenté

---

## Phase 2 : Mettre à jour les couches existantes ✅ TERMINÉE

### Étape 2.1 : Mettre à jour le Repository ✅ FAIT

**Fichier** : `lib/share_cards/data/share_card_local_repository.dart`

La sérialisation gère tous les nouveaux champs via `toJson()` et `fromJson()`.

---

### Étape 2.2 : Mettre à jour les Services ✅ FAIT

**Fichier** : `lib/share_cards/application/share_cards_services.dart`

**Méthodes implémentées** :
- ✅ `markAsReturned(String id)` - Marquer un prêt comme rendu
- ✅ `extendLoan(String id, DateTime newReturnDate)` - Prolonger un prêt
- ✅ `getByStatus(ShareCardsStatus status)` - Filtrer par statut
- ✅ `getLentCards()` - Prêts que je fais (lender = "Me")
- ✅ `getBorrowedCards()` - Prêts que je reçois (applicant = "Me")
- ✅ `getNumberOfLent()` - Nombre de prêts actifs
- ✅ `getNumberOfBorrow()` - Nombre d'emprunts actifs

---

### Étape 2.3 : Mettre à jour le Controller ✅ FAIT

**Fichier** : `lib/share_cards/presentation/controller/share_cards_controller.dart`

**Implémenté** :
- ✅ `markAsReturned(String id)`
- ✅ `extendLoan(String id, DateTime newReturnDate)`
- ✅ `getByStatus(ShareCardsStatus status)`
- ✅ `getLentCards()` / `getBorrowedCards()`
- ✅ `getNumberOfLent()` / `getNumberOfBorrow()`

---

## Phase 3 : Mettre à jour les Pages UI ⚠️ EN COURS (90% terminé)

### Étape 3.1 : Page d'accueil des prêts ✅ FAIT

**Fichier** : `lib/share_cards/presentation/page/home_share_cards.dart`

**Référence maquette** : `design/ai_design/v1/loan_list_ui_design.png`

**Modifications faites** :
- [x] Ajouter les cartes statistiques en haut (prêts actifs / emprunts actifs)
- [x] Ajouter TabBar : "Prêtés" / "Empruntés" (via `BaseSliderSegmentedButton`)
- [x] Appliquer le thème sombre violet

---

### Étape 3.2 : Page de création ✅ FAIT

**Fichier** : `lib/share_cards/presentation/page/loan_creation_page.dart`

**Référence maquette** : `design/ai_design/v1/loan_creation_form.png`

**Modifications faites** :
- [x] Ajouter champ "Titre du prêt"
- [x] Ajouter DatePicker pour "Date de retour prévue" (via `BaseDatePicker`)
- [x] Ajouter champ "Notes"
- [x] Checkbox "Je prête" / "J'emprunte"
- [x] Champ contact (prêteur/emprunteur)
- [x] Bouton de validation "Créer le prêt"

**Composants UI créés pour cette page** :
- `lib/ui/molecules/molecule_date_picker.dart` - Sélecteur de date avec provider Riverpod

---

### Étape 3.3 : Page de détail ⚠️ À COMPLÉTER

**Fichier** : `lib/share_cards/presentation/page/share_cards_details_page.dart`

**Référence maquette** : `design/ai_design/v1/loan_detail_page.png`

**État actuel** :
- [x] Afficher lender et applicant
- [x] Liste des cartes avec image et détails
- [x] Suppression de carte par swipe (Dismissible)
- [x] Long press pour voir le détail d'une carte

**Modifications à faire** :
- [ ] Afficher le titre du prêt (`currentShareCards.title`)
- [ ] Afficher le badge de statut (En cours / Rendu / En retard) - Utiliser `currentShareCards.status`
- [ ] Afficher la durée du prêt - Utiliser `BaseLoanSubtitle` ou calcul similaire
- [ ] Ajouter bouton "Marquer comme rendu" - Appeler `markAsReturned(id)`
- [ ] Ajouter bouton "Prolonger" - Appeler `extendLoan(id, newDate)` avec `BaseDatePicker`
- [ ] Section notes - Afficher `currentShareCards.notes`
- [ ] Section historique (optionnel)

**Services disponibles dans le controller** :
- `markAsReturned(String id)` - Marquer un prêt comme rendu
- `extendLoan(String id, DateTime newReturnDate)` - Prolonger un prêt

---

## Phase 4 : Gestion des Contacts (Optionnel v1)

> Cette phase peut être reportée. Pour l'instant, `lender` et `applicant` sont des strings.

### Étape 4.1 : Créer le modèle Contact

**Fichier** : `lib/share_cards/domain/contact_model.dart`

```dart
class Contact {
  final String? id;
  final String name;
  final String? email;
  final String? phone;
  
  Contact({this.id, required this.name, this.email, this.phone});
  
  // fromJson / toJson
}
```

### Étape 4.2 : Repository et Services pour Contact

**Fichiers** :
- `lib/share_cards/data/contact_repository.dart`
- `lib/share_cards/data/contact_local_repository.dart`
- `lib/share_cards/application/contact_services.dart`

### Étape 4.3 : Page des contacts

**Fichier** : `lib/share_cards/presentation/page/contacts_page.dart`

**Référence maquette** : `design/ai_design/v1/contacts_page.png`

---

## Phase 5 : Intégration Wishlist

### Étape 5.1 : Créer un provider de croisement

**Fichier** : `lib/wishlist/presentation/controller/wishlist_loan_provider.dart`

Ce provider croise les données wishlist et share_cards pour savoir si une carte de la wishlist est actuellement empruntée.

```dart
final wishlistWithLoanStatusProvider = Provider<List<WishlistCardWithStatus>>((ref) {
  final wishlists = ref.watch(wishlistControllerProvider);
  final shareCards = ref.watch(shareCardsControllerProvider);
  
  // Logique de croisement...
});
```

### Étape 5.2 : Modifier la page Wishlist

**Référence maquette** : `design/ai_design/v1/wishlist_with_loans.png`

**Modifications** :
- Afficher badge "Empruntée" sur les cartes qui sont dans un prêt actif où `applicant == "Me"`
- Afficher "Empruntée à [lender]" et la durée

---

## Phase 6 : Thème et Design ✅ TERMINÉE

### Étape 6.1 : Créer un thème sombre violet ✅ FAIT

**Fichier** : `lib/utils/app_color.dart`

Palette complète définie :
- **Fonds** : `background`, `surface`, `surfaceVariant`
- **Accents** : `primary` (violet), `primaryLight`
- **Statuts** : `success` (vert), `warning` (orange), `error` (rouge)
- **Textes** : `textPrimary`, `textSecondary`, `textDisabled`

**Fichier** : `lib/main.dart`

Thème appliqué via `ColorScheme.fromSeed()` avec les couleurs de `AppColors`.

---

## Checklist de développement

### Phase 1 - Corrections urgentes ✅
- [x] Déplacer `share_cards_model.dart` dans `lib/share_cards/domain/`
- [x] Ajouter les champs manquants au modèle (`title`, `expectedReturnDate`, `status`, etc.)
- [x] Créer l'enum `ShareCardsStatus`
- [x] Mettre à jour `fromJson()` et `toJson()`

### Phase 2 - Mise à jour couches existantes ✅
- [x] Mettre à jour le repository pour les nouveaux champs
- [x] Ajouter les méthodes services (`markAsReturned`, `extendLoan`, filtres)
- [x] Mettre à jour le controller

### Phase 3 - UI ⚠️ En cours
- [x] Mettre à jour `home_share_cards.dart` (stats, tabs)
- [x] Mettre à jour `loan_creation_page.dart` (DatePicker, titre, notes, validation) ✅
- [x] Créer `molecule_date_picker.dart` (sélecteur de date)
- [x] Créer `molecule_loan_subtitle.dart` (sous-titre avec infos prêt)
- [x] Créer `molecule_shadow_image.dart` (image avec ombre colorée)
- [x] Créer `organism_loan_card.dart` (carte de prêt stylisée)
- [x] Créer `template_loan_list.dart` (liste avec filtres lent/borrow)
- [ ] Mettre à jour `share_cards_details_page.dart` (titre, statut, actions, notes)

### Phase 4 - Contacts (optionnel)
- [ ] Créer `contact_model.dart`
- [ ] Créer repository et services
- [ ] Créer `contacts_page.dart`

### Phase 5 - Intégration Wishlist
- [ ] Créer le provider de croisement
- [ ] Modifier la page wishlist

### Phase 6 - Design ✅
- [x] Appliquer le thème sombre violet (`app_color.dart`)
- [x] Intégrer dans `main.dart`

---

## Ordre de développement recommandé

1. ~~**Phase 1** : Corrections modèle~~ ✅ TERMINÉ
2. ~~**Phase 2** : Services et controller~~ ✅ TERMINÉ
3. **Phase 3** : UI pages ⚠️ EN COURS
   - ~~Page création~~ ✅ TERMINÉ
   - **Prochaine tâche** : Compléter `share_cards_details_page.dart`
4. **Phase 5** : Intégration wishlist - À FAIRE
5. **Phase 4** : Contacts (optionnel) - À FAIRE
6. ~~**Phase 6** : Thème~~ ✅ TERMINÉ

---

## Fichiers de référence (maquettes)

Toutes les maquettes sont dans `design/ai_design/v1/` :

| Fichier | Description |
|---------|-------------|
| `loan_list_ui_design.png` | Page d'accueil des prêts |
| `loan_creation_form.png` | Formulaire de création |
| `loan_detail_page.png` | Page de détail |
| `contacts_page.png` | Gestion des contacts |
| `wishlist_with_loans.png` | Wishlist avec statut emprunté |
| `scryfall_search_page.png` | Recherche Scryfall |
| `scryfall_card_detail.png` | Détail carte Scryfall |

---

## Conseils de reprise

### Prochaines étapes recommandées

1. **Compléter `share_cards_details_page.dart`** : 
   - Afficher le titre du prêt
   - Ajouter le badge de statut (En cours / Rendu / En retard)
   - Ajouter bouton "Marquer comme rendu" 
   - Ajouter bouton "Prolonger"
   - Afficher la section notes
   - Afficher la durée du prêt
2. **Phase 5 - Intégration Wishlist** : Créer le provider de croisement et modifier la page wishlist

### Composants UI disponibles pour réutilisation

| Composant | Fichier | Utilisation |
|-----------|---------|-------------|
| `BaseDatePicker` | `molecule_date_picker.dart` | Sélecteur de date avec provider |
| `BaseLoanSubtitle` | `molecule_loan_subtitle.dart` | Affiche nb cartes, contact, durée, date retour |
| `BaseShadowImage` | `molecule_shadow_image.dart` | Image avec ombre colorée selon statut |
| `BaseLoanCard` | `organism_loan_card.dart` | Carte complète avec image, titre, sous-titre |
| `LoanList` | `template_loan_list.dart` | Liste filtrée (all/lent/borrow) |

### Bonnes pratiques

- **Teste après chaque modification** - Lance l'app pour vérifier
- **Utilise le code existant** comme référence (wishlist, share_cards actuel)
- **Commit après chaque phase** avec un message clair
- **Ne change pas tout d'un coup** - Procède par petites étapes
- **Réutilise les composants UI** déjà créés (voir tableau ci-dessus)

Bon courage pour la suite !
