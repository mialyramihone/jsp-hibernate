package com.affectemploie.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.affectemploie.model.Employe;

public class EmployeDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/affectation";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String SELECT_ALL_EMPLOYES = "SELECT * FROM employe";
    private static final String INSERT_EMPLOYE = "INSERT INTO employe (codeemp, nom, prenom, poste) VALUES (?, ?, ?, ?)";
    private static final String UPDATE_EMPLOYE = "UPDATE employe SET nom=?, prenom=?, poste=? WHERE codeemp=?";
    private static final String DELETE_EMPLOYE = "DELETE FROM employe WHERE codeemp=?";
    private static final String SELECT_EMPLOYE_BY_CODE = "SELECT * FROM employe WHERE codeemp=?";
    private static final String SEARCH_EMPLOYES = "SELECT * FROM employe WHERE LOWER(codeemp) LIKE LOWER(?) OR "
                                                + "LOWER(nom) LIKE LOWER(?) OR "
                                                + "LOWER(prenom) LIKE LOWER(?) OR "
                                                + "LOWER(poste) LIKE LOWER(?)";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (Exception e) {
            System.err.println("Erreur de connexion à la base de données: " + e.getMessage());
        }
        return connection;
    }

    public List<Employe> getAllEmployes() {
        List<Employe> employes = new ArrayList<>();
        
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_ALL_EMPLOYES);
             ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                employes.add(new Employe(
                    resultSet.getString("codeemp"),
                    resultSet.getString("nom"),
                    resultSet.getString("prenom"),
                    resultSet.getString("poste")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des employés: " + e.getMessage());
        }
        return employes;
    }

    public boolean ajouterEmploye(Employe employe) {
        System.out.println("Ajout de l'employé: " + employe.getNom());
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_EMPLOYE)) {
            
            stmt.setString(1, employe.getCodeemp());
            stmt.setString(2, employe.getNom());
            stmt.setString(3, employe.getPrenom());
            stmt.setString(4, employe.getPoste());
            
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'ajout de l'employé: " + e.getMessage());
            return false;
        }
    }

    public boolean modifierEmploye(Employe employe) {
        System.out.println("Modification de l'employé: " + employe.getCodeemp());
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_EMPLOYE)) {
            
            stmt.setString(1, employe.getNom());
            stmt.setString(2, employe.getPrenom());
            stmt.setString(3, employe.getPoste());
            stmt.setString(4, employe.getCodeemp());
            
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la modification de l'employé: " + e.getMessage());
            return false;
        }
    }

    public Employe getEmployeByCode(String codeemp) {
        Employe employe = null;
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_EMPLOYE_BY_CODE)) {
            
            stmt.setString(1, codeemp);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    employe = new Employe(
                        codeemp,
                        rs.getString("nom"),
                        rs.getString("prenom"),
                        rs.getString("poste")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération de l'employé: " + e.getMessage());
        }
        return employe;
    }

    public boolean supprimerEmploye(String codeemp) {
        System.out.println("Suppression de l'employé: " + codeemp);
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_EMPLOYE)) {
            
            stmt.setString(1, codeemp);
            
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression de l'employé: " + e.getMessage());
            return false;
        }
    }

    public List<Employe> searchEmployes(String term) {
        List<Employe> results = new ArrayList<>();
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SEARCH_EMPLOYES)) {
            
            String searchTerm = "%" + term.toLowerCase() + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);
            stmt.setString(4, searchTerm);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    results.add(new Employe(
                        rs.getString("codeemp"),
                        rs.getString("nom"),
                        rs.getString("prenom"),
                        rs.getString("poste")
                    ));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche d'employés: " + e.getMessage());
        }
        return results;
    }
    
    public int getNombreEmployes() {
        return compter("SELECT COUNT(*) FROM employe");
    }
    
    private int compter(String sql) {
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public void close() {
        
    }
}