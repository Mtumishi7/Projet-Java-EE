# RAPPORT TECHNIQUE DE PROJET JAVA EE
## Gestion des Stages et Projets de Fin d'Études (PFE)

**Université Polytechnique de Gitega**  
**Faculté des Technologies de l'Information et de la Communication**  
**Département de Génie Logiciel / BAC3**  
**Année universitaire :** 2025-2026  

**Auteurs :** IRABARUTA Olivier Jeremie & AYIKUNDE Juste Daxa  

---

## 1. Introduction et Présentation du Projet

### 1.1 Contexte et Problématique
La gestion administrative et pédagogique des stages académiques et des Projets de Fin d'Études (PFE) au sein de l'université nécessite un suivi rigoureux. Le processus traditionnel basé sur des documents papiers ou des échanges d'e-mails non structurés entraîne des pertes d'informations, des difficultés dans le suivi des workflows de validation et un manque de visibilité pour les étudiants et les encadreurs.

### 1.2 Objectifs de l'Application
L'application **GestionProjetjavaEE** a été conçue pour digitaliser et fluidifier l'ensemble du cycle de vie des stages et PFE :
* Soumission de sujets et choix d'entreprises par les étudiants.
* Validation, refus ou demande de modification par les encadreurs et administrateurs.
* Suivi des états d'avancement (Brouillon, Soumise, Validée, En cours, Rapport déposé, Soutenue, Évaluée, Archivée).
* Gestion des documents (CV, rapports) et des fils de discussion / commentaires.
* Planification des soutenances et génération d'attestations officielles.

---

## 2. Architecture de l'Application (Multi-Tiers)

L'application respecte strictement l'architecture multi-tiers préconisée en Java EE, garantissant une séparation claire des responsabilités entre les couches :

```
[ Couche Présentation (JSP / JSTL / Servlets) ]
                     ↓ (Injections CDI @Inject)
[ Couche Métier (Session Beans EJB @Stateless) ]
                     ↓ (EntityManager / JPQL)
[ Couche Persistance (Entités JPA & Base de Données) ]
```

### 2.1 Couche Présentation (Web)
* **Servlets Jakarta EE (`@WebServlet`) :** Agissent comme des contrôleurs frontaux (`DemandeStageServlet`, `EntrepriseServlet`, `CommentaireServlet`, `AttestationServlet`, `AdminServlet`) pour traiter les requêtes HTTP (`doGet`, `doPost`), gérer le routage et appliquer la sécurité via des filtres (`AuthentificationFilter`).
* **JSP & JSTL :** Vues dynamiques 100% sans scriptlets Java purs, utilisant exclusivement les balises JSTL (`<c:forEach>`, `<c:if>`, etc.) et le langage d'expression (EL).

### 2.2 Couche Métier (EJB - Enterprise JavaBeans)
* Composée de **Session Beans Stateless** (`DemandeStageService`, `EntrepriseService`, `CommentaireService`, `UtilisateurService`, `ActivityLogService`).
* Encapsule toute la logique métier, la gestion des transactions et les règles de validation du workflow.

### 2.3 Couche Persistance (JPA - Jakarta Persistence)
* Modèle de données objet relationnel robuste mappé via JPA / Hibernate (`EntityManager`).
* Entités principales : `Utilisateur`, `Etudiant`, `Encadreur`, `Entreprise`, `DemandeStage`, `Commentaire`, `Document`, `Soutenance`, `Evaluation`, `ActivityLog`.

---

## 3. Modélisation et Conception

### 3.1 Acteurs du Système
1. **Étudiant :** Soumet ses propositions de stage/PFE, choisit son entreprise, dépose ses rapports, consulte les commentaires et télécharge son attestation.
2. **Encadreur (Enseignant) :** Valide ou refuse les sujets, suit l'avancement, échange via le fil de discussion et évalue les soutenances.
3. **Administrateur :** Gère l'ensemble des utilisateurs, consulte les journaux d'activités (`ActivityLog`) et supervise la plateforme.

### 3.2 Diagramme de Classes (Résumé des relations JPA)
* `Utilisateur` (1) ──── (0..1) `Etudiant` / `Encadreur`
* `DemandeStage` (N) ──── (1) `Etudiant`
* `DemandeStage` (N) ──── (0..1) `Encadreur`
* `DemandeStage` (N) ──── (1) `Entreprise`
* `DemandeStage` (1) ──── (N) `Commentaire`
* `DemandeStage` (1) ──── (N) `Document`
* `DemandeStage` (1) ──── (0..1) `Soutenance`

---

## 4. Extraits de Code Clés

