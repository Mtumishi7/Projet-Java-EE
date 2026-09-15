-- ========================================================
-- Script SQL de réinitialisation et jeu de données (Gestion Stages & PFE)
-- Université Polytechnique de Gitega - BAC3 Génie Logiciel
-- ========================================================

-- Nettoyage préalable (ordre respectant les contraintes de clés étrangères)
DROP TABLE IF EXISTS evaluations CASCADE;
DROP TABLE IF EXISTS soutenances CASCADE;
DROP TABLE IF EXISTS rapports CASCADE;
DROP TABLE IF EXISTS documents CASCADE;
DROP TABLE IF EXISTS demandes_stage CASCADE;
DROP TABLE IF EXISTS etudiants CASCADE;
DROP TABLE IF EXISTS encadreurs CASCADE;
DROP TABLE IF EXISTS entreprises CASCADE;
DROP TABLE IF EXISTS utilisateurs CASCADE;

-- 1. Création des tables (si non gérées automatiquement par JPA/Hibernate)
CREATE TABLE utilisateurs (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    motDePasse VARCHAR(255) NOT NULL,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);

CREATE TABLE entreprises (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    adresse VARCHAR(255),
    emailContact VARCHAR(255),
    telephone VARCHAR(50)
);

CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    matricule VARCHAR(100) NOT NULL UNIQUE,
    filiere VARCHAR(100) NOT NULL,
    promotion VARCHAR(100) NOT NULL,
    utilisateur_id BIGINT REFERENCES utilisateurs(id)
);

CREATE TABLE encadreurs (
    id SERIAL PRIMARY KEY,
    specialite VARCHAR(255),
    departement VARCHAR(100),
    utilisateur_id BIGINT REFERENCES utilisateurs(id)
);

CREATE TABLE demandes_stage (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    sujet VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    statut VARCHAR(50) NOT NULL,
    nomFichierCv VARCHAR(255),
    etudiant_id BIGINT REFERENCES etudiants(id),
    encadreur_id BIGINT REFERENCES encadreurs(id),
    entreprise_id BIGINT REFERENCES entreprises(id)
);

-- 2. Insertion des Utilisateurs (Administrateurs, Encadreurs, Étudiants)
INSERT INTO utilisateurs (id, email, motDePasse, nom, prenom, role) VALUES 
(1, 'admin@polytechnique.bi', 'admin123', 'Ndayishimiye', 'Jean', 'ADMIN'),
(2, 'encadreur1@polytechnique.bi', 'prof123', 'Habimana', 'Pierre', 'ENSEIGNANT'),
(3, 'encadreur2@polytechnique.bi', 'prof123', 'Nkurunziza', 'Marie', 'ENSEIGNANT'),
(4, 'encadreur3@polytechnique.bi', 'prof123', 'Bizimana', 'Paul', 'ENSEIGNANT'),
(5, 'etudiant1@polytechnique.bi', 'etu123', 'Mugisha', 'Eric', 'ETUDIANT'),
(6, 'etudiant2@polytechnique.bi', 'etu123', 'Uwase', 'Diane', 'ETUDIANT'),
(7, 'etudiant3@polytechnique.bi', 'etu123', 'Niyonkuru', 'Alain', 'ETUDIANT'),
(8, 'etudiant4@polytechnique.bi', 'etu123', 'Iradukunda', 'Clarisse', 'ETUDIANT'),
(9, 'etudiant5@polytechnique.bi', 'etu123', 'Ndayizeye', 'Cedric', 'ETUDIANT'),
(10, 'etudiant6@polytechnique.bi', 'etu123', 'Hatungimana', 'Sandrine', 'ETUDIANT');

