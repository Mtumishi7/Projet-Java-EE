# Application Web Multi-Tiers Java EE — Gestion des Stages & PFE

**Université Polytechnique de Gitega**  
**Faculté des Technologies de l'Information et de la Communication**  
**Département de Génie Logiciel / BAC3 (Année universitaire 2025-2026)**  

**Auteurs :** IRABARUTA Olivier Jeremie & AYIKUNDE Juste Daxa  

---

## 📌 Présentation du Projet
Ce projet consiste en la réalisation d'une application web professionnelle de gestion des stages académiques et des Projets de Fin d'Études (PFE), développée en **Java EE pur** (Jakarta EE 10) sans aucun framework additionnel ni raccourci interdit (conformément aux exigences strictes du cahier des charges).

---

## 🏛️ Architecture & Technologies
L'application respecte rigoureusement l'architecture multi-tiers :
* **Couche Présentation (Web) :** Servlets Jakarta EE (`@WebServlet`), JSP et balises JSTL (`<c:forEach>`, `<c:if>`, `<fmt:...>`) sans scriptlets Java purs.
* **Couche Métier (EJB) :** Session Beans Stateless (`@Stateless`) encapsulant la logique métier et le workflow.
* **Couche Persistance (JPA) :** Entités JPA normalisées avec `EntityManager` et JPQL (`Utilisateur`, `Etudiant`, `Encadreur`, `Entreprise`, `DemandeStage`, `Commentaire`, `Document`, `Soutenance`, `Evaluation`, `ActivityLog`).
* **Injection de Dépendances (CDI) :** Utilisation intensive de `@Inject`.
* **Serveur d'Applications :** GlassFish 7+ / WildFly.
* **Interface & Design :** Tailwind CSS (avec support du mode sombre interactif).

---

## ✨ Fonctionnalités Clés Implémentées
1. **Authentification & Sécurité par Rôles :** Filtre de servlet (`AuthentificationFilter`) sécurisant l'accès selon les rôles (`ADMIN`, `ENSEIGNANT`, `ETUDIANT`).
2. **Espace Étudiant Complet :**
   * Tableau de bord personnalisé.
   * Soumission de propositions de stage ou PFE avec **choix de l'entreprise d'accueil** parmi les partenaires enregistrés.
   * Saisie des **compétences et technologies clés** (matching technologique).
   * Dépôt de rapports et téléchargement d'attestations officielles.
3. **Workflow d'États des Demandes :**
   * Cycle de vie complet : *BROUILLON → SOUMISE → VALIDEE → EN_COURS → RAPPORT_DEPOSE → SOUTENANCE_PLANIFIEE → EVALUEE → ARCHIVEE*.
4. **Fil de Discussion & Commentaires :**
   * Échanges intégrés par sujet entre étudiants et encadreurs.
5. **Administration & Traçabilité :**
   * Gestion des utilisateurs et journalisation des activités (`ActivityLog`).
6. **Mode Sombre (Dark Mode) :**
   * Bascule de thème visuel en un clic.

---

## 🚀 Guide de Déploiement et d'Utilisation

### 1. Base de Données
Exécutez le script SQL initial pour configurer les tables et le jeu de données de test :
```sql
script_initial.sql
```

### 2. Déploiement du WAR
Le fichier WAR déployable se trouve dans le dossier `target/` :
```bash
target/GestionProjetjavaEE-1.0-SNAPSHOT.war
```
Déployez ce fichier sur votre serveur d'applications **GlassFish 7+**.

### 3. Comptes de Connexion par Défaut
| Rôle | Email | Mot de passe |
| :--- | :--- | :--- |
| **Administrateur** | `admin@polytechnique.bi` | `admin123` |
| **Enseignant / Encadreur** | `encadreur1@polytechnique.bi` | `prof123` |
| **Étudiant** | `etudiant1@polytechnique.bi` | `etu123` |

---

## 📄 Documentation Technique
* Le rapport technique complet est disponible au format HTML moderne : **`Rapport_Technique.html`** (modifiable et exportable en PDF via `Ctrl + P`).
