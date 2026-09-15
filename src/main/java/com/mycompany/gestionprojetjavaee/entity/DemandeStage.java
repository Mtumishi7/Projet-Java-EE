package com.mycompany.gestionprojetjavaee.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "demandes_stage")
public class DemandeStage implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String sujet;

    @Column(length = 1000)
    private String description;

    @Column(nullable = false)
    private String type = "STAGE"; // STAGE ou PFE

    private String technologies;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutDemande statut = StatutDemande.BROUILLON;

    private String nomFichierCv;

    @Column(length = 500)
    private String motifRefus;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dateCreation = new Date();

    @ManyToOne
    @JoinColumn(name = "etudiant_id", nullable = false)
    private Etudiant etudiantEntity;

    @ManyToOne
    @JoinColumn(name = "encadreur_id")
    private Encadreur encadreur;

    @ManyToOne
    @JoinColumn(name = "entreprise_id")
    private Entreprise entreprise;

    @OneToMany(mappedBy = "sujet", cascade = CascadeType.ALL)
    private List<Document> documents;

    @OneToOne(mappedBy = "sujet", cascade = CascadeType.ALL)
    private Soutenance soutenance;

    public DemandeStage() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getSujet() { return sujet; }
    public void setSujet(String sujet) { this.sujet = sujet; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getTechnologies() { return technologies; }
    public void setTechnologies(String technologies) { this.technologies = technologies; }
    public StatutDemande getStatut() { return statut; }
    public void setStatut(StatutDemande statut) { this.statut = statut; }
    public String getNomFichierCv() { return nomFichierCv; }
    public void setNomFichierCv(String nomFichierCv) { this.nomFichierCv = nomFichierCv; }
    public String getMotifRefus() { return motifRefus; }
    public void setMotifRefus(String motifRefus) { this.motifRefus = motifRefus; }
    public Date getDateCreation() { return dateCreation; }
    public void setDateCreation(Date dateCreation) { this.dateCreation = dateCreation; }
    public Etudiant getEtudiantEntity() { return etudiantEntity; }
    public void setEtudiantEntity(Etudiant etudiantEntity) { this.etudiantEntity = etudiantEntity; }
    public Encadreur getEncadreur() { return encadreur; }
    public void setEncadreur(Encadreur encadreur) { this.encadreur = encadreur; }
    public Entreprise getEntreprise() { return entreprise; }
    public void setEntreprise(Entreprise entreprise) { this.entreprise = entreprise; }
    public List<Document> getDocuments() { return documents; }
    public void setDocuments(List<Document> documents) { this.documents = documents; }
    public Soutenance getSoutenance() { return soutenance; }
    public void setSoutenance(Soutenance soutenance) { this.soutenance = soutenance; }
}
