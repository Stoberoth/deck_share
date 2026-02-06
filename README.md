🎴 DeckShare
DeckShare est une application mobile développée avec Flutter, conçue pour la création et la gestion de decks de cartes personnalisés. Ce projet est une vitrine technique démontrant la mise en œuvre d'une architecture robuste et scalable adaptée aux projets d'envergure.

🛠 Stack Technique & Patterns
Framework : Flutter & Dart

Gestion d'état : Riverpod (pour une gestion d'état réactive, testable et découplée).

Architecture : DDD (Domain-Driven Design) organisée par fonctionnalités (Feature-first).

Design Pattern UI : Atomic Design (Atoms, Molecules, Organisms) pour une bibliothèque de composants réutilisables et cohérents.

Persistance (Back-end) : Intégration de Firebase (en cours de planification).

🏗 Structure du Projet (DDD - Feature First)
Le projet suit une séparation stricte des préoccupations pour garantir la testabilité et la maintenance, inspirée des meilleures pratiques de l'industrie :

Plaintext

lib/
  └── [feature_name]/
      ├── domain/         # Modèles (Entities) et logique métier pure
      ├── data/           # Repositories et Data Sources (API/Firebase)
      ├── application/    # Providers Riverpod et services applicatifs
      └── presentation/   # UI suivant le pattern Atomic Design
🚀 Fonctionnalités
Conception de Decks : Interface intuitive pour structurer ses propres paquets de cartes.

Système de Design Atomique : Composants UI hautement modulaires facilitant l'évolution graphique.

Architecture Scalable : Prêt pour l'intégration de services cloud et la synchronisation en temps réel via Firebase.

⚙️ Installation et Lancement
Cloner le dépôt :

Bash

git clone https://github.com/Stoberoth/deck_share.git
Installer les dépendances :

Bash

flutter pub get
Lancer l'application :

Bash

flutter run
👨‍💻 À propos de l'auteur
Nicolas Lenoir – Développeur Freelance à Limoges.

Expertises : Mobile (Flutter), Logiciel (C++/Qt) et Game Design (Unity/Unreal).

Profil : Titulaire d'un Master ISICG, ex-développeur chez Golemlabs et intervenant à l'IUT de Limoges.
