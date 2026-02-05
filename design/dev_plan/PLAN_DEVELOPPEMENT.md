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
| Page détail legacy | `lib/share_cards/presentation/page/share_cards_details_page.dart` | ⚠️ Obsolète (à supprimer) |
| Page détail (nouvelle) | `lib/share_cards/presentation/page/loan_details_page.dart` | ✅ Complète |
| Widget liste | `lib/share_cards/presentation/widget/share_cards_list.dart` | ✅ |
| Scryfall picker | `lib/scryfall_searcher/` | ✅ Complet (+ cartes multi-faces) |
| Navigation | `lib/home/home.dart` | ✅ Bottom nav avec ShareCards |
| Thème couleurs | `lib/utils/app_color.dart` | ✅ Palette sombre violet |

### Composants UI - Refactoring Atomic Design ✅

> **Note** : La convention de nommage a changé de `base_` vers `atom_`, `molecule_`, `organism_`, `template_` pour plus de clarté.

#### Atoms (`lib/ui/atom/`)

| Composant | Fichier | Statut |
|-----------|---------|--------|
| Button | `atom_button.dart` | ✅ |
| Card | `atom_card.dart` | ✅ |
| FloatingActionButton | `atom_floating_action_button.dart` | ✅ |
| IconButton | `atom_icon_button.dart` | ✅ |
| Image | `atom_image.dart` | ✅ Nouveau |
| ListTile | `atom_list_tile.dart` | ✅ |
| TextField | `atom_text_field.dart` | ✅ |
| Text | `atom_text.dart` | ✅ Nouveau |

#### Molecules (`lib/ui/molecules/`)

| Composant | Fichier | Statut |
|-----------|---------|--------|
| CardSum | `molecule_card_sum.dart` | ✅ Nouveau |
| CardTile | `molecule_card_tile.dart` | ✅ Nouveau |
| DatePicker | `molecule_date_picker.dart` | ✅ |
| Dismissible | `molecule_dismissible.dart` | ✅ Déplacé depuis atom |
| LoanSubtitle | `molecule_loan_subtitle.dart` | ✅ |
| LoanSum | `molecule_loan_sum.dart` | ✅ Nouveau |
| Notes | `molecule_notes.dart` | ✅ Nouveau |
| SearchBar | `molecule_search_bar.dart` | ✅ |
| ShadowImage | `molecule_shadow_image.dart` | ✅ |
| SliderSegmentedButton | `molecule_slider_segmented_button.dart` | ✅ |

#### Organisms (`lib/ui/organisms/`)

| Composant | Fichier | Statut |
|-----------|---------|--------|
| AppBar | `organism_app_bar.dart` | ✅ |
| CardListView | `organism_card_list_view.dart` | ✅ Déplacé depuis molecules |
| LoanCard | `organism_loan_card.dart` | ✅ |
| LoanCardsList | `organism_loan_cards_list.dart` | ✅ Nouveau |
| CardSumList | `organism_card_sum_list.dart` | ✅ Renommé (typo corrigée) |

#### Templates (`lib/ui/templates/`)

| Composant | Fichier | Statut |
|-----------|---------|--------|
| Base | `template_base.dart` | ✅ |
| Home | `template_home.dart` | ✅ |
| LoanList | `template_loan_list.dart` | ✅ |

### Ce qui reste à faire ❌

| Élément | Description | Priorité |
|---------|-------------|----------|
| Intégration Firebase | Migrer le stockage local vers Firebase Firestore | 🔴 Haute |
| Gestion contacts | Modèle Contact + repository + services | 🔴 Haute |
| Badge statut "En retard" | Ajouter l'affichage "En retard" quand `isOverdue == true` | 🟡 Moyenne |
| Intégration Wishlist | Badge "Empruntée" sur les cartes | 🟢 Basse (reportée) |

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

## Phase 3 : Mettre à jour les Pages UI ✅ TERMINÉE

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

### Étape 3.3 : Page de détail ✅ TERMINÉE

> **Note** : Deux fichiers existent pour cette fonctionnalité :
> - `share_cards_details_page.dart` - Version legacy (à supprimer éventuellement)
> - `loan_details_page.dart` - Nouvelle version avec les composants Atomic Design ✅

**Fichier principal** : `lib/share_cards/presentation/page/loan_details_page.dart`

**Référence maquette** : `design/ai_design/v1/loan_detail_page.png`

**Composants utilisés** :
- `BaseLoanSum` (`molecule_loan_sum.dart`) - Résumé complet du prêt ✅
- `BaseCardSumList` (`organism_card_sum_list.dart`) - Liste des cartes prêtées ✅
- `BaseCardSum` (`molecule_card_sum.dart`) - Élément carte individuel ✅

