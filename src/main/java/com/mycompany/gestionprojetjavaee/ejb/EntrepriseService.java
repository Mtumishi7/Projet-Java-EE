package com.mycompany.gestionprojetjavaee.ejb;

import com.mycompany.gestionprojetjavaee.entity.Entreprise;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class EntrepriseService {

    @PersistenceContext(unitName = "GestionProjetPU")
    private EntityManager em;

    public EntrepriseService() {}

    public void creerEntreprise(Entreprise entreprise) {
        em.persist(entreprise);
    }

    public Entreprise trouverParId(Long id) {
        return em.find(Entreprise.class, id);
    }

    public List<Entreprise> listerToutes() {
        return em.createQuery("SELECT e FROM Entreprise e", Entreprise.class).getResultList();
    }
}
