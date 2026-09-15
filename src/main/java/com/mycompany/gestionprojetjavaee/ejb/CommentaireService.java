package com.mycompany.gestionprojetjavaee.ejb;

import com.mycompany.gestionprojetjavaee.entity.Commentaire;
import com.mycompany.gestionprojetjavaee.entity.DemandeStage;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class CommentaireService {

    @PersistenceContext(unitName = "GestionProjetPU")
    private EntityManager em;

    public CommentaireService() {}

    public void ajouterCommentaire(Long demandeId, String email, String message) {
        DemandeStage demande = em.find(DemandeStage.class, demandeId);
        if (demande != null) {
            Commentaire c = new Commentaire();
            c.setDemande(demande);
            c.setAuteurEmail(email);
            c.setMessage(message);
            em.persist(c);
        }
    }

    public List<Commentaire> listerParDemande(Long demandeId) {
        return em.createQuery("SELECT c FROM Commentaire c WHERE c.demande.id = :demandeId ORDER BY c.dateCreation ASC", Commentaire.class)
                 .setParameter("demandeId", demandeId)
                 .getResultList();
    }
}
