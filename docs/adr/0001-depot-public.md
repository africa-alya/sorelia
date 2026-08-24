# ADR-0001 — Dépôt GitHub public

## Contexte

Le code de Sorélia doit vivre dans un dépôt de l'organisation GitHub ALYA,
avec la branche `main` protégée : aucun push direct, passage obligatoire par
une Pull Request relue. C'est un critère d'acceptation d'US-001.

ALYA est sur le plan **GitHub Free**. Sur ce plan, les règles de protection de
branche ne sont disponibles que sur les dépôts **publics** ; sur un dépôt
privé, elles exigent un plan payant (Pro / Team / Enterprise).

Le CCT porte la mention « Confidentiel ». Elle concerne le document lui-même,
pas nécessairement le code source : l'application est local-first et aucune
donnée d'élève ne transite ni ne réside dans le dépôt.

## Décision

Le dépôt `ALYA/sorelia` est **public**.

La protection de `main` prime sur la confidentialité du code source, parce que
le risque qu'elle couvre est quotidien (un push direct casse le travail de
l'équipe) alors que le risque qu'ouvre la publication est théorique (le code
d'une application de calcul de moyennes n'a pas de valeur concurrentielle).

## Conséquences

- La protection de `main` est disponible sans coût. Elle doit être configurée
  avec **« Do not allow bypassing the above settings »** coché, sinon les
  administrateurs de l'organisation — dont le responsable technique — y
  échappent, et la protection ne protège personne.
- **Bénéfice non prévu** : les minutes GitHub Actions sont illimitées et
  gratuites sur les dépôts publics, alors qu'elles sont plafonnées en Free sur
  les dépôts privés. La CI (étape suivante d'US-001) ne coûte rien.
- **Tout commit est définitif et mondial.** Un secret poussé par erreur est
  lisible et moissonné en quelques minutes ; le supprimer ensuite ne le révoque
  pas. Contreparties obligatoires :
  - `.gitignore` couvre `key.properties`, `*.jks`, `*.keystore` **avant** le
    premier commit — c'est le cas ;
  - **Secret scanning** et **Push protection** activés dans
    Settings → Advanced Security (gratuits sur dépôt public) ;
  - le keystore de signature de l'APK ne vit **jamais** dans le dépôt.
- **Licence à trancher.** Un dépôt public sans fichier `LICENSE` signifie
  « tous droits réservés » : le code est lisible mais personne ne peut
  légalement le réutiliser. Si ALYA veut autoriser la réutilisation, il faut
  ajouter une licence explicite. En l'absence de décision, l'état par défaut
  est « tous droits réservés ».
- N'importe qui peut forker le dépôt et ouvrir une PR. Seuls les membres avec
  le droit Write peuvent approuver et fusionner ; les PR externes se traitent
  comme des contributions à relire, pas à subir.
- Aucune donnée personnelle d'élève ne doit apparaître dans le dépôt, y compris
  dans les jeux de données de démonstration : ils sont fictifs.

## Alternatives écartées

- **Dépôt privé sans protection de branche** : revient à demander à 3-4 devs de
  ne pas se tromper. Le premier push direct sur `main` un soir de rush arrive
  toujours.
- **Passer au plan payant** : hors budget (le CCT impose une enveloppe
  restreinte).

## À réexaminer

- **GitHub for Nonprofits** (github.com/nonprofit) offre le plan Team gratuit
  aux organisations à but non lucratif vérifiées. Si ALYA obtient cette
  validation, le dépôt peut repasser en privé **sans perdre** la protection de
  branche. Demande à déposer ; cet ADR sera révisé si elle aboutit.
- La disponibilité des *rulesets* (nouvelle interface de règles GitHub) sur les
  dépôts privés en plan Free évolue. À vérifier avant de reconduire cette
  décision.
