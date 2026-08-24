# ADR-0002 — Version de la chaîne d'outils figée

## Contexte

Trois à quatre développeurs travaillent simultanément sur l'application
Flutter. Sans version de référence commune, chacun compile avec la chaîne
d'outils installée sur sa machine. Ce n'est pas un risque théorique : trois
mécanismes le rendent certain sur ce projet précis.

**1. La configuration Android dépend du SDK Flutter installé.**
Dans `android/app/build.gradle.kts` :

```kotlin
compileSdk = flutter.compileSdkVersion
ndkVersion = flutter.ndkVersion
```

Ces valeurs ne sont pas écrites dans le dépôt : elles sont lues dans le SDK
Flutter de la machine qui compile. Deux versions de Flutter produisent deux
APK différents à partir du même code. Le CCT impose un APK léger et
compatible Android 8+ : cette contrainte n'est vérifiable que si tout le monde
mesure le même artefact.

**2. Le code utilise déjà de la syntaxe Dart récente.**
`lib/main.dart` emploie la notation *dot-shorthand* (`.fromSeed(...)`,
`.center`), introduite récemment dans Dart. Sur un Dart antérieur, le fichier
ne compile pas — l'erreur ressemble à un bug du code, pas à un écart de
version.

**3. Drift génère du code.**
Le socle local-first (US-002) repose sur Drift, qui produit des fichiers
`.g.dart` via `build_runner`. Deux versions de Dart génèrent des sorties
différentes. Chaque PR contiendrait alors des centaines de lignes de diff
générées, sans rapport avec le travail relu : la relecture devient
inexploitable, et les conflits de merge permanents.

## Décision

La version de référence du projet est :

| Outil | Version |
| --- | --- |
| Flutter | **3.47.1** (canal `stable`) |
| Dart | **3.13.1** (fourni avec Flutter) |
| JDK | **17** |
| Android Gradle Plugin | **9.1.0** (figé dans `android/settings.gradle.kts`) |
| Kotlin | **2.4.0** (figé dans `android/settings.gradle.kts`) |

Elle est figée à **deux endroits** :

1. **`README.md`** — pour l'humain qui installe le projet.
2. **Le workflow de CI** (`.github/workflows/`) — pour la machine. La CI
   installe la version exacte ; toute PR qui ne compile pas avec elle est
   rejetée avant relecture.

`pubspec.lock` est **versionné** (il ne figure pas dans `.gitignore`) : les
versions exactes des dépendances sont donc identiques pour tous. C'est le
comportement attendu pour une application — à l'inverse d'une bibliothèque.

Une montée de version est une **décision d'équipe** : elle se fait par une PR
dédiée qui met à jour le README, la CI et cet ADR, jamais par la mise à jour
individuelle d'un poste.

## Conséquences

- Un développeur avec une version différente le découvre en ouvrant sa PR
  (échec CI), pas trois jours plus tard sur un bug incompréhensible.
- Le canal `stable` de Flutter avance vite. Sans mise à jour délibérée, l'écart
  se creusera avec les tutoriels et les réponses en ligne. Prévoir une revue de
  version entre deux sprints, pas au milieu d'un.
- La chaîne d'outils est figée, mais **non contrainte techniquement** sur les
  postes : rien n'empêche un dev d'installer une autre version. La CI est le
  garde-fou, pas l'environnement local.

## Alternative écartée pour l'instant : FVM

**FVM** (Flutter Version Management) installe et impose la version par dépôt
via un fichier `.fvmrc`. C'est la solution rigoureuse, et elle supprime
entièrement le problème côté poste de travail.

Écartée en v1 : elle ajoute une installation supplémentaire et une
configuration d'IDE à une équipe majoritairement débutante, pour un bénéfice
que la CI couvre déjà à coût nul.

**À adopter si** on constate réellement des diffs de code généré ou des écarts
de build entre machines. Ce n'est pas une décision définitive, c'est un choix
de séquencement : outil minimal d'abord, outil supplémentaire quand le
problème est observé.
