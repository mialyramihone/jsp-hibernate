package com.affectemploie.model;

public class Employe {
    private String codeemp;
    private String nom;
    private String prenom;
    private String poste;

    public Employe(String codeemp, String nom, String prenom, String poste) {
        this.codeemp = codeemp;
        this.nom = nom;
        this.prenom = prenom;
        this.poste = poste;
    }

    public String getCodeemp() { return codeemp; }
    public String getNom() { return nom; }
    public String getPrenom() { return prenom; }
    public String getPoste() { return poste; }
}
