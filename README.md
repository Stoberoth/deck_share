# 🎴 DeckShare

**DeckShare** est une application mobile moderne développée avec **Flutter**, dédiée à la création et à la gestion de decks de cartes personnalisés. Ce projet constitue une vitrine technique illustrant la mise en œuvre d'une architecture logicielle robuste, scalable et maintenable, conforme aux standards industriels du développement mobile.

## 🚀 Fonctionnalités

* **Conception de Decks :** Interface intuitive permettant aux utilisateurs de créer, structurer et organiser leurs propres paquets de cartes.
* **Système de Design Atomique :** Utilisation d'une bibliothèque de composants UI hautement modulaires pour une cohérence graphique totale et une maintenance facilitée.
* **Architecture Ready-to-Cloud :** Structure logicielle conçue pour intégrer nativement la synchronisation en temps réel et l'authentification.
* **Gestion d'État Réactive :** Mise à jour fluide de l'interface utilisateur en fonction des interactions métier complexes grâce à Riverpod.

## 🛠 Stack Technique & Architecture

Le choix technologique s'est porté sur des outils garantissant une séparation stricte des préoccupations et une testabilité maximale :

* **Framework :** Flutter & Dart
* **Gestion d'état :** **Riverpod** (approche réactive, découplée et hautement testable).
* **Architecture :** **DDD (Domain-Driven Design)** avec une organisation *Feature-first*.
* **Design Pattern UI :** **Atomic Design** (Atomes, Molécules, Organismes) pour une UI modulaire.
* **Persistance des données :** Intégration de **Firebase** (planifiée).

## 🏗 Structure du Projet (DDD - Feature First)

Le projet suit un découpage par fonctionnalités (*features*). Chaque fonctionnalité est segmentée en quatre couches distinctes, conformément aux principes du DDD :

```text
lib/
  └── [feature_name]/
    ├── domain/         # Couche métier : Entités, modèles et interfaces de repositories
    ├── data/           # Couche données : Implémentations des repositories et Data Sources
    ├── application/    # Couche applicative : Providers Riverpod et logique de pilotage
    └── presentation/   # Couche UI : Widgets organisés selon l'Atomic Design

```

## Installation et Lancement
Pour tester le projet en local, assurez-vous d'avoir le SDK Flutter installé sur votre machine.

### 1. Cloner le dépôt :

```bash
git clone https://github.com/Stoberoth/deck_share.git
```

### 2. Installer les dépendances :

```bash
flutter pub get
```

### 3. Lancer l'application : 

```bash
flutter run
```

## A propos de l'auteur

**Nicolas LENOIR** - Développeur Flutter/Logiciel Freelance (NicoDev) basé à Limoges.

- **Expertises :** Développement Mobile (**Flutter/Dart**), Logiciel (**C++/Qt**) et Technologies Immersives (**Unity/Unreal Engines**).
- **Parcours :** Titulaire d'un **Master ISICG**, ex-développeur chez **Golemlabs** (Canada) et actuel enseignant vacataire à l'Université de Limoges (IUT & Facultés des Sciences).
