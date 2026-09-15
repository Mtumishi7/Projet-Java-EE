package com.mycompany.gestionprojetjavaee.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "commentaires")
public class Commentaire implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 1000)
    private String message;

    @Column(nullable = false)
    private String auteurEmail;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false)
    private Date dateCreation = new Date();

    @ManyToOne
    @JoinColumn(name = "demande_id", nullable = false)
    private DemandeStage demande;

    public Commentaire() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public String getAuteurEmail() { return auteurEmail; }
    public void setAuteurEmail(String auteurEmail) { this.auteurEmail = auteurEmail; }
    public Date getDateCreation() { return dateCreation; }
    public void setDateCreation(Date dateCreation) { this.dateCreation = dateCreation; }
    public DemandeStage getDemande() { return demande; }
    public void setDemande(DemandeStage demande) { this.demande = demande; }
}
