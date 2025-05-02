package com.affectemploie.model;

public class Lieu {
    private String codelieu;
    private String designation;
    private String province;


    public Lieu(String codelieu, String designation, String province) {
    	this.codelieu = codelieu;
    	this.designation = designation;
    	this.province = province;

    }

    public String getCodelieu() { return codelieu; }
    public String getDesignation() { return designation; }
    public String getProvince() { return province; }

}
