package com.mycompany.gestionprojetjavaee.servlet;

import com.mycompany.gestionprojetjavaee.ejb.ActivityLogService;
import com.mycompany.gestionprojetjavaee.ejb.DemandeStageService;
import com.mycompany.gestionprojetjavaee.ejb.EntrepriseService;
import com.mycompany.gestionprojetjavaee.entity.DemandeStage;
import com.mycompany.gestionprojetjavaee.entity.Entreprise;
import com.mycompany.gestionprojetjavaee.entity.StatutDemande;
import com.mycompany.gestionprojetjavaee.entity.Utilisateur;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DemandeStageServlet", urlPatterns = {"/demandes", "/demandes/nouvelle", "/demandes/action"})
public class DemandeStageServlet extends HttpServlet {

    @Inject
    private DemandeStageService demandeService;

    @Inject
    private EntrepriseService entrepriseService;

    @Inject
    private ActivityLogService logService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateurConnecte");

        String path = request.getServletPath();
        String action = request.getPathInfo();

        if ("/demandes/nouvelle".equals(request.getRequestURI().substring(request.getContextPath().length()))) {
            request.setAttribute("entreprises", entrepriseService.listerToutes());
            request.getRequestDispatcher("/WEB-INF/views/form-demande.jsp").forward(request, response);
            return;
        }

        String search = request.getParameter("search");
        String statutFilter = request.getParameter("statutFilter");

        List<DemandeStage> demandes;
        if ("ETUDIANT".equals(user.getRole())) {
            demandes = demandeService.listerParEtudiant(user.getId());
        } else if ("ENSEIGNANT".equals(user.getRole())) {
            demandes = demandeService.listerParEncadreur(user.getId());
        } else {
            demandes = demandeService.listerToutes();
        }

        if (search != null && !search.trim().isEmpty()) {
            String q = search.toLowerCase();
            demandes = demandes.stream()
                .filter(d -> d.getSujet().toLowerCase().contains(q) || (d.getDescription() != null && d.getDescription().toLowerCase().contains(q)))
                .toList();
        }
        if (statutFilter != null && !statutFilter.trim().isEmpty()) {
            demandes = demandes.stream()
                .filter(d -> d.getStatut().name().equals(statutFilter))
                .toList();
        }

        request.setAttribute("demandes", demandes);
        request.getRequestDispatcher("/WEB-INF/views/demandes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateurConnecte");

        String uri = request.getRequestURI().substring(request.getContextPath().length());

        if ("/demandes/nouvelle".equals(uri)) {
            String sujetTitre = request.getParameter("sujet");
            String description = request.getParameter("description");
            String type = request.getParameter("type");
            String technologies = request.getParameter("technologies");
            String entrepriseIdStr = request.getParameter("entrepriseId");

            DemandeStage demande = new DemandeStage();
            demande.setSujet(sujetTitre);
            demande.setDescription(description);
            demande.setType(type != null ? type : "STAGE");
            demande.setTechnologies(technologies);
            if (entrepriseIdStr != null && !entrepriseIdStr.trim().isEmpty()) {
                Entreprise ent = entrepriseService.trouverParId(Long.parseLong(entrepriseIdStr));
                demande.setEntreprise(ent);
            }
            demande.setStatut(StatutDemande.BROUILLON);

            // Link to user if student (assuming user is mapped to Etudiant or we store directly)
            demandeService.enregistrerBrouillon(demande);
            logService.log(user != null ? user.getEmail() : "SYSTEM", "CREATION_PROPOSITION", "Création de la proposition : " + sujetTitre);
            response.sendRedirect(request.getContextPath() + "/demandes");
        } else if ("/demandes/action".equals(uri)) {
            Long id = Long.parseLong(request.getParameter("id"));
            String actionType = request.getParameter("actionType");

            switch (actionType) {
                case "SOUMETTRE":
                    demandeService.soumettreDemande(id);
                    logService.log(user != null ? user.getEmail() : "SYSTEM", "SOUMISSION_DEMANDE", "Soumission de la demande ID #" + id);
                    break;
                case "VALIDER":
                    demandeService.validerDemande(id);
                    logService.log(user != null ? user.getEmail() : "SYSTEM", "VALIDATION_DEMANDE", "Validation de la demande ID #" + id);
                    break;
                case "REFUSER":
                    String motif = request.getParameter("motifRefus");
                    if (motif == null || motif.trim().isEmpty()) {
                        motif = "Sujet non validé par l'encadreur.";
                    }
                    demandeService.refuserDemande(id, motif);
                    logService.log(user != null ? user.getEmail() : "SYSTEM", "REFUS_DEMANDE", "Refus de la demande ID #" + id + " - Motif: " + motif);
                    break;
                case "DEMARRER":
                    demandeService.demarrerStage(id);
                    logService.log(user != null ? user.getEmail() : "SYSTEM", "DEMARRAGE_STAGE", "Démarrage du stage ID #" + id);
                    break;
                case "DEPOSER":
                    demandeService.deposerRapport(id);
                    logService.log(user != null ? user.getEmail() : "SYSTEM", "DEPOT_RAPPORT", "Dépôt de rapport pour ID #" + id);
                    break;
                case "PLANIFIER":
                    demandeService.planifierSoutenance(id);
                    logService.log(user != null ? user.getEmail() : "SYSTEM", "PLANIFICATION_SOUTENANCE", "Planification soutenance ID #" + id);
                    break;
                case "EVALUER":
                    demandeService.evaluerSujet(id);
                    logService.log(user != null ? user.getEmail() : "SYSTEM", "EVALUATION_STAGE", "Évaluation du stage ID #" + id);
                    break;
                case "ARCHIVER":
                    demandeService.archiverDemande(id);
                    logService.log(user != null ? user.getEmail() : "SYSTEM", "ARCHIVAGE_DEMANDE", "Archivage de la demande ID #" + id);
                    break;
                default:
                    break;
            }
            response.sendRedirect(request.getContextPath() + "/demandes");
        }
    }
}