**État actuel de `loan_details_page.dart`** :
- [x] Structure de base avec `BaseTemplate`
- [x] AppBar avec titre "Details du prêt"
- [x] Intégration de `BaseLoanSum` avec :
  - [x] Afficher le titre du prêt
  - [x] Badge de statut avec couleur (vert/orange selon `isOverdue`)
  - [x] Afficher qui emprunte/prête
  - [x] Afficher la date de l'emprunt
  - [x] Afficher la date de retour prévue
  - [x] Afficher depuis combien de jours l'emprunt court
- [x] Intégrer `BaseCardSumList` pour la liste des cartes
- [x] BottomAppBar avec bordure en haut

**Boutons d'action** :
- [x] Bouton "Marquer comme rendu" - Appelle `markAsReturned(id)` + navigation retour ✅
- [x] Bouton "Prolonger" - Appelle `extendLoan(id, newDate)` avec `showDatePicker` ✅

**État actuel de `molecule_loan_sum.dart`** :
- [x] Badge statut dynamique - Affiche "En cours" ou "Returned" selon `loanToSum.status` ✅
- [x] Couleur badge selon `isOverdue` (vert/orange) ✅

**Améliorations restantes (mineures)** :
- [x] Bug : Calcul "Depuis X jours" négatif ✅ CORRIGÉ
- [x] Section notes - `BaseNotes` (`molecule_notes.dart`) ✅ FAIT
- [ ] Badge "En retard" - Afficher un texte différent quand `isOverdue == true`

**Services disponibles dans le controller** :
- `markAsReturned(String id)` - Marquer un prêt comme rendu ✅ Utilisé
- `extendLoan(String id, DateTime newReturnDate)` - Prolonger un prêt (disponible)

---

## Phase 4 : Intégration Firebase 🔴 PRIORITAIRE

> Objectif : Migrer le stockage local (JSON) vers Firebase Firestore pour une base de données robuste et synchronisée.

### Étape 4.1 : Configuration Firebase

**Actions** :
- [ ] Créer un projet Firebase Console
- [ ] Ajouter l'app Flutter au projet Firebase
- [ ] Configurer `firebase_options.dart` via FlutterFire CLI
- [ ] Ajouter les dépendances dans `pubspec.yaml`

**Dépendances à ajouter** :
```yaml
dependencies:
  firebase_core: ^latest
  cloud_firestore: ^latest
  firebase_auth: ^latest  # optionnel pour auth future
```

### Étape 4.2 : Créer le Repository Firebase pour ShareCards

**Fichier** : `lib/share_cards/data/share_card_firebase_repository.dart`

```dart
class ShareCardFirebaseRepository implements ShareCardRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Future<List<ShareCards>> getAllShareCards() async {
    final snapshot = await _firestore.collection('shareCards').get();
    return snapshot.docs.map((doc) => ShareCards.fromJson(doc.data())).toList();
  }
  
  // Implémenter toutes les méthodes de l'interface...
}
```

### Étape 4.3 : Adapter le Provider pour switcher Local/Firebase

**Fichier** : `lib/core/config/repository_config.dart`

```dart
enum RepositoryType { local, firebase }

final repositoryTypeProvider = StateProvider<RepositoryType>((ref) => RepositoryType.firebase);

final shareCardRepositoryProvider = Provider<ShareCardRepository>((ref) {
  final type = ref.watch(repositoryTypeProvider);
  return type == RepositoryType.firebase
      ? ShareCardFirebaseRepository()
      : ShareCardLocalRepository();
});
```

### Étape 4.4 : Migrer les données existantes (optionnel)

**Script de migration** : Transférer les données du JSON local vers Firestore.

---

## Phase 5 : Gestion des Contacts 🔴 PRIORITAIRE

> Remplace les strings `lender` et `applicant` par de vrais objets Contact.

### Étape 5.1 : Créer le modèle Contact

**Fichier** : `lib/contacts/domain/contact_model.dart`

```dart
class Contact {
  final String? id;
  final String name;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  
  Contact({this.id, required this.name, this.email, this.phone, this.avatarUrl});
  
  Map<String, dynamic> toJson() => { ... };
  factory Contact.fromJson(Map<String, dynamic> json) => Contact(...);
}
```

### Étape 5.2 : Repository et Services pour Contact

**Fichiers** :
- `lib/contacts/data/contact_repository.dart` - Interface
- `lib/contacts/data/contact_firebase_repository.dart` - Implémentation Firebase
- `lib/contacts/application/contact_services.dart` - Logique métier

**Méthodes à implémenter** :
- `getAllContacts()`
- `getContactById(String id)`
- `saveContact(Contact contact)`
- `deleteContact(String id)`
- `searchContacts(String query)`

