package com.mycompany.gestionprojetjavaee.servlet;

import com.mycompany.gestionprojetjavaee.ejb.ActivityLogService;
import com.mycompany.gestionprojetjavaee.ejb.UtilisateurService;
import com.mycompany.gestionprojetjavaee.entity.Utilisateur;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ConnexionServlet", urlPatterns = {"/connexion", "/deconnexion"})
public class ConnexionServlet extends HttpServlet {

    @Inject
    private UtilisateurService utilisateurService;

    @Inject
    private ActivityLogService logService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/deconnexion".equals(path)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                Utilisateur u = (Utilisateur) session.getAttribute("utilisateurConnecte");
                if (u != null) {
                    logService.log(u.getEmail(), "DECONNEXION", "Déconnexion de l'utilisateur");
                }
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/connexion");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");

        Utilisateur user = utilisateurService.authentifier(email, motDePasse);

        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("utilisateurConnecte", user);
            logService.log(user.getEmail(), "CONNEXION", "Connexion réussie au système");
            response.sendRedirect(request.getContextPath() + "/demandes");
        } else {
            logService.log(email, "ECHEC_CONNEXION", "Tentative de connexion échouée");
            request.setAttribute("erreur", "Identifiants incorrects.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}