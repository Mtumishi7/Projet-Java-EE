package com.mycompany.gestionprojetjavaee.filter;

import com.mycompany.gestionprojetjavaee.entity.Utilisateur;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthentificationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Chemins autorisés sans connexion
        boolean estPublic = path.equals("/connexion") || path.equals("/login.jsp") 
                         || path.startsWith("/resources/") || path.endsWith(".css");

        boolean estConnecte = (session != null && session.getAttribute("utilisateurConnecte") != null);

        if (!estConnecte && !estPublic) {
            res.sendRedirect(req.getContextPath() + "/connexion");
            return;
        }

        // Contrôle d'accès par rôle (RBAC)
        if (estConnecte) {
            Utilisateur user = (Utilisateur) session.getAttribute("utilisateurConnecte");
            if ("/demandes/nouvelle".equals(path) && !"ETUDIANT".equals(user.getRole())) {
                res.sendRedirect(req.getContextPath() + "/demandes");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