### 4.1 Entité JPA (`DemandeStage.java`)
```java
@Entity
@Table(name = "demandes_stage")
public class DemandeStage implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String sujet;

    @Column(length = 1000)
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutDemande statut = StatutDemande.BROUILLON;

    private String technologies;

    @ManyToOne
    @JoinColumn(name = "etudiant_id", nullable = false)
    private Etudiant etudiantEntity;

    @ManyToOne
    @JoinColumn(name = "entreprise_id")
    private Entreprise entreprise;
    
    // Getters et Setters...
}
```

### 4.2 Composant Métier EJB (`DemandeStageService.java`)
```java
@Stateless
public class DemandeStageService {
    @PersistenceContext(unitName = "GestionProjetPU")
    private EntityManager em;

    public void enregistrerBrouillon(DemandeStage demande) {
        em.persist(demande);
    }

    public void soumettreDemande(Long id) {
        DemandeStage d = em.find(DemandeStage.class, id);
        if (d != null && d.getStatut() == StatutDemande.BROUILLON) {
            d.setStatut(StatutDemande.SOUMISE);
            em.merge(d);
        }
    }
    
    public List<DemandeStage> listerParEtudiant(Long etudiantId) {
        return em.createQuery("SELECT d FROM DemandeStage d WHERE d.etudiantEntity.id = :id", DemandeStage.class)
                 .setParameter("id", etudiantId)
                 .getResultList();
    }
}
```

### 4.3 Contrôleur Servlet avec Injection CDI (`DemandeStageServlet.java`)
```java
@WebServlet(name = "DemandeStageServlet", urlPatterns = {"/demandes", "/demandes/nouvelle", "/demandes/action"})
public class DemandeStageServlet extends HttpServlet {

    @Inject
    private DemandeStageService demandeService;

    @Inject
    private EntrepriseService entrepriseService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateurConnecte");

        String uri = request.getRequestURI().substring(request.getContextPath().length());
        if ("/demandes/nouvelle".equals(uri)) {
            request.setAttribute("entreprises", entrepriseService.listerToutes());
            request.getRequestDispatcher("/WEB-INF/views/form-demande.jsp").forward(request, response);
            return;
        }
        
        List<DemandeStage> demandes = demandeService.listerToutes();
        request.setAttribute("demandes", demandes);
        request.getRequestDispatcher("/WEB-INF/views/demandes.jsp").forward(request, response);
    }
}
```

### 4.4 Vue JSP / JSTL (`demandes.jsp`)
```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
...
<c:forEach var="d" items="${demandes}">
    <tr class="hover:bg-slate-50">
        <td class="py-4 px-6 font-medium">#<c:out value="${d.id}"/></td>
        <td class="py-4 px-6 font-semibold"><c:out value="${d.sujet}"/></td>
        <td class="py-4 px-6">
            <span class="px-3 py-1 rounded-full text-xs font-bold bg-emerald-100 text-emerald-800">
                <c:out value="${d.statut}"/>
            </span>
        </td>
    </tr>
</c:forEach>
```

---

## 5. Choix Techniques et Difficultés Rencontrées

### 5.1 Choix Techniques
* **Choix de Jakarta EE 10 / GlassFish 7+ :** Permet de respecter les standards d'entreprise modernes sans dépendre de frameworks lourds comme Spring Boot, tout en profitant de l'injection de dépendances CDI native et de la robustesse des EJB.
* **Tailwind CSS (via CDN) :** Choisi pour styliser rapidement l'interface utilisateur avec un design moderne et responsive, sans alourdir le serveur d'application par des compilateurs de assets complexes.

### 5.2 Difficultés Rencontrées
* **Gestion des sessions et sécurité multi-rôles :** La mise en place d'un filtre d'authentification (`AuthentificationFilter`) a nécessité une attention particulière pour interdire l'accès aux URLs administratives ou étudiantes selon le rôle stocké en session.
* **Mappage relationnel JPA :** La structuration des clés étrangères entre `Utilisateur`, `Etudiant`, `DemandeStage` et `Entreprise` a exigé un contrôle rigoureux des cascades et des transactions gérées par le conteneur EJB (`@Stateless`).

---

## 6. Conclusion
Le développement de l'application **GestionProjetjavaEE** a permis de mettre en pratique les concepts fondamentaux de l'architecture multi-tiers Java EE. Le respect strict des contraintes pédagogiques (zéro framework tiers interdit, utilisation de Servlets, JSP/JSTL, EJB, JPA et CDI) aboutit à une solution logicielle modulaire, maintenable et pleinement fonctionnelle.
