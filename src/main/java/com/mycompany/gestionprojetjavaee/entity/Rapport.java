package com.mycompany.gestionprojetjavaee.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "rapports")
public class Rapport implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String titre;

    @Column(name = "nom_fichier_pdf", nullable = false)
    private String nomFichierPdf;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "date_depot")
    private Date dateDepot = new Date();

    @OneToOne
    @JoinColumn(name = "demande_id", nullable = false, unique = true)
    private DemandeStage demande;

    public Rapport() {
    }

    public Long getId() { 
        return id; 
    }
    
    public void setId(Long id) { 
        this.id = id; 
    }

    public String getTitre() { 
        return titre; 
    }
    
    public void setTitre(String titre) { 
        this.titre = titre; 
    }

    public String getNomFichierPdf() { 
        return nomFichierPdf; 
    }
    
    public void setNomFichierPdf(String nomFichierPdf) { 
        this.nomFichierPdf = nomFichierPdf; 
    }

    public Date getDateDepot() { 
        return dateDepot; 
    }
    
    public void setDateDepot(Date dateDepot) { 
        this.dateDepot = dateDepot; 
    }

    public DemandeStage getDemande() { 
        return demande; 
    }
    
    public void setDemande(DemandeStage demande) { 
        this.demande = demande; 
    }
}