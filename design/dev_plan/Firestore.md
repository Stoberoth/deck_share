# Structure Firestore avec ID Utilisateur

## Vue d'ensemble

Ce document explique comment structurer Firestore pour organiser les données par utilisateur, où chaque utilisateur a ses propres collections de données (ShareCards, Wishlist, etc.).

## Approche recommandée : Sous-collections par utilisateur

### Structure de données

```
Firestore
└── users (collection)
    ├── {userId} (document)
    │   └── shareCards (subcollection)
    │       ├── {shareCardId1} (document)
    │       │   ├── id: "shareCard1"
    │       │   ├── title: "..."
    │       │   ├── lender: "..."
    │       │   └── ...
    │       └── {shareCardId2} (document)
    │           └── ...
    └── {userId2} (document)
        └── shareCards (subcollection)
            └── ...
```

### Chemin complet

```
users/{userId}/shareCards/{shareCardId}
```

- `users` : Collection principale
- `{userId}` : ID de l'utilisateur connecté (ex: "abc123")
- `shareCards` : Sous-collection
- `{shareCardId}` : ID du document ShareCards

## Implémentation dans BaseFirebaseRepository

### 1. Obtenir l'utilisateur connecté

```dart
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;
String userId = user!.uid;
```

### 2. Méthode getAll()

```dart
Future<List<T>> getAll() async {
  // 1. Obtenir l'utilisateur connecté
  User? user = FirebaseAuth.instance.currentUser;
  
  if (user == null) {
    throw Exception('User not authenticated');
  }
  
  // 2. Accéder à la sous-collection de l'utilisateur
  QuerySnapshot snapshot = await _firestore
    .collection('users')
    .doc(user.uid)                    // ID de l'utilisateur
    .collection(getCollectionName())  // Sous-collection (ex: 'shareCards')
    .get();
  
  // 3. Convertir en objets
  List<T> allReturnedObject = [];
  for(QueryDocumentSnapshot doc in snapshot.docs) {
    String docId = doc.id;
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    data['id'] = docId;
    allReturnedObject.add(fromJson(data));
  }
  return allReturnedObject;
}
```

### 3. Méthode getById()

```dart
Future<T> getById(String id) async {
  User? user = FirebaseAuth.instance.currentUser;
  
  if (user == null) {
    throw Exception('User not authenticated');
  }
  
  DocumentSnapshot doc = await _firestore
    .collection('users')
    .doc(user.uid)
    .collection(getCollectionName())
    .doc(id)
    .get();
  
  if (!doc.exists) {
    throw Exception('Document with id $id not found');
  }
  
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  data['id'] = doc.id;
  return fromJson(data);
}
```

### 4. Méthode save()

```dart
Future<void> save(T item) async {
  User? user = FirebaseAuth.instance.currentUser;
  
  if (user == null) {
    throw Exception('User not authenticated');
  }
  
  String? itemId = getId(item);
  
  if (itemId == null || itemId.isEmpty) {
    // Créer avec ID auto-généré
    await _firestore
      .collection('users')
      .doc(user.uid)
      .collection(getCollectionName())
      .add(toJson(item));
  } else {
    // Utiliser l'ID existant
    await _firestore
      .collection('users')
      .doc(user.uid)
      .collection(getCollectionName())
      .doc(itemId)
      .set(toJson(item));
  }
}
```

### 5. Méthode delete()

```dart
Future<void> delete(String id) async {
  User? user = FirebaseAuth.instance.currentUser;
  
  if (user == null) {
    throw Exception('User not authenticated');
  }
  
  await _firestore
    .collection('users')
    .doc(user.uid)
    .collection(getCollectionName())
    .doc(id)
    .delete();
}
```

## Règles de sécurité Firestore

### Règles pour la structure avec sous-collections

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Collection users
    match /users/{userId} {
      // Seul l'utilisateur peut lire/écrire ses propres données
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      // Sous-collection shareCards
      match /shareCards/{shareCardId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      
      // Sous-collection wishlist
      match /wishlist/{wishlistId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

## Avantages de cette approche

1. **Isolation des données** : Chaque utilisateur ne voit que ses propres données
2. **Sécurité** : Règles de sécurité simples et efficaces
3. **Performance** : Pas besoin de filtrer sur de grandes collections
4. **Scalabilité** : Structure qui s'adapte à un grand nombre d'utilisateurs
5. **Organisation** : Structure claire et logique

## Points importants

- ✅ Toujours vérifier que l'utilisateur est connecté avant d'accéder à Firestore
- ✅ Utiliser `user.uid` comme ID du document utilisateur
- ✅ Les sous-collections sont accessibles via `.collection()` après `.doc()`
- ✅ Chaque utilisateur a sa propre sous-collection isolée
- ✅ Ajouter toujours `doc.id` aux données avant de convertir en objet

## Exemple d'utilisation

```dart
// Dans ShareCardFirebaseRepository
class ShareCardFirebaseRepository extends BaseFirebaseRepository<ShareCards> {
  @override
  String getCollectionName() {
    return 'shareCards';  // Nom de la sous-collection
  }
  
  // Les méthodes getAll(), getById(), save(), delete() 
  // utilisent automatiquement la structure users/{userId}/shareCards
}
```

## Alternatives (non recommandées)

### Approche 2 : Collection unique avec champ userId

```
shareCards (collection)
  ├── {shareCardId1}
  │   ├── userId: "user123"
  │   └── ...
```

**Inconvénients** : Nécessite des filtres, moins performant, règles de sécurité plus complexes.

### Approche 3 : Tableau dans le document utilisateur

```
users/{userId}
  └── shareCards: [array]
```

**Inconvénients** : Limite de taille du document, moins flexible, pas de requêtes complexes.

## Conclusion

L'approche avec sous-collections (`users/{userId}/shareCards/{shareCardId}`) est la meilleure solution pour organiser les données par utilisateur dans Firestore. Elle offre une isolation complète, une sécurité renforcée et une excellente performance.