### Étape 5.3 : Controller Contact

**Fichier** : `lib/contacts/presentation/controller/contact_controller.dart`

### Étape 5.4 : Pages UI Contacts

**Fichiers** :
- `lib/contacts/presentation/page/contacts_page.dart` - Liste des contacts
- `lib/contacts/presentation/page/contact_creation_page.dart` - Création/édition

**Référence maquette** : `design/ai_design/v1/contacts_page.png`

### Étape 5.5 : Mettre à jour ShareCards pour utiliser Contact

**Modifications** :
- Changer `lender: String` → `lender: Contact`
- Changer `applicant: String` → `applicant: Contact`
- Mettre à jour `toJson()` et `fromJson()`
- Adapter les pages de création et détail

---

## Phase 6 : Intégration Wishlist 🟢 REPORTÉE

> Cette phase est reportée pour se concentrer sur une base saine avec Firebase et Contacts.

### Étape 6.1 : Créer un provider de croisement

**Fichier** : `lib/wishlist/presentation/controller/wishlist_loan_provider.dart`

Ce provider croise les données wishlist et share_cards pour savoir si une carte de la wishlist est actuellement empruntée.

```dart
final wishlistWithLoanStatusProvider = Provider<List<WishlistCardWithStatus>>((ref) {
  final wishlists = ref.watch(wishlistControllerProvider);
  final shareCards = ref.watch(shareCardsControllerProvider);
  
  // Logique de croisement...
});
```

### Étape 6.2 : Modifier la page Wishlist

**Référence maquette** : `design/ai_design/v1/wishlist_with_loans.png`

**Modifications** :
- Afficher badge "Empruntée" sur les cartes qui sont dans un prêt actif où `applicant == "Me"`
- Afficher "Empruntée à [lender]" et la durée

---

## Phase 7 : Thème et Design ✅ TERMINÉE

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

### Phase 3 - UI ✅ Terminée
- [x] Mettre à jour `home_share_cards.dart` (stats, tabs)
- [x] Mettre à jour `loan_creation_page.dart` (DatePicker, titre, notes, validation)
- [x] Créer `molecule_date_picker.dart` (sélecteur de date)
- [x] Créer `molecule_loan_subtitle.dart` (sous-titre avec infos prêt)
- [x] Créer `molecule_shadow_image.dart` (image avec ombre colorée)
- [x] Créer `organism_loan_card.dart` (carte de prêt stylisée)
- [x] Créer `template_loan_list.dart` (liste avec filtres lent/borrow)
- [x] Créer `molecule_card_sum.dart` (élément carte pour résumé)
- [x] Créer `molecule_loan_sum.dart` (résumé du prêt avec toutes les infos)
- [x] Créer `organism_card_sum_list.dart` (liste des cartes prêtées)
- [x] Créer `loan_details_page.dart` (page complète avec infos, cartes, actions)
- [x] Bouton "Marquer comme rendu" fonctionnel
- [x] BottomAppBar avec bordure stylisée
- [x] Bouton "Prolonger" fonctionnel (avec showDatePicker)
- [x] Badge statut dynamique ("En cours" / "Returned")
- [x] Corriger bug calcul "Depuis X jours"
- [x] Créer `molecule_notes.dart` (section notes sur page détail)

### Phase 4 - Intégration Firebase 🔴 PRIORITAIRE
- [ ] Créer projet Firebase Console
- [ ] Configurer FlutterFire CLI (`firebase_options.dart`)
- [ ] Ajouter dépendances (`firebase_core`, `cloud_firestore`)
- [ ] Créer `share_card_firebase_repository.dart`
- [ ] Adapter les providers pour switcher local/Firebase
- [ ] Tester la synchronisation

### Phase 5 - Gestion Contacts 🔴 PRIORITAIRE
- [ ] Créer `contact_model.dart`
- [ ] Créer `contact_firebase_repository.dart`
- [ ] Créer `contact_services.dart`
- [ ] Créer `contact_controller.dart`
- [ ] Créer `contacts_page.dart`
- [ ] Créer `contact_creation_page.dart`
- [ ] Mettre à jour ShareCards pour utiliser Contact au lieu de String

### Phase 6 - Intégration Wishlist 🟢 REPORTÉE
- [ ] Créer le provider de croisement
- [ ] Modifier la page wishlist

### Phase 7 - Design ✅
- [x] Appliquer le thème sombre violet (`app_color.dart`)
- [x] Intégrer dans `main.dart`

