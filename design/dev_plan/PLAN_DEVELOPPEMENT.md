# Plan de Développement - Fonctionnalité Prêts de Cartes

## Vue d'ensemble

Cette fonctionnalité permet de gérer les prêts de cartes Magic entre joueurs, avec intégration à la wishlist existante.

> **Note** : Une base existe déjà dans `lib/share_cards/`. Ce plan indique ce qui est fait et ce qu'il reste à faire.

---

## État actuel du projet

### Ce qui existe déjà ✅

| Élément | Fichier | Statut |
|---------|---------|--------|
| Modèle ShareCards | `.cursor/rules/share_cards_model.dart` | ⚠️ Mal placé |
| Repository interface | `lib/share_cards/data/share_card_repository.dart` | ✅ |
| Repository local | `lib/share_cards/data/share_card_local_repository.dart` | ✅ |
| Services | `lib/share_cards/application/share_cards_services.dart` | ✅ |
| Controller | `lib/share_cards/presentation/controller/share_cards_controller.dart` | ✅ |
| Page liste | `lib/share_cards/presentation/page/home_share_cards.dart` | ✅ |
| Page création | `lib/share_cards/presentation/page/share_cards_creation_page.dart` | ✅ |
| Page détail | `lib/share_cards/presentation/page/share_cards_details_page.dart` | ✅ |
| Widget liste | `lib/share_cards/presentation/widget/share_cards_list.dart` | ✅ |
| Scryfall picker | `lib/scryfall_searcher/` | ✅ Complet |
| Composants UI | `lib/ui/` | ✅ Atoms, molecules, etc. |
| Navigation | `lib/home/home.dart` | ✅ Bottom nav avec ShareCards |

### Ce qui manque ❌

| Élément | Description |
|---------|-------------|
| Placement modèle | Déplacer dans `lib/share_cards/domain/` |
| Champs modèle | `title`, `expectedReturnDate`, `returnedAt`, `status`, `notes` |
| Enum LoanStatus | `active`, `returned`, `overdue` |
| Gestion contacts | Modèle Contact + repository + services |
| UI moderne | Adapter aux maquettes (thème sombre violet) |
| Intégration Wishlist | Badge "Empruntée" sur les cartes |

---

## Phase 1 : Corrections urgentes

### Étape 1.1 : Déplacer le modèle ⚠️ PRIORITAIRE

**Action** : Déplacer `.cursor/rules/share_cards_model.dart` vers `lib/share_cards/domain/share_cards_model.dart`

```bash
# Créer le dossier domain s'il n'existe pas
mkdir lib/share_cards/domain

# Déplacer le fichier
move .cursor/rules/share_cards_model.dart lib/share_cards/domain/
```

---

### Étape 1.2 : Enrichir le modèle ShareCards

**Fichier** : `lib/share_cards/domain/share_cards_model.dart`

**Champs actuels** :
- `id` ✅
- `lender` ✅
- `applicant` ✅
- `lendingCards` ✅
- `lendingDate` ✅

**Champs à ajouter** :
```dart
// Ajouter ces champs
final String? title;                    // Nom du prêt (ex: "Deck Burn Modern")
final DateTime? expectedReturnDate;     // Date de retour prévue
final DateTime? returnedAt;             // Date de retour effective (null si en cours)
final ShareCardsStatus status;          // Statut du prêt
final String? notes;                    // Notes optionnelles
```

**Enum à créer** (dans le même fichier ou séparé) :
```dart
enum ShareCardsStatus {
  active,    // Prêt en cours
  returned,  // Prêt rendu
  overdue,   // Prêt en retard
}
```

**Getter utile à ajouter** :
```dart
bool get isOverdue {
  if (status == ShareCardsStatus.returned) return false;
  if (expectedReturnDate == null) return false;
  return DateTime.now().isAfter(expectedReturnDate!);
}
```

---

## Phase 2 : Mettre à jour les couches existantes

### Étape 2.1 : Mettre à jour le Repository

**Fichier** : `lib/share_cards/data/share_card_local_repository.dart`

**Vérifier** que la sérialisation gère les nouveaux champs.

---

### Étape 2.2 : Mettre à jour les Services

**Fichier** : `lib/share_cards/application/share_cards_services.dart`

**Ajouter ces méthodes** :
```dart
// Marquer un prêt comme rendu
Future<void> markAsReturned(String id) async {
  final shareCards = await getShareCardsById(id);
  // Mettre à jour returnedAt et status
  // Sauvegarder
}

// Prolonger un prêt
Future<void> extendLoan(String id, DateTime newReturnDate) async {
  // Mettre à jour expectedReturnDate
}

// Filtrer par statut
Future<List<ShareCards>> getByStatus(ShareCardsStatus status) async {
  final all = await getAllShareCards();
  return all.where((sc) => sc.status == status).toList();
}

// Obtenir les prêts que JE fais (lender = "Me")
Future<List<ShareCards>> getLentCards() async {
  final all = await getAllShareCards();
  return all.where((sc) => sc.lender == "Me").toList();
}

// Obtenir les prêts que JE reçois (applicant = "Me")
Future<List<ShareCards>> getBorrowedCards() async {
  final all = await getAllShareCards();
  return all.where((sc) => sc.applicant == "Me").toList();
}
```

