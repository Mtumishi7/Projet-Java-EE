package com.mycompany.gestionprojetjavaee.servlet;

import com.mycompany.gestionprojetjavaee.ejb.ActivityLogService;
import com.mycompany.gestionprojetjavaee.ejb.CommentaireService;
import com.mycompany.gestionprojetjavaee.ejb.DemandeStageService;
import com.mycompany.gestionprojetjavaee.entity.Commentaire;
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
import java.util.List;

@WebServlet(name = "CommentaireServlet", urlPatterns = {"/demandes/commentaires"})
public class CommentaireServlet extends HttpServlet {

    @Inject
    private CommentaireService commentaireService;

    @Inject
    private DemandeStageService demandeService;

    @Inject
    private ActivityLogService logService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur user = session != null ? (Utilisateur) session.getAttribute("utilisateurConnecte") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/connexion");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/demandes");
            return;
        }

        Long id = Long.parseLong(idStr);
        DemandeStage demande = demandeService.trouverParId(id);
        List<Commentaire> commentaires = commentaireService.listerParDemande(id);

        request.setAttribute("demande", demande);
        request.setAttribute("commentaires", commentaires);
        request.getRequestDispatcher("/WEB-INF/views/commentaires.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur user = session != null ? (Utilisateur) session.getAttribute("utilisateurConnecte") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/connexion");
            return;
        }

        Long demandeId = Long.parseLong(request.getParameter("demandeId"));
        String message = request.getParameter("message");

        if (message != null && !message.trim().isEmpty()) {
            commentaireService.ajouterCommentaire(demandeId, user.getEmail(), message);
            logService.log(user.getEmail(), "AJOUT_COMMENTAIRE", "Commentaire ajouté sur la demande ID #" + demandeId);
        }

        response.sendRedirect(request.getContextPath() + "/demandes/commentaires?id=" + demandeId);
    }
}