### Phase 8 - Refactoring Atomic Design ✅ TERMINÉ
- [x] Renommer les composants avec préfixes explicites (`atom_`, `molecule_`, `organism_`, `template_`)
- [x] Créer `atom_image.dart` (image avec gestion chargement/erreur)
- [x] Créer `atom_text.dart` (texte stylisé réutilisable)
- [x] Déplacer `dismissible` de atom vers molecules
- [x] Déplacer `card_list_view` de molecules vers organisms
- [x] Créer `molecule_slider_segmented_button.dart` (switch Prêtés/Empruntés)
- [x] Créer `organism_loan_cards_list.dart` (liste de prêts)

---

## Ordre de développement recommandé

1. ~~**Phase 1** : Corrections modèle~~ ✅ TERMINÉ
2. ~~**Phase 2** : Services et controller~~ ✅ TERMINÉ
3. ~~**Phase 3** : UI pages~~ ✅ TERMINÉ
4. **Phase 4** : Intégration Firebase 🔴 **PROCHAINE ÉTAPE**
   - Configuration projet Firebase
   - Repository Firebase pour ShareCards
   - Switch local/Firebase
5. **Phase 5** : Gestion Contacts 🔴 **PRIORITAIRE**
   - Modèle Contact
   - Repository + Services + Controller
   - Pages UI (liste + création)
   - Lier Contact à ShareCards
6. **Phase 6** : Intégration Wishlist 🟢 REPORTÉE
7. ~~**Phase 7** : Thème~~ ✅ TERMINÉ
8. ~~**Phase 8** : Refactoring Atomic Design~~ ✅ TERMINÉ
9. ~~**Bug cartes multi-faces**~~ ✅ CORRIGÉ

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

1. **Phase 4 - Intégration Firebase** 🔴 :
   - Créer un projet sur [Firebase Console](https://console.firebase.google.com/)
   - Installer FlutterFire CLI : `dart pub global activate flutterfire_cli`
   - Configurer : `flutterfire configure`
   - Créer `share_card_firebase_repository.dart` implémentant `ShareCardRepository`

2. **Phase 5 - Gestion Contacts** 🔴 :
   - Créer la structure `lib/contacts/` (domain, data, application, presentation)
   - Implémenter le modèle Contact avec Firebase
   - Créer les pages UI pour gérer les contacts
   - Modifier ShareCards pour référencer des Contact au lieu de strings

3. **(Nettoyage) Supprimer `share_cards_details_page.dart`** : L'ancienne page legacy peut être supprimée

4. **(Optionnel) Améliorer badge statut** : Afficher "En retard" quand `isOverdue == true`

### Composants UI disponibles pour réutilisation

> **Note** : La convention de nommage est maintenant `atom_`, `molecule_`, `organism_`, `template_`

| Composant | Fichier | Utilisation |
|-----------|---------|-------------|
| `BaseText` | `atom_text.dart` | Texte stylisé avec différents styles |
| `BaseImage` | `atom_image.dart` | Image avec gestion chargement/erreur |
| `BaseButton` | `atom_button.dart` | Bouton stylisé réutilisable |
| `BaseDatePicker` | `molecule_date_picker.dart` | Sélecteur de date avec provider |
| `BaseLoanSubtitle` | `molecule_loan_subtitle.dart` | Affiche nb cartes, contact, durée, date retour |
| `BaseLoanSum` | `molecule_loan_sum.dart` | Résumé complet du prêt (titre, statut, dates, personne) |
| `BaseNotes` | `molecule_notes.dart` | Affichage des notes d'un prêt |
| `BaseCardSum` | `molecule_card_sum.dart` | Élément carte individuel (image, nom, extension) |
| `BaseShadowImage` | `molecule_shadow_image.dart` | Image avec ombre colorée selon statut |
| `BaseLoanCard` | `organism_loan_card.dart` | Carte complète avec image, titre, sous-titre |
| `BaseCardSumList` | `organism_card_sum_list.dart` | Liste des cartes prêtées |
| `LoanList` | `template_loan_list.dart` | Liste filtrée (all/lent/borrow) avec provider `selectLoan` |

### Providers utiles

| Provider | Fichier | Utilisation |
|----------|---------|-------------|
| `selectLoan` | `template_loan_list.dart` | Contient le prêt sélectionné pour la page détail |
| `shareCardsControllerProvider` | `share_cards_controller.dart` | Accès aux actions sur les prêts |

### Bonnes pratiques

- **Teste après chaque modification** - Lance l'app pour vérifier
- **Utilise le code existant** comme référence (wishlist, share_cards actuel)
- **Commit après chaque phase** avec un message clair (ex: `feat: Complete loan details page`)
- **Ne change pas tout d'un coup** - Procède par petites étapes
- **Réutilise les composants UI** déjà créés (voir tableau ci-dessus)
- **Respecte la convention de nommage** Atomic Design (`atom_`, `molecule_`, `organism_`, `template_`)

Bon courage pour la suite !
