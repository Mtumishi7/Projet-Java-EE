package com.mycompany.gestionprojetjavaee.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "activity_logs")
public class ActivityLog implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String utilisateurEmail;

    @Column(nullable = false)
    private String action;

    @Column(length = 1000)
    private String details;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false)
    private Date dateAction = new Date();

    public ActivityLog() {}

    public ActivityLog(String utilisateurEmail, String action, String details) {
        this.utilisateurEmail = utilisateurEmail;
        this.action = action;
        this.details = details;
        this.dateAction = new Date();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getUtilisateurEmail() { return utilisateurEmail; }
    public void setUtilisateurEmail(String utilisateurEmail) { this.utilisateurEmail = utilisateurEmail; }
    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }
    public String getDetails() { return details; }
    public void setDetails(String details) { this.details = details; }
    public Date getDateAction() { return dateAction; }
    public void setDateAction(Date dateAction) { this.dateAction = dateAction; }
}
