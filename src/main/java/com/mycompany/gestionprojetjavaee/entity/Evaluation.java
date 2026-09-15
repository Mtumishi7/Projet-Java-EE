package com.mycompany.gestionprojetjavaee.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "evaluations")
public class Evaluation implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Double note;

    @Column(length = 1000)
    private String commentaire;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dateEvaluation = new Date();

    @ManyToOne
    @JoinColumn(name = "soutenance_id", nullable = false)
    private Soutenance soutenance;

    @ManyToOne
    @JoinColumn(name = "encadreur_id", nullable = false)
    private Encadreur encadreur;

    public Evaluation() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Double getNote() { return note; }
    public void setNote(Double note) { this.note = note; }
    public String getCommentaire() { return commentaire; }
    public void setCommentaire(String commentaire) { this.commentaire = commentaire; }
    public Date getDateEvaluation() { return dateEvaluation; }
    public void setDateEvaluation(Date dateEvaluation) { this.dateEvaluation = dateEvaluation; }
    public Soutenance getSoutenance() { return soutenance; }
    public void setSoutenance(Soutenance soutenance) { this.soutenance = soutenance; }
    public Encadreur getEncadreur() { return encadreur; }
    public void setEncadreur(Encadreur encadreur) { this.encadreur = encadreur; }
}
