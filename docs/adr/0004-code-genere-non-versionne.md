# ADR-0004 — Le code généré n'est pas versionné

## Contexte

Drift produit du code à partir des définitions de tables, via `build_runner`.
Pour le seul schéma initial (US-002), le fichier généré
`lib/data/local/app_database.g.dart` fait **5822 lignes**.

Ce fichier est apparu dans le dépôt sans décision : il a été committé parce
que rien ne l'en empêchait. Il fallait trancher dans un sens ou dans l'autre,
et surtout sortir de l'état intermédiaire — un fichier généré versionné que
rien ne vérifie.

## Décision

Les fichiers générés (`*.g.dart`) **ne sont pas versionnés**. Ils sont dans le
`.gitignore` et chacun les régénère localement :

```bash
dart run build_runner build
```

La CI exécute la même commande avant d'analyser et de tester.

## Raisons

**1. Les revues restent lisibles.** Une modification de schéma qui ajoute une
colonne produit une dizaine de lignes utiles noyées dans des milliers de
lignes générées. Le relecteur ne peut plus voir ce qu'il relit.

**2. On évite des conflits de fusion ingérables.** À six développeurs, deux
Pull Requests touchant au schéma produisent deux versions concurrentes du
fichier généré. Résoudre un tel conflit est un piège : la tentation est de le
corriger à la main, ce qui corrompt un fichier qui ne doit jamais être édité.

**3. On supprime la dérive silencieuse.** Un fichier généré versionné peut ne
plus correspondre à sa source — quelqu'un modifie les tables, oublie de
régénérer, committe. Le dépôt contient alors un fichier qui ment, et personne
ne le sait.

## Conséquences

- **Après chaque `git pull` qui touche au schéma**, il faut relancer
  `build_runner`. Sans ça, l'éditeur affiche des centaines d'erreurs — elles
  sont normales et disparaissent après la régénération. C'est le coût réel de
  cette décision, et il est payé par toute l'équipe.
- La commande est documentée dans le `README`, dans les prérequis
  d'installation.
- La CI la lance avant `flutter analyze` et `flutter test` : une génération
  cassée est donc détectée automatiquement.
- La CI conserve son contrôle de fraîcheur (`git diff --exit-code` après
  génération). Il ne se déclenchera plus tant que rien de généré n'est
  versionné, mais il reste en place comme filet si un fichier généré était
  committé par erreur.
- Le fichier déjà versionné sur la branche `feature/US-002-base-locale-drift`
  doit être retiré du suivi Git par `git rm --cached` : ajouter un motif au
  `.gitignore` ne désuit pas un fichier déjà suivi.

## Alternative écartée : versionner le code généré

Défendable, et c'est le choix de certains projets : l'éditeur fonctionne dès
le clone, sans exécuter quoi que ce soit, et la CI est plus rapide. Pour une
équipe débutante, ce confort compte.

Écartée parce que les trois raisons ci-dessus pèsent plus lourd sur un projet
à six développeurs dont le schéma va bouger à chaque sprint jusqu'à la v1.

**Si on avait retenu cette option**, elle aurait été inséparable d'un contrôle
en CI prouvant que le fichier versionné est à jour (régénérer, puis vérifier
que `git diff` est vide). Versionner un fichier généré sans ce contrôle n'est
pas une option : c'est l'état dont cet ADR nous sort.
