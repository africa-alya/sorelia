# Documentation du Système Académique & Structure des Notes

## 📌 Contextualisation

Afin d'assurer une gestion complète du parcours de l'étudiant (calcul des moyennes, suivi des semestres et gestion des coefficients), nous avons fait évoluer l'architecture locale et l'interface utilisateur.

---

## 🎯 Raisons de la création de la table académique

La création d'une table dédiée au **système académique** s'est avérée nécessaire pour les motifs suivants :

1. **Calcul des Notes et Coefficients :**
   - Stocker la liste des matières/UE associées à leurs coefficients respectifs selon le système éducatif.
   - Permettre à la **page de gestion des notes** d'effectuer des calculs dynamiques et exacts.

2. **Interface de Saisie des Notes (En cours - WIP) :**
   - La nouvelle page des notes s'appuie directement sur cette table pour afficher, ajouter et mettre à jour les évaluations de l'utilisateur.

3. **Séparation des Responsabilités (Clean Architecture) :**
   - Isoler les données académiques des autres modules de l'application (authentification, profil).



---

## 🗄️ Impact sur la Base de Données & l'UI

- **Base de données :** Ajout des entités pour le système académique et les notes (migration Drift).
- **Interface Utilisateur :**
  - Refactorisation de la page d'inscription.
  - Implémentation initiale de la page de gestion des notes (fonctionnalités en cours de finalisation).

---

## 🚀 Prochaines Étapes

- Completion des fonctionnalités sur la page de gestion des notes.
- Finalisation des tests unitaires pour les calculs de moyennes.