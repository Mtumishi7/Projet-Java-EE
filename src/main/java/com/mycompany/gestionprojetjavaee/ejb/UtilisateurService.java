package com.mycompany.gestionprojetjavaee.ejb;

import com.mycompany.gestionprojetjavaee.entity.Utilisateur;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class UtilisateurService {

    @PersistenceContext(unitName = "GestionProjetPU")
    private EntityManager em;

    public UtilisateurService() {}

    public void inscrire(Utilisateur utilisateur) {
        em.persist(utilisateur);
    }

    public Utilisateur authentifier(String email, String motDePasse) {
        try {
            return em.createQuery(
                "SELECT u FROM Utilisateur u WHERE u.email = :email AND u.motDePasse = :motDePasse", 
                Utilisateur.class)
                .setParameter("email", email)
                .setParameter("motDePasse", motDePasse)
                .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public Utilisateur trouverParId(Long id) {
        return em.find(Utilisateur.class, id);
    }

    public List<Utilisateur> listerParRole(String role) {
        return em.createQuery("SELECT u FROM Utilisateur u WHERE u.role = :role", Utilisateur.class)
                 .setParameter("role", role)
                 .getResultList();
    }

    public List<Utilisateur> listerTous() {
        return em.createQuery("SELECT u FROM Utilisateur u", Utilisateur.class).getResultList();
    }

    public void supprimer(Long id) {
        Utilisateur u = trouverParId(id);
        if (u != null) {
            em.remove(u);
        }
    }

    public void modifier(Utilisateur utilisateur) {
        Utilisateur u = em.find(Utilisateur.class, utilisateur.getId());
        if (u != null) {
            u.setEmail(utilisateur.getEmail());
            if (utilisateur.getMotDePasse() != null && !utilisateur.getMotDePasse().trim().isEmpty()) {
                u.setMotDePasse(utilisateur.getMotDePasse());
            }
            u.setNom(utilisateur.getNom());
            u.setPrenom(utilisateur.getPrenom());
            u.setRole(utilisateur.getRole());
        }
    }
}