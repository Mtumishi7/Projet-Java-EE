package com.mycompany.gestionprojetjavaee.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "documents")
public class Document implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String typeDocument; // RAPPORT_INTERMEDIAIRE, RAPPORT_FINAL, AUTRE

    @Column(nullable = false)
    private String nomFichier;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dateDepot = new Date();

    @ManyToOne
    @JoinColumn(name = "sujet_id", nullable = false)
    private DemandeStage sujet;

    public Document() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTypeDocument() { return typeDocument; }
    public void setTypeDocument(String typeDocument) { this.typeDocument = typeDocument; }
    public String getNomFichier() { return nomFichier; }
    public void setNomFichier(String nomFichier) { this.nomFichier = nomFichier; }
    public Date getDateDepot() { return dateDepot; }
    public void setDateDepot(Date dateDepot) { this.dateDepot = dateDepot; }
    public DemandeStage getSujet() { return sujet; }
    public void setSujet(DemandeStage sujet) { this.sujet = sujet; }
}
