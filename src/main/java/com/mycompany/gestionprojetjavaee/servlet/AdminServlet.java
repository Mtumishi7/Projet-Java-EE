package com.mycompany.gestionprojetjavaee.servlet;

import com.mycompany.gestionprojetjavaee.ejb.ActivityLogService;
import com.mycompany.gestionprojetjavaee.ejb.DemandeStageService;
import com.mycompany.gestionprojetjavaee.ejb.UtilisateurService;
import com.mycompany.gestionprojetjavaee.entity.DemandeStage;
import com.mycompany.gestionprojetjavaee.entity.Utilisateur;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin/utilisateurs", "/admin/export-csv", "/admin/logs"})
public class AdminServlet extends HttpServlet {

    @Inject
    private UtilisateurService utilisateurService;

    @Inject
    private DemandeStageService demandeService;

    @Inject
    private ActivityLogService logService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur user = session != null ? (Utilisateur) session.getAttribute("utilisateurConnecte") : null;

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/demandes");
            return;
        }

        String path = request.getServletPath();

        if ("/admin/export-csv".equals(path)) {
            logService.log(user.getEmail(), "EXPORT_CSV", "Exportation de tous les rapports en CSV");
            response.setContentType("text/csv; charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment; filename=\"rapport_stages_pfe.csv\"");
            PrintWriter writer = response.getWriter();
            writer.println("ID;Type;Sujet;Statut;EmailEtudiant;Entreprise");

            List<DemandeStage> demandes = demandeService.listerToutes();
            for (DemandeStage d : demandes) {
                writer.printf("%d;%s;%s;%s;%s;%s%n",
                        d.getId(),
                        d.getType(),
                        d.getSujet().replace(";", ","),
                        d.getStatut(),
                        d.getEtudiantEntity() != null && d.getEtudiantEntity().getUtilisateur() != null ? d.getEtudiantEntity().getUtilisateur().getEmail() : "N/A",
                        d.getEntreprise() != null ? d.getEntreprise().getNom() : "N/A"
                );
            }
            writer.flush();
            return;
        }

        if ("/admin/logs".equals(path)) {
            request.setAttribute("logs", logService.listerTous());
            request.getRequestDispatcher("/WEB-INF/views/admin-logs.jsp").forward(request, response);
            return;
        }

        // /admin/utilisateurs
        List<Utilisateur> utilisateurs = utilisateurService.listerTous();
        request.setAttribute("utilisateurs", utilisateurs);
        request.getRequestDispatcher("/WEB-INF/views/admin-utilisateurs.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur user = session != null ? (Utilisateur) session.getAttribute("utilisateurConnecte") : null;

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/demandes");
            return;
        }

        String action = request.getParameter("action");
        if ("creer".equals(action)) {
            String email = request.getParameter("email");
            String motDePasse = request.getParameter("motDePasse");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String role = request.getParameter("role");

            Utilisateur nouveau = new Utilisateur();
            nouveau.setEmail(email);
            nouveau.setMotDePasse(motDePasse);
            nouveau.setNom(nom);
            nouveau.setPrenom(prenom);
            nouveau.setRole(role);

            utilisateurService.inscrire(nouveau);
            logService.log(user.getEmail(), "CREATION_UTILISATEUR", "Création du compte : " + email + " (" + role + ")");
        } else if ("supprimer".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            Utilisateur target = utilisateurService.trouverParId(id);
            String targetEmail = target != null ? target.getEmail() : "ID #" + id;
            utilisateurService.supprimer(id);
            logService.log(user.getEmail(), "SUPPRESSION_UTILISATEUR", "Suppression du compte : " + targetEmail);
        } else if ("modifier".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            String email = request.getParameter("email");
            String motDePasse = request.getParameter("motDePasse");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String role = request.getParameter("role");

            Utilisateur u = new Utilisateur();
            u.setId(id);
            u.setEmail(email);
            u.setMotDePasse(motDePasse);
            u.setNom(nom);
            u.setPrenom(prenom);
            u.setRole(role);

            utilisateurService.modifier(u);
            logService.log(user.getEmail(), "MODIFICATION_UTILISATEUR", "Modification du compte ID #" + id + " (" + email + ")");
        }

        response.sendRedirect(request.getContextPath() + "/admin/utilisateurs");
    }
}
