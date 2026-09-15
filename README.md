# 🎓 Application Web Multi-Tiers Java EE — Gestion des Stages & PFE

[![Statut](https://img.shields.io/badge/Statut-Opérationnel-success?style=for-the-badge)]()
[![Java EE](https://img.shields.io/badge/Jakarta_EE-10-indigo?style=for-the-badge&logo=java)]()
[![Serveur](https://img.shields.io/badge/GlassFish-7+-red?style=for-the-badge)]()
[![Licence](https://img.shields.io/badge/Projet-Universitaire-blue?style=for-the-badge)]()

---

## 🏛️ Informations Académiques
* **Institution :** Université Polytechnique de Gitega  
* **Faculté :** Faculté des Technologies de l'Information et de la Communication (FTIC)  
* **Département :** Génie Logiciel / BAC3  
* **Année Universitaire :** 2025-2026  
* **Auteurs :** 
  * **IRABARUTA Olivier Jeremie**
  * **AYIKUNDE Juste Daxa**

---

## 📋 Table des Matières
1. [Présentation du Projet](#-présentation-du-projet)
2. [Architecture Technique & Contraintes Respectées](#-architecture-technique--contraintes-respectées)
3. [Structure de la Base de Données & Entités JPA](#-structure-de-la-base-de-données--entités-jpa)
4. [Fonctionnalités Détaillées par Rôle](#-fonctionnalités-détaillées-par-rôle)
5. [Guide d'Installation et Déploiement](#-guide-dinstallation-et-déploiement)
6. [Comptes de Test par Défaut](#-comptes-de-test-par-défaut)
7. [Documentation et Rapport Technique](#-documentation-et-rapport-technique)

---

## 🎯 1. Présentation du Projet
L'application **GestionProjetjavaEE** est une plateforme web d'entreprise moderne conçue pour automatiser et piloter l'intégralité du cycle de vie des stages académiques et Projets de Fin d'Études (PFE). 

Elle résout les problématiques de suivi, de validation hiérarchique, d'attribution d'entreprises, de dépôt de rapports et de planification des soutenances dans un cadre universitaire.

---

## 🏗️ 2. Architecture Technique & Contraintes Respectées
Conformément au cahier des charges strict du projet, l'application repose exclusivement sur le socle **Java EE natif (Jakarta EE 10)** sans aucun framework tiers (zéro Spring Boot, zéro Hibernate tiers hors JPA natif, zéro moteur de template externe) :

```
┌────────────────────────────────────────────────────────┐
│               Couche Présentation (JSP / JSTL)         │
└──────────────────────────┬─────────────────────────────┘
                           │ HTTP Request / Response
┌──────────────────────────▼─────────────────────────────┐
│          Contrôleurs Frontaux (Servlets Jakarta EE)    │
└──────────────────────────┬─────────────────────────────┘
                           │ Injection CDI (@Inject)
┌──────────────────────────▼─────────────────────────────┐
│            Couche Métier (Session Beans EJB)           │
└──────────────────────────┬─────────────────────────────┘
                           │ EntityManager / JPQL
┌──────────────────────────▼─────────────────────────────┐
│           Couche Persistance (Entités JPA)             │
└──────────────────────────┬─────────────────────────────┘
                           │ JDBC / SGBD
┌──────────────────────────▼─────────────────────────────┐
│               Base de Données Relationnelle            │
└────────────────────────────────────────────────────────┘
```

* **Servlets :** Contrôleurs de navigation et traitement des requêtes (`/demandes`, `/entreprises`, `/connexion`, etc.).
* **JSP + JSTL :** Vues dynamiques strictement sans scriptlets Java purs (utilisation exclusive de `<c:forEach>`, `<c:if>`, `<fmt:...>`).
* **EJB (Enterprise JavaBeans) :** Session Beans Stateless (`@Stateless`) pour encapsuler les règles métier et transactions.
* **CDI (Contexts and Dependency Injection) :** Injection de dépendances via `@Inject`.
* **Filtres de Servlet :** `AuthentificationFilter` pour le contrôle d'accès par rôle (`ADMIN`, `ENSEIGNANT`, `ETUDIANT`).

---

## 📊 3. Structure de la Base de Données & Entités JPA
Le modèle relationnel normalisé comprend les entités principales suivantes :
* **`Utilisateur`** : Gestion des comptes globaux (email, mot de passe haché, nom, prénom, rôle).
* **`Etudiant`** : Profil spécifique étudiant (matricule, filière, promotion, lié à un utilisateur).
* **`Encadreur`** : Profil enseignant (spécialité, département, lié à un utilisateur).
* **`Entreprise`** : Entreprises partenaires d'accueil (nom, adresse, email, téléphone).
* **`DemandeStage`** : Proposition de sujet (type STAGE/PFE, sujet, description, technologies, statut, motif de refus).
* **`Commentaire`** : Fil de discussion et remarques par sujet de stage.
* **`Document`** & **`Rapport`** : Gestion des livrables et fichiers joints.
* **`Soutenance`** & **`Evaluation`** : Planification des jurys et notes finales.
* **`ActivityLog`** : Traçabilité et journaux d'activités système.

---

## 👤 4. Fonctionnalités Détaillées par Rôle

### 🎓 Étudiant
* Soumission de propositions de stage ou PFE.
* **Sélection libre de l'entreprise d'accueil** parmi la liste des entreprises partenaires.
* Ajout de **tags technologiques** (ex: *Java EE, Angular, Docker*).
* Suivi en temps réel du **workflow d'états** (*Brouillon → Soumise → Validée → En cours → Rapport déposé → Soutenance planifiée → Évaluée → Archivée*).
* Participation au **fil de discussion** avec l'encadreur.
* Téléchargement de l'**attestation de stage** officielle au format dynamique.
* Bascule en **Mode Sombre (Dark Mode)** en un clic.

### 👨‍🏫 Enseignant / Encadreur
* Consultation des propositions de stage et PFE assignées ou globales.
* Validation ou refus motivé des sujets.
* Pilotage du workflow de stage (démarrage, dépôt de rapport, planification de soutenance, évaluation).
* Échanges et conseils via les commentaires intégrés.

### 🛠️ Administrateur
* Gestion complète des utilisateurs (création, modification, rôles).
* Supervision de l'ensemble des propositions de stage de l'établissement.
* Consultation des **journaux d'activités (`ActivityLog`)**.
* Exportation des données au format CSV.

---

## ⚙️ 5. Guide d'Installation et Déploiement

### Prérequis
* Java Development Kit (JDK 17 ou supérieur)
* Apache Maven (3.8+)
* Serveur d'applications **GlassFish 7+** (ou WildFly équivalent)
* IDE compatible (NetBeans, Eclipse, IntelliJ IDEA)

### Étape 1 : Base de Données
Exécutez le script SQL initial pour créer le schéma et insérer le jeu de données de test (utilisateurs, entreprises, étudiants, encadreurs) :
```sql
script_initial.sql
```

### Étape 2 : Compilation du Projet
À la racine du projet, compilez l'application avec Maven pour générer le fichier livrable `.war` :
```bash
mvn clean package -DskipTests
```
Le fichier généré se trouvera dans :
`target/GestionProjetjavaEE-1.0-SNAPSHOT.war`

### Étape 3 : Déploiement sur GlassFish
1. Lancez votre serveur GlassFish.
2. Ouvrez la console d'administration GlassFish (généralement `http://localhost:4848`).
3. Allez dans **Applications** → **Deploy**.
4. Sélectionnez le fichier `target/GestionProjetjavaEE-1.0-SNAPSHOT.war` et validez.

---

## 🔑 6. Comptes de Test par Défaut
Le script d'initialisation intègre les comptes suivants :

| Rôle | Email | Mot de passe |
| :--- | :--- | :--- |
| **Administrateur** | `admin@polytechnique.bi` | `admin123` |
| **Enseignant** | `encadreur1@polytechnique.bi` | `prof123` |
| **Étudiant 1** | `etudiant1@polytechnique.bi` | `etu123` |
| **Étudiant 2** | `etudiant2@polytechnique.bi` | `etu123` |

---

## 📄 7. Documentation et Rapport Technique
* Le rapport technique complet du projet (conforme aux exigences universitaires) est disponible sous deux formats dans le projet :
  * **Markdown :** `Rapport_Technique.md`
  * **HTML Interactif & Prêt à imprimer en PDF :** `Rapport_Technique.html` (ouvrez-le dans votre navigateur puis faites `Ctrl + P` → *Enregistrer au format PDF*).
