package com.mycompany.gestionprojetjavaee.servlet;

import com.mycompany.gestionprojetjavaee.ejb.DemandeStageService;
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

@WebServlet(name = "AttestationServlet", urlPatterns = {"/demandes/attestation"})
public class AttestationServlet extends HttpServlet {

    @Inject
    private DemandeStageService demandeService;

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

        if (demande == null) {
            response.sendRedirect(request.getContextPath() + "/demandes");
            return;
        }

        request.setAttribute("demande", demande);
        request.getRequestDispatcher("/WEB-INF/views/attestation.jsp").forward(request, response);
    }
}
