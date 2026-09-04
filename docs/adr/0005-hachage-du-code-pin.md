# ADR-0005 — Hachage du code PIN

**Statut :** accepté
**Date :** 2026-09-03

---

## Contexte

Le CCT §6.3 impose que le code PIN d'un élève ne soit jamais stocké en clair.
Le schéma de la base le documentait déjà (`eleve.code_pin` = « empreinte
hachée »), mais aucune implémentation n'existait : les premiers écrans de
création de compte et de connexion écrivaient et comparaient la saisie brute.

Sorélia est une application Android hors ligne. La base `sorelia.sqlite` vit
dans le répertoire privé de l'application. Il n'y a ni serveur, ni compte
distant : toute la vérification se fait sur l'appareil.

**Le PIN fait 4 chiffres**, soit 10 000 possibilités. C'est un choix produit
assumé (les utilisateurs sont des collégiens et lycéens), et il détermine tout
le reste de cette décision.

---

## Décision

Le PIN est haché avec **PBKDF2-HMAC-SHA256**, 150 000 itérations, sel aléatoire
de 16 octets tiré par élève, empreinte de 32 octets. L'implémentation vit dans
`lib/core/security/pin_service.dart` et s'appuie sur **`pointycastle`**.

L'empreinte est stockée dans un format auto-descriptif :

```text
pbkdf2_sha256$150000$<sel base64>$<empreinte base64>
```

Le coût voyage avec l'empreinte : on pourra relever les itérations plus tard
sans invalider les comptes existants.

Trois conséquences de forme :

1. La dérivation tourne dans un **isolate** (`Isolate.run`) : plusieurs
   centaines de millisecondes en Dart pur sur un Android d'entrée de gamme
   figeraient l'écran au moment de l'appui sur « Se connecter ».
2. La comparaison est **à temps constant**, pour ne pas renseigner un attaquant
   sur l'endroit où les empreintes divergent.
3. Le champ de l'entité `Student` est renommé `codePin` → **`empreintePin`**.
   Le compilateur refuse alors tout point d'appel qui y glisserait la saisie
   brute. Le nom de la colonne SQL, lui, reste `code_pin` : c'est celui du
   dictionnaire de données du CCT, et le changer imposerait une migration.

---

## Ce que cette décision ne protège PAS

À écrire noir sur blanc, parce que c'est le contresens qui guette :

**Un PIN à 4 chiffres n'est pas défendable contre quelqu'un qui possède le
fichier `sorelia.sqlite`.** PBKDF2-SHA256 à 150 000 itérations représente
environ 300 000 compressions SHA-256 par candidat. Un GPU de jeu récent en
soutient de l'ordre de 2 × 10¹⁰ par seconde, soit ~66 000 candidats/seconde :
les 10 000 PIN possibles tombent en **moins d'une seconde**. Même sur un simple
CPU avec une implémentation native, l'espace complet s'épuise en une dizaine de
secondes.

Passer à 6 chiffres porterait cela à une quinzaine de secondes sur GPU ; passer
à Argon2id changerait le facteur, pas l'ordre de grandeur. **Il n'existe pas de
réglage qui rende un PIN numérique résistant à une attaque hors ligne.** C'est
la contrainte de fond, et c'est pour cela que la section suivante compte plus
que le choix d'algorithme.

Ce que ce hachage apporte réellement :

- il empêche la lecture opportuniste du PIN par quiconque ouvre le fichier
  (sauvegarde, appareil partagé, support technique) ;
- il évite de faire fuiter un PIN que l'élève **réutilise ailleurs** — c'est le
  risque RGPD concret, et il est suffisant à lui seul pour justifier ce travail.

**La protection qui compte donc réellement est la limitation des tentatives**
(US-007), puisque l'attaque réaliste est une attaque *en ligne*, sur l'appareil,
à travers l'écran de connexion. Sans elle, ce hachage reste largement cosmétique.

Le pas suivant, s'il devient nécessaire, est le **chiffrement de la base**
(SQLCipher, clé dans l'Android Keystore) : il fait disparaître le scénario
« l'attaquant possède le fichier ». Ce sera un ADR distinct.

---

## Coût mesuré, et ce qu'il faut en faire

Mesuré sur un PC de bureau, une vérification à 150 000 itérations coûte
**~650 ms**. PBKDF2 en Dart pur ne bénéficie d'aucune accélération native ; sur
un Android d'entrée de gamme, il faut s'attendre à **plusieurs secondes**.

Il faut en tirer la conséquence logique : puisqu'aucun réglage ne procure de
résistance hors ligne (section précédente), **le nombre d'itérations n'est pas
un curseur de sécurité, c'est un curseur d'expérience utilisateur**. Ce qu'il
protège, c'est l'attaque *en ligne* — quelqu'un qui tape des PIN sur l'écran de
connexion — et là, quelques dizaines de millisecondes suffisent dès lors que la
limitation des tentatives d'US-007 est en place.

**Action ouverte :** mesurer `PinService.verifier` sur un vrai téléphone
d'entrée de gamme représentatif du parc visé, et retenir la plus grande valeur
qui garde la connexion sous ~1 seconde. `iterationsParDefaut` est prévu pour
être abaissé ou relevé sans invalider les comptes existants : le coût est
inscrit dans chaque empreinte.

---

## Alternatives écartées

| Alternative | Pourquoi écartée |
| --- | --- |
| **Argon2id via `cryptography`** | Meilleur en théorie (résistant au calcul parallèle). Mais un coût mémoire honnête (64 Mo) est risqué sur un Android 2 Go, ce qui est notre cible ; et le fork `cryptography_plus`, publié en 3.0.0 face à un original figé en 2.9.0, laisse planer un doute sur la maintenance. Le gain est de toute façon marginal face à un espace de 10 000 PIN. |
| **Argon2id via `dargon2` (FFI natif)** | Rapide, mais complexifie la compilation Android et ne tourne pas dans `flutter test` sur la CI Linux sans la bibliothèque native. Un test de sécurité qu'on ne peut pas exécuter en CI ne sert à rien. |
| **PBKDF2 écrit à la main avec `crypto`** | Une trentaine de lignes qu'on peut se tromper subtilement à écrire, pour économiser une dépendance. Mauvais échange sur du code cryptographique. |
| **SHA-256 salé, sans étirement de clé** | Se casse en millisecondes. Aurait donné l'illusion d'avoir traité le sujet. |
| **`flutter_secure_storage` (Android Keystore)** | Déplace le secret hors de la base plutôt que de le hacher, et sort du schéma décrit par le CCT. Piste à reconsidérer avec le chiffrement de base, pas isolément. |

---

## Conséquences

- Nouvelle dépendance : `pointycastle` (Dart pur, aucune chaîne native).
- Les comptes créés avant cette décision contiennent un PIN en clair, qui ne
  suit pas le format d'empreinte : `PinService.verifier` retourne `false` sans
  lever d'exception. **Aucune migration n'est écrite** — l'application n'est pas
  encore distribuée, le schéma SQL ne change pas (`schemaVersion` reste à 1), et
  les développeurs désinstallent simplement l'application. On ne prévoit jamais
  de repli sur une comparaison en clair.
- US-007 doit livrer la limitation des tentatives pour que cette décision ait
  la portée annoncée. *Livrée depuis dans
  `lib/core/security/limiteur_tentatives.dart` : blocages de 30 s, 2 min, 5 min
  puis 15 min tous les 5 échecs, compteur remis à zéro par la seule connexion
  réussie.*
