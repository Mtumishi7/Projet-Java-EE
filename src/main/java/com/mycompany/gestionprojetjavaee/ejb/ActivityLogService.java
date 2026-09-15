package com.mycompany.gestionprojetjavaee.ejb;

import com.mycompany.gestionprojetjavaee.entity.ActivityLog;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class ActivityLogService {

    @PersistenceContext(unitName = "GestionProjetPU")
    private EntityManager em;

    public ActivityLogService() {}

    public void log(String email, String action, String details) {
        try {
            ActivityLog log = new ActivityLog(email != null ? email : "ANONYME", action, details);
            em.persist(log);
        } catch (Exception e) {
            // Ignored to prevent disrupting business flow
        }
    }

    public List<ActivityLog> listerTous() {
        return em.createQuery("SELECT l FROM ActivityLog l ORDER BY l.dateAction DESC", ActivityLog.class)
                 .getResultList();
    }
}