-- 3. Insertion des Entreprises partenaires
INSERT INTO entreprises (id, nom, adresse, emailContact, telephone) VALUES 
(1, 'EcoBank Burundi', 'Bujumbura, Boulevard Mwambutsa', 'contact@ecobank.bi', '+25722223344'),
(2, 'Econet Wireless', 'Bujumbura, Rohero II', 'info@econet.bi', '+25722255566'),
(3, 'ONATEL', 'Bujumbura, Centre-ville', 'support@onatel.bi', '+25722211122'),
(4, 'Brarudi S.A.', 'Bujumbura, Kanyosha', 'contact@brarudi.bi', '+25722277788'),
(5, 'Smart Burundi', 'Bujumbura, Quartier Asiatique', 'contact@smart.bi', '+25722288899');

-- 4. Insertion des Étudiants
INSERT INTO etudiants (id, matricule, filiere, promotion, utilisateur_id) VALUES 
(1, 'GL-2025-001', 'Génie Logiciel', 'BAC3 2025-2026', 5),
(2, 'GL-2025-002', 'Génie Logiciel', 'BAC3 2025-2026', 6),
(3, 'RIT-2025-003', 'Réseaux et Télécoms', 'BAC3 2025-2026', 7),
(4, 'GL-2025-004', 'Génie Logiciel', 'BAC3 2025-2026', 8),
(5, 'GL-2025-005', 'Génie Logiciel', 'BAC3 2025-2026', 9),
(6, 'RIT-2025-006', 'Réseaux et Télécoms', 'BAC3 2025-2026', 10);

-- 5. Insertion des Encadreurs
INSERT INTO encadreurs (id, specialite, departement, utilisateur_id) VALUES 
(1, 'Intelligence Artificielle & BD', 'Génie Logiciel', 2),
(2, 'Sécurité des Réseaux', 'Réseaux et Télécoms', 3),
(3, 'Génie Logiciel Avancé', 'Génie Logiciel', 4);

-- 6. Insertion des Sujets / Demandes de Stage & PFE
INSERT INTO demandes_stage (id, type, sujet, description, statut, nomFichierCv, etudiant_id, encadreur_id, entreprise_id) VALUES 
(1, 'PFE', 'Plateforme de vote électronique sécurisée par Blockchain', 'Développement d’une application de vote en ligne décentralisée.', 'SOUMISE', 'cv_eric.pdf', 1, 1, 1),
(2, 'STAGE', 'Migration d’infrastructure cloud pour la facturation', 'Optimisation et migration des serveurs de facturation sur AWS.', 'VALIDEE', 'cv_diane.pdf', 2, 2, 2),
(3, 'PFE', 'Système de gestion intelligente du trafic urbain', 'Application IoT avec capteurs connectés pour réguler les feux.', 'EN_COURS', 'cv_alain.pdf', 3, 3, 3),
(4, 'STAGE', 'Application mobile de suivi logistique', 'Application Android/iOS pour le suivi des livraisons de marchandises.', 'BROUILLON', 'cv_clarisse.pdf', 4, 1, 4),
(5, 'PFE', 'Analyse prédictive des pannes réseau par Machine Learning', 'Modèle prédictif basé sur les logs de routeurs télécoms.', 'SOUMISE', 'cv_eric2.pdf', 1, 2, 2),
(6, 'STAGE', 'Portail web de e-banking sécurisé', 'Refonte complète de l interface client pour les services bancaires en ligne.', 'EN_ATTENTE_VALIDATION', 'cv_cedric.pdf', 5, 1, 1),
(7, 'PFE', 'Système de surveillance de réseaux par sondes virtuelles', 'Analyse de trafic réseau en temps réel avec alertes automatisées.', 'BROUILLON', 'cv_sandrine.pdf', 6, 2, 5);

-- Mettre à jour les séquences PostgreSQL pour éviter les conflits d'auto-incrémentation
SELECT setval('utilisateurs_id_seq', (SELECT MAX(id) FROM utilisateurs));
SELECT setval('entreprises_id_seq', (SELECT MAX(id) FROM entreprises));
SELECT setval('etudiants_id_seq', (SELECT MAX(id) FROM etudiants));
SELECT setval('encadreurs_id_seq', (SELECT MAX(id) FROM encadreurs));
SELECT setval('demandes_stage_id_seq', (SELECT MAX(id) FROM demandes_stage));
