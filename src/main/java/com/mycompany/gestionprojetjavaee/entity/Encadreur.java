package com.mycompany.gestionprojetjavaee.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "encadreurs")
public class Encadreur implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String specialite;

    @Column(nullable = false)
    private String departement;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "utilisateur_id", nullable = false)
    private Utilisateur utilisateur;

    @OneToMany(mappedBy = "encadreur")
    private List<DemandeStage> sujets;

    @OneToMany(mappedBy = "encadreur")
    private List<Evaluation> evaluations;

    public Encadreur() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getSpecialite() { return specialite; }
    public void setSpecialite(String specialite) { this.specialite = specialite; }
    public String getDepartement() { return departement; }
    public void setDepartement(String departement) { this.departement = departement; }
    public Utilisateur getUtilisateur() { return utilisateur; }
    public void setUtilisateur(Utilisateur utilisateur) { this.utilisateur = utilisateur; }
    public List<DemandeStage> getSujets() { return sujets; }
    public void setSujets(List<DemandeStage> sujets) { this.sujets = sujets; }
    public List<Evaluation> getEvaluations() { return evaluations; }
    public void setEvaluations(List<Evaluation> evaluations) { this.evaluations = evaluations; }
}
