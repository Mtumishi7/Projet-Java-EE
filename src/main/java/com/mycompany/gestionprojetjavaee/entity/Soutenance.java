package com.mycompany.gestionprojetjavaee.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "soutenances")
public class Soutenance implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false)
    private Date dateSoutenance;

    @Column(nullable = false)
    private String salle;

    @OneToOne
    @JoinColumn(name = "sujet_id", nullable = false, unique = true)
    private DemandeStage sujet;

    @OneToMany(mappedBy = "soutenance")
    private List<Evaluation> evaluations;

    public Soutenance() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Date getDateSoutenance() { return dateSoutenance; }
    public void setDateSoutenance(Date dateSoutenance) { this.dateSoutenance = dateSoutenance; }
    public String getSalle() { return salle; }
    public void setSalle(String salle) { this.salle = salle; }
    public DemandeStage getSujet() { return sujet; }
    public void setSujet(DemandeStage sujet) { this.sujet = sujet; }
    public List<Evaluation> getEvaluations() { return evaluations; }
    public void setEvaluations(List<Evaluation> evaluations) { this.evaluations = evaluations; }
}
