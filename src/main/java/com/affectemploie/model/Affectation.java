package com.affectemploie.model;

import java.util.Date;

public class Affectation {
    private String codeemp;
    private String codelieu;
    private Date date;

    public Affectation(String codeemp, String codelieu, Date date) {
        this.codeemp = codeemp;
        this.codelieu = codelieu;
        this.date = date;
    }

    public String getCodeemp() { return codeemp; }
    public String getCodelieu() { return codelieu; }
    public Date getDate() { return date; }
}
