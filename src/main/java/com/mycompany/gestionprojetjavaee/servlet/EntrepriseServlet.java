package com.mycompany.gestionprojetjavaee.servlet;

import com.mycompany.gestionprojetjavaee.ejb.EntrepriseService;
import com.mycompany.gestionprojetjavaee.entity.Entreprise;
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

@WebServlet(name = "EntrepriseServlet", urlPatterns = {"/entreprises", "/entreprises/nouvelle"})
public class EntrepriseServlet extends HttpServlet {

    @Inject
    private EntrepriseService entrepriseService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI().substring(request.getContextPath().length());
        HttpSession session = request.getSession(false);
        Utilisateur user = session != null ? (Utilisateur) session.getAttribute("utilisateurConnecte") : null;

        if ("/entreprises/nouvelle".equals(uri)) {
            if (user == null || !"ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/entreprises");
                return;
            }
            request.getRequestDispatcher("/WEB-INF/views/form-entreprise.jsp").forward(request, response);
            return;
        }

        List<Entreprise> entreprises = entrepriseService.listerToutes();
        request.setAttribute("entreprises", entreprises);
        request.getRequestDispatcher("/WEB-INF/views/entreprises.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI().substring(request.getContextPath().length());
        HttpSession session = request.getSession(false);
        Utilisateur user = session != null ? (Utilisateur) session.getAttribute("utilisateurConnecte") : null;

        if ("/entreprises/nouvelle".equals(uri)) {
            if (user == null || !"ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/entreprises");
                return;
            }
            String nom = request.getParameter("nom");
            String adresse = request.getParameter("adresse");
            String emailContact = request.getParameter("emailContact");
            String telephone = request.getParameter("telephone");

            Entreprise entreprise = new Entreprise();
            entreprise.setNom(nom);
            entreprise.setAdresse(adresse);
            entreprise.setEmailContact(emailContact);
            entreprise.setTelephone(telephone);

            entrepriseService.creerEntreprise(entreprise);
            response.sendRedirect(request.getContextPath() + "/entreprises");
        }
    }
}
