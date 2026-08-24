# Sorélia — ALYA

Application mobile Android de **gestion des notes et d'orientation scolaire**
pour les élèves béninois du secondaire (6e à Terminale).

Sorélia calcule les moyennes selon le système béninois (barème /20,
coefficients par série MEMP / MESTFP), gère l'emploi du temps et les séances de
révision, et embarque une FAQ d'orientation.

**Contrainte structurante : l'application fonctionne intégralement hors ligne.**
Les données de l'élève vivent sur son téléphone (SQLite local) et n'en sortent
pas. Aucun serveur n'est requis en v1.

> Projet porté par l'association **ALYA** — *African League of Young digital
> Architects*, Natitingou, Bénin.

---

## Sommaire

- [Prérequis](#prérequis)
- [Installation](#installation)
- [Lancer l'application](#lancer-lapplication)
- [Vérifier son code avant de pousser](#vérifier-son-code-avant-de-pousser)
- [Structure du dépôt](#structure-du-dépôt)
- [Contribuer](#contribuer)
- [Décisions techniques (ADR)](#décisions-techniques-adr)
- [Confidentialité](#confidentialité)

---

## Prérequis

**Les versions ci-dessous ne sont pas indicatives : ce sont les versions du
projet.** Une version différente provoque des écarts de compilation difficiles
à diagnostiquer, et la CI rejettera la Pull Request. La raison détaillée est
dans [ADR-0002](docs/adr/0002-version-flutter-figee.md).

| Outil | Version exigée | Vérifier avec |
| --- | --- | --- |
| Flutter | **3.47.1** (canal `stable`) | `flutter --version` |
| Dart | **3.13.1** (installé avec Flutter) | `dart --version` |
| JDK | **17** | `java -version` |
| Git | 2.x | `git --version` |
| Android SDK | via Android Studio | `flutter doctor` |

### Installer la chaîne d'outils

1. **Flutter 3.47.1** — suivre https://docs.flutter.dev/get-started/install
   en choisissant le canal `stable`. Vérifier ensuite :
   ```bash
   flutter --version   # doit afficher : Flutter 3.47.1 • channel stable
   ```
   **Si la version affichée est différente**, le SDK Flutter est lui-même un
   dépôt Git : se placer dans son dossier d'installation et basculer sur le
   tag voulu.
   ```bash
   cd <chemin-vers-le-sdk-flutter>   # ex. C:\src\flutter ou ~/development/flutter
   git fetch --tags
   git checkout 3.47.1
   flutter --version                 # revérifier
   ```
   Revenir au canal courant plus tard : `flutter channel stable`.
2. **Android Studio** — fournit le SDK Android, les outils de ligne de commande
   et l'émulateur. À l'installation, accepter les composants proposés par
   défaut.
3. **JDK 17** — Android Studio en embarque un. Si `java -version` affiche autre
   chose que 17, installer Temurin 17 (https://adoptium.net).
4. **Contrôle final** — cette commande doit être verte partout pour la ligne
   Android :
   ```bash
   flutter doctor
   ```
   Accepter les licences Android si demandé :
   ```bash
   flutter doctor --android-licenses
   ```

### Un appareil pour tester

Au choix :
- **Un téléphone Android physique** (recommandé — la cible du projet est un
  téléphone d'entrée de gamme) : activer les *Options développeur* puis le
  *Débogage USB*, brancher en USB.
- **Un émulateur** créé depuis Android Studio (Device Manager → Create device).

L'appareil doit être en **Android 8.0 (API 26) ou plus** — c'est le minimum
supporté par l'application.

Vérifier qu'il est détecté :
```bash
flutter devices
```

---

## Installation

```bash
git clone https://github.com/ALYA/sorelia.git
cd sorelia
flutter pub get
```

`flutter pub get` télécharge les dépendances listées dans `pubspec.yaml`, aux
versions exactes verrouillées dans `pubspec.lock`. Ne jamais modifier
`pubspec.lock` à la main.

---

## Lancer l'application

```bash
flutter run
```

Pendant l'exécution, dans le terminal :

| Touche | Effet |
| --- | --- |
| `r` | *Hot reload* — applique les modifications sans perdre l'état |
| `R` | *Hot restart* — relance l'application, remet l'état à zéro |
| `q` | Quitter |

### Générer un APK de test

```bash
flutter build apk --release
```

L'APK est produit dans `build/app/outputs/flutter-apk/app-release.apk`.

> ⚠️ Cet APK est signé avec la **clé de débogage** (voir le `TODO` dans
> `android/app/build.gradle.kts`). Il sert à tester sur un vrai téléphone, pas
> à distribuer. La signature de production sera traitée avec US-004.

---

## Vérifier son code avant de pousser

Ces deux commandes doivent passer **avant** d'ouvrir une Pull Request. La CI
les rejouera de toute façon.

```bash
flutter analyze   # analyse statique : erreurs, avertissements, règles de style
flutter test      # tests automatisés
```

Formater le code (obligatoire, sinon `flutter analyze` proteste) :
```bash
dart format .
```

---

## Structure du dépôt

L'architecture suit la vue en couches du CCT : présentation, métier, données.

```
sorelia/
├── lib/
│   ├── main.dart              Point d'entrée de l'application
│   ├── app/                   Configuration globale : thème, navigation, routes
│   ├── core/                  Utilitaires transverses (constantes, extensions, erreurs)
│   ├── domain/                COUCHE MÉTIER — indépendante de Flutter et de la base
│   │   ├── entities/            Objets métier (Eleve, Note, Matiere, SeanceEtude…)
│   │   ├── repositories/        Interfaces d'accès aux données (contrats)
│   │   └── services/            Règles métier (calcul des moyennes pondérées…)
│   ├── data/                  COUCHE DONNÉES — implémente les contrats du domaine
│   │   ├── local/               Base SQLite (Drift) : tables, DAO, migrations
│   │   └── repositories/        Implémentations concrètes des repositories
│   ├── features/              COUCHE PRÉSENTATION — un dossier par fonctionnalité
│   └── l10n/                  Traductions (français en v1, i18n préparée)
├── assets/
│   ├── coefficients/          Table de référence des coefficients par série
│   └── faq/                   FAQ d'orientation embarquée, consultable hors ligne
├── android/                   Configuration Android native
├── test/                      Tests automatisés
└── docs/
    └── adr/                   Décisions techniques et leurs raisons
```

**Règle de dépendance :** `features/` et `data/` connaissent `domain/`.
`domain/` ne connaît ni l'un ni l'autre. C'est ce qui permet de tester le
calcul des moyennes — le cœur de crédibilité du produit — sans lancer
l'application ni la base de données.

---

## Contribuer

Tout est détaillé dans **[docs/CONVENTIONS.md](docs/CONVENTIONS.md)**. Le
résumé :

- **Jamais de push direct sur `main`.** La branche est protégée, GitHub le
  refusera.
- Une branche par sujet, créée depuis `main` à jour : `feat/saisie-notes`,
  `fix/calcul-coefficient`.
- Messages de commit au format *Conventional Commits* :
  `feat(notes): ajoute la saisie d'une note`.
- Une Pull Request par sujet, relue et approuvée par un autre développeur avant
  fusion.

Le cycle complet, commande par commande, est décrit dans
[docs/CONVENTIONS.md](docs/CONVENTIONS.md).

---

## Décisions techniques (ADR)

Un ADR (*Architecture Decision Record*) enregistre une décision structurante,
**ses raisons et ses conséquences**. On les lit avant de proposer de revenir sur
un choix.

| ADR | Sujet |
| --- | --- |
| [0001](docs/adr/0001-depot-public.md) | Dépôt GitHub public |
| [0002](docs/adr/0002-version-flutter-figee.md) | Version de la chaîne d'outils figée |
| [0003](docs/adr/0003-application-id.md) | `applicationId` = `bj.alya.sorelia` |

---

## Confidentialité

Sorélia s'adresse à un public **entièrement mineur**. Deux conséquences
concrètes pour qui contribue :

- **Aucune donnée réelle d'élève ne doit entrer dans ce dépôt.** Les jeux de
  données de démonstration sont fictifs. Le dépôt est public
  ([ADR-0001](docs/adr/0001-depot-public.md)) : ce qui y est poussé est
  définitivement visible de tous.
- **Aucun secret dans le dépôt** : clés de signature (`*.jks`,
  `key.properties`), jetons d'API. Ces motifs sont couverts par le
  `.gitignore`, et le *Push protection* de GitHub bloque les fuites détectées.
  En cas de doute, demander **avant** de pousser.

---

## Bloqué ?

Si une étape de ce README ne suffit pas à te débloquer, c'est une lacune du
README, pas la tienne : signale-la, la ligne manquante sera ajoutée.