---

### Étape 2.3 : Mettre à jour le Controller

**Fichier** : `lib/share_cards/presentation/controller/share_cards_controller.dart`

**Ajouter** :
- Provider pour les prêts filtrés (lent vs borrowed)
- Méthodes pour marquer rendu, prolonger, etc.

---

## Phase 3 : Mettre à jour les Pages UI

### Étape 3.1 : Page d'accueil des prêts

**Fichier** : `lib/share_cards/presentation/page/home_share_cards.dart`

**Référence maquette** : `design/ai_design/v1/loan_list_ui_design.png`

**Modifications à faire** :
- [ ] Ajouter les cartes statistiques en haut (prêts actifs / emprunts actifs)
- [ ] Ajouter TabBar : "Prêtés" / "Empruntés"
- [ ] Appliquer le thème sombre violet

---

### Étape 3.2 : Page de création

**Fichier** : `lib/share_cards/presentation/page/share_cards_creation_page.dart`

**Référence maquette** : `design/ai_design/v1/loan_creation_form.png`

**Modifications à faire** :
- [ ] Ajouter champ "Titre du prêt"
- [ ] Ajouter DatePicker pour "Date de retour prévue"
- [ ] Ajouter champ "Notes"
- [ ] Améliorer le design (thème sombre violet)

---

### Étape 3.3 : Page de détail

**Fichier** : `lib/share_cards/presentation/page/share_cards_details_page.dart`

**Référence maquette** : `design/ai_design/v1/loan_detail_page.png`

**Modifications à faire** :
- [ ] Afficher le badge de statut (En cours / Rendu / En retard)
- [ ] Afficher la durée du prêt
- [ ] Ajouter bouton "Marquer comme rendu"
- [ ] Ajouter bouton "Prolonger"
- [ ] Section notes
- [ ] Section historique (optionnel)

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

## Phase 6 : Thème et Design

### Étape 6.1 : Créer un thème sombre violet

**Fichier** : `lib/main.dart` ou `lib/ui/theme/app_theme.dart`

```dart
ThemeData darkPurpleTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.deepPurple,
    secondary: Colors.purpleAccent,
    surface: Color(0xFF1E1E2E),
    background: Color(0xFF121218),
  ),
  // ...
);
```

---

## Checklist de développement

### Phase 1 - Corrections urgentes
- [ ] Déplacer `share_cards_model.dart` dans `lib/share_cards/domain/`
- [ ] Ajouter les champs manquants au modèle (`title`, `expectedReturnDate`, `status`, etc.)
- [ ] Créer l'enum `ShareCardsStatus`
- [ ] Mettre à jour `fromJson()` et `toJson()`

### Phase 2 - Mise à jour couches existantes
- [ ] Mettre à jour le repository pour les nouveaux champs
- [ ] Ajouter les méthodes services (`markAsReturned`, `extendLoan`, filtres)
- [ ] Mettre à jour le controller

### Phase 3 - UI
- [ ] Mettre à jour `home_share_cards.dart` (stats, tabs)
- [ ] Mettre à jour `share_cards_creation_page.dart` (nouveaux champs)
- [ ] Mettre à jour `share_cards_details_page.dart` (statut, actions)

### Phase 4 - Contacts (optionnel)
- [ ] Créer `contact_model.dart`
- [ ] Créer repository et services
- [ ] Créer `contacts_page.dart`

### Phase 5 - Intégration Wishlist
- [ ] Créer le provider de croisement
- [ ] Modifier la page wishlist

### Phase 6 - Design
- [ ] Appliquer le thème sombre violet
- [ ] Tester sur les maquettes

---

## Ordre de développement recommandé

1. **Jour 1** : Phase 1 (corrections modèle) - ~1h
2. **Jour 1-2** : Phase 2 (services et controller) - ~1-2h
3. **Jour 2-3** : Phase 3 (UI pages) - ~2-3h
4. **Jour 4** : Phase 5 (intégration wishlist) - ~1-2h
5. **Plus tard** : Phase 4 (contacts) et Phase 6 (thème)

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

1. **Commence par la Phase 1** - C'est la fondation
2. **Teste après chaque modification** - Lance l'app pour vérifier
3. **Utilise le code existant** comme référence (wishlist, share_cards actuel)
4. **Commit après chaque phase** avec un message clair
5. **Ne change pas tout d'un coup** - Procède par petites étapes

Bon courage pour la reprise !
