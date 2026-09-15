package com.mycompany.gestionprojetjavaee.ejb;

import com.mycompany.gestionprojetjavaee.entity.DemandeStage;
import com.mycompany.gestionprojetjavaee.entity.Encadreur;
import com.mycompany.gestionprojetjavaee.entity.StatutDemande;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class DemandeStageService {

    @PersistenceContext(unitName = "GestionProjetPU")
    private EntityManager em;

    public DemandeStageService() {}

    public void enregistrerBrouillon(DemandeStage demande) {
        demande.setStatut(StatutDemande.BROUILLON);
        em.persist(demande);
    }

    public void soumettreDemande(Long demandeId) {
        changerStatut(demandeId, StatutDemande.SOUMISE);
    }

    public void mettreEnAttente(Long demandeId) {
        changerStatut(demandeId, StatutDemande.EN_ATTENTE_VALIDATION);
    }

    public void validerDemande(Long demandeId) {
        changerStatut(demandeId, StatutDemande.VALIDEE);
    }

    public void refuserDemande(Long demandeId) {
        refuserDemande(demandeId, "Sujet non validé.");
    }

    public void refuserDemande(Long demandeId, String motif) {
        DemandeStage demande = em.find(DemandeStage.class, demandeId);
        if (demande != null) {
            demande.setStatut(StatutDemande.REFUSEE);
            demande.setMotifRefus(motif);
        }
    }

    public void demarrerStage(Long demandeId) {
        changerStatut(demandeId, StatutDemande.EN_COURS);
    }

    public void deposerRapport(Long demandeId) {
        changerStatut(demandeId, StatutDemande.RAPPORT_DEPOSE);
    }

    public void planifierSoutenance(Long demandeId) {
        changerStatut(demandeId, StatutDemande.SOUTENANCE_PLANIFIEE);
    }

    public void evaluerSujet(Long demandeId) {
        changerStatut(demandeId, StatutDemande.EVALUEE);
    }

    public void archiverDemande(Long demandeId) {
        changerStatut(demandeId, StatutDemande.ARCHIVEE);
    }

    public void assignerEncadreur(Long demandeId, Long encadreurId) {
        DemandeStage demande = em.find(DemandeStage.class, demandeId);
        Encadreur encadreur = em.find(Encadreur.class, encadreurId);
        if (demande != null && encadreur != null) {
            demande.setEncadreur(encadreur);
            demande.setStatut(StatutDemande.EN_ATTENTE_VALIDATION);
        }
    }

    private void changerStatut(Long demandeId, StatutDemande nouveauStatut) {
        DemandeStage demande = em.find(DemandeStage.class, demandeId);
        if (demande != null) {
            demande.setStatut(nouveauStatut);
        }
    }

    public DemandeStage trouverParId(Long id) {
        return em.find(DemandeStage.class, id);
    }

    public List<DemandeStage> listerParEtudiant(Long etudiantId) {
        return em.createQuery("SELECT d FROM DemandeStage d WHERE d.etudiantEntity.id = :etudiantId", DemandeStage.class)
                 .setParameter("etudiantId", etudiantId)
                 .getResultList();
    }

    public List<DemandeStage> listerParEncadreur(Long encadreurId) {
        return em.createQuery("SELECT d FROM DemandeStage d WHERE d.encadreur.id = :encadreurId", DemandeStage.class)
                 .setParameter("encadreurId", encadreurId)
                 .getResultList();
    }

    public List<DemandeStage> listerToutes() {
        return em.createQuery("SELECT d FROM DemandeStage d", DemandeStage.class)
                 .getResultList();
    }
}
