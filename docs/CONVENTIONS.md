# Conventions de l'équipe — Sorélia

Ce document est la référence commune. Il est court volontairement : ce qui n'y
est pas écrit n'est pas une règle.

---

## 1. Modèle de branches

**Une seule branche permanente : `main`.**

Sorélia est une application Android distribuée par APK, sans déploiement
continu. Une branche `develop` n'ajouterait qu'une étape de promotion sans
valeur : ce qui est fusionné est prêt, et une version se marque par un **tag**.

| Branche | Rôle |
| --- | --- |
| `main` | Branche officielle. **Protégée.** Doit rester livrable en permanence. |
| `feat/<sujet>` | Nouvelle fonctionnalité. Créée depuis `main`. |
| `fix/<sujet>` | Correction de bug. Créée depuis `main`. |
| `chore/<sujet>` | Intendance : configuration, dépendances, CI. |
| `docs/<sujet>` | Documentation seule. |

Exemples : `feat/saisie-notes`, `fix/moyenne-coefficient-nul`, `chore/ci-flutter`.

**Conséquence de ce choix :** `main` étant la seule branche d'intégration, une
PR fusionnée est immédiatement dans la version de référence. Une PR qui n'est
pas finie ne se fusionne pas — même « juste pour sauvegarder ». Pour
sauvegarder, on pousse sa branche ; c'est déjà sur GitHub.

### Versions

Une version se marque par un tag sur `main` :

```bash
git tag -a v0.1.0 -m "MVP sprint 3"
git push origin v0.1.0
```

---

## 2. Messages de commit

Format **Conventional Commits** :

```
type(zone): description courte au présent, sans point final
```

### Types autorisés

| Type | Quand |
| --- | --- |
| `feat` | Nouvelle fonctionnalité visible par l'élève |
| `fix` | Correction de bug |
| `docs` | Documentation uniquement |
| `test` | Ajout ou modification de tests |
| `refactor` | Réécriture sans changement de comportement |
| `chore` | Intendance : dépendances, configuration, CI, outillage |

### Zones

Elles suivent le découpage fonctionnel du backlog, pas les dossiers techniques :

`compte` · `profil` · `notes` · `calcul` · `edt` · `planning` · `notifications`
· `dashboard` · `faq` · `data` · `ui` · `ci`

La zone est facultative si le changement est global.

### Exemples

```
feat(notes): ajoute la suppression d'une note
feat(calcul): pondère la moyenne par les coefficients de la série
fix(edt): corrige le chevauchement de deux cours le samedi
test(calcul): couvre le cas d'une matière sans note
chore: fige Flutter 3.47.1 dans la CI
docs: ajoute l'ADR sur le dépôt public
```

### Contre-exemples

`fix`, `update`, `test2`, `wip`, `ça marche enfin` — dans trois mois, ces
messages ne veulent plus rien dire, et c'est précisément dans trois mois qu'on
lira l'historique.

---

## 3. Pull Requests

### Règles

1. **Jamais de push direct sur `main`.** GitHub le refuse — y compris aux
   administrateurs.
2. **Une PR = un sujet.** Une PR qui touche les notes *et* l'emploi du temps
   *et* le thème ne se relit pas.
3. **Une approbation d'un autre développeur** est obligatoire avant fusion.
4. **On ne fusionne jamais sa propre PR sans relecture**, même si on est
   responsable technique.
5. `flutter analyze` et `flutter test` doivent passer. Les lancer en local
   **avant** d'ouvrir la PR ; la CI les rejouera.

### Description d'une PR

Trois lignes suffisent, mais elles sont obligatoires :

```markdown
## Quoi
Ajoute l'écran de saisie d'une note (matière, type, valeur, barème, date).

## Pourquoi
US-013 — l'élève doit pouvoir tenir ses résultats à jour hors ligne.

## Comment tester
Écran Notes → bouton +, saisir 14/20 en Maths, vérifier que la note
réapparaît après avoir tué l'application.
```

Toujours citer **l'identifiant de l'US** (`US-013`) : c'est ce qui relie le
code au backlog.

### Relecture

Le relecteur vérifie, dans cet ordre :
1. Le code fait ce que la description annonce.
2. Il ne casse rien d'autre.
3. Il est lisible par quelqu'un qui ne l'a pas écrit.

Un commentaire de relecture porte sur le code, jamais sur la personne.

---

## 4. Cycle de travail quotidien

```bash
# 1. Partir d'un main à jour
git checkout main
git pull

# 2. Créer sa branche
git checkout -b feat/saisie-notes

# 3. Travailler, puis sauvegarder par petits commits
git add .
git commit -m "feat(notes): ajoute le formulaire de saisie"

# 4. Vérifier avant de pousser
flutter analyze
flutter test
dart format .

# 5. Envoyer la branche sur GitHub
git push -u origin feat/saisie-notes
```

6. Sur GitHub, cliquer **Compare & pull request**, vérifier que la PR pointe
   bien vers `main`, remplir la description, ajouter un relecteur.
7. Après approbation : **Merge pull request**, puis **Delete branch**.
8. En local :
   ```bash
   git checkout main && git pull
   ```

---

## 5. Ce qui ne doit jamais entrer dans le dépôt

Le dépôt est **public** ([ADR-0001](adr/0001-depot-public.md)). Un fichier
poussé par erreur est visible de tous, immédiatement et définitivement — le
supprimer ensuite ne le révoque pas.

- Clés de signature : `*.jks`, `*.keystore`, `key.properties`
- Jetons d'API, mots de passe, fichiers `.env`
- **Données réelles d'élèves** — les jeux de démonstration sont fictifs
- Fichiers générés : `build/`, `.dart_tool/`, et les `*.g.dart` produits par
  `build_runner` ([ADR-0004](adr/0004-code-genere-non-versionne.md))

Ces motifs sont dans le `.gitignore`. Si un secret est poussé malgré tout :
**le révoquer immédiatement** (changer la clé), puis prévenir l'équipe. Le
retirer de l'historique ne suffit pas.

---

## 6. Décisions techniques

Toute décision structurante et coûteuse à défaire s'écrit dans un **ADR**
(`docs/adr/`) : contexte, décision, conséquences, alternatives écartées.

Un ADR n'est pas de la paperasse. Il répond à la question qui revient
inévitablement six mois plus tard : « pourquoi on a fait comme ça ? ». Sans
lui, la décision se re-débat de zéro.

Nommage : `NNNN-sujet-en-kebab-case.md`, numérotation continue.
