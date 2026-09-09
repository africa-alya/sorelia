# ADR-0003 — applicationId

## Contexte
La convention Android est le nom de domaine inversé. ALYA ne détient
aucun domaine à ce jour. Android et le Play Store ne vérifient pas la
propriété du domaine : la convention sert l'unicité, pas la preuve.

## Décision
applicationId = bj.alya.sorelia

## Conséquences
- IRRÉVERSIBLE après publication. Un changement crée une application
  distincte : pas de mise à jour possible, et désinstallation =
  perte de toutes les données locales de l'élève (architecture
  local-first, aucune synchronisation en v1).
- Si ALYA enregistre alya.bj, l'identifiant devient rétroactivement
  conforme à la convention.
- Alternative écartée : io.github.<org>.sorelia