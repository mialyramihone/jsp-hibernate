package com.affectemploie.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.affectemploie.model.Affectation;

//
//import org.hibernate.Session;
//import org.hibernate.SessionFactory;
//import org.hibernate.query.Query;




public class AffectationDAO {

    private static String jdbcURL = "jdbc:mysql://localhost:3306/affectation";
    private static String jdbcUsername = "root";
    private static String jdbcPassword = "";

    private static final String SELECT_ALL_AFFECTATIONS = "SELECT * FROM affecter ORDER BY date DESC";
    private static final String INSERT_AFFECTATION = "INSERT INTO affecter (codeemp, codelieu, date) VALUES (?, ?, ?)";
    private static final String UPDATE_AFFECTATION = "UPDATE affecter SET codeemp = ?, codelieu = ?, date = ? WHERE codeemp = ? AND codelieu = ?";
    private static final String DELETE_AFFECTATION = "DELETE FROM affecter WHERE codeemp = ? AND codelieu = ?";
    private static final String SELECT_AFFECTATION_BY_EMPLOYEE = "SELECT * FROM affecter WHERE codeemp = ?";
    private static final String SELECT_AFFECTATION_BY_EMPLOYEE_AND_LOCATION = "SELECT * FROM affecter WHERE codeemp = ? AND codelieu = ?";

    protected static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // JDBC driver
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }

    public List<Affectation> getAllAffectations() {
        List<Affectation> affectations = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_AFFECTATIONS);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String codeemp = rs.getString("codeemp");
                String codelieu = rs.getString("codelieu");
                Date date = rs.getDate("date");
                affectations.add(new Affectation(codeemp, codelieu, date));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return affectations;
    }

    public boolean ajouterAffectation(Affectation affectation) throws SQLException {
        // Vérification des paramètres NULL
        if(affectation.getCodeemp() == null || affectation.getCodelieu() == null || affectation.getDate() == null) {
            throw new IllegalArgumentException("Les paramètres ne peuvent pas être null");
        }

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_AFFECTATION)) {
            
            stmt.setString(1, affectation.getCodeemp());
            stmt.setString(2, affectation.getCodelieu());
            stmt.setDate(3, new java.sql.Date(affectation.getDate().getTime()));

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean modifierAffectation(String originalCodeemp, String originalCodelieu, Affectation newAffectation) {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_AFFECTATION)) {

            stmt.setString(1, newAffectation.getCodeemp());
            stmt.setString(2, newAffectation.getCodelieu());
            stmt.setDate(3, new java.sql.Date(newAffectation.getDate().getTime()));
            stmt.setString(4, originalCodeemp);
            stmt.setString(5, originalCodelieu);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean supprimerAffectation(String codeemp, String codelieu) {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_AFFECTATION)) {

            stmt.setString(1, codeemp);
            stmt.setString(2, codelieu);

            int rowsDeleted = stmt.executeUpdate();
            System.out.println(rowsDeleted + " affectation(s) supprimée(s).");
            return rowsDeleted > 0;

        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression de l'affectation.");
            e.printStackTrace();
            return false;
        }
    }



    public boolean deleteAffectationsByEmploye(String codeEmploye) {
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM affecter WHERE codeemp = ?")) {
            
            ps.setString(1, codeEmploye);
            int rowsAffected = ps.executeUpdate();
            System.out.println(rowsAffected + " affectation(s) supprimée(s) pour l'employé " + codeEmploye);
            return true;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression des affectations pour l'employé " + codeEmploye);
            e.printStackTrace();
            return false;
        }
    }


    
    public Affectation getAffectation(String codeemp, String codelieu) {
        Affectation affectation = null;
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_AFFECTATION_BY_EMPLOYEE_AND_LOCATION)) {

            stmt.setString(1, codeemp);
            stmt.setString(2, codelieu);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String codeempResult = rs.getString("codeemp");
                String codelieuResult = rs.getString("codelieu");
                Date date = rs.getDate("date");
                affectation = new Affectation(codeempResult, codelieuResult, date);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return affectation;
    }

    public Affectation getAffectationByEmployee(String codeemp) {
        Affectation affectation = null;
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_AFFECTATION_BY_EMPLOYEE)) {

            stmt.setString(1, codeemp);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String codeempResult = rs.getString("codeemp");
                String codelieuResult = rs.getString("codelieu");
                Date date = rs.getDate("date");
                affectation = new Affectation(codeempResult, codelieuResult, date);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return affectation;
    }
    
    
    
    public List<Object[]> getDernieresAffectationsCompletes() {
        List<Object[]> resultats = new ArrayList<>();
        String sql = "SELECT e.codeemp, e.nom, e.prenom, e.poste, " +
                    "l.codelieu, l.designation, l.province, a.date " +
                    "FROM affecter a " +
                    "JOIN employe e ON a.codeemp = e.codeemp " +
                    "JOIN lieu l ON a.codelieu = l.codelieu " +
                    "ORDER BY a.date DESC LIMIT 10";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Object[] ligne = new Object[8];
                ligne[0] = rs.getString("codeemp");
                ligne[1] = rs.getString("nom");
                ligne[2] = rs.getString("prenom");
                ligne[3] = rs.getString("poste");
                ligne[4] = rs.getString("codelieu");
                ligne[5] = rs.getString("designation");
                ligne[6] = rs.getString("province");
                ligne[7] = rs.getDate("date");
                resultats.add(ligne);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultats;
    }

    public List<Map<String, String>> getAffectationsDetails() {
        List<Map<String, String>> affectationsDetails = new ArrayList<>();
        
        // Utilisez la requête SQL qui correspond à votre schéma de base de données
        String sql = "SELECT a.codeemp, e.nom, e.prenom, e.poste, " +
                     "a.codelieu, l.designation, l.province, a.date " +
                     "FROM affecter a " +
                     "JOIN employe e ON a.codeemp = e.codeemp " +
                     "JOIN lieu l ON a.codelieu = l.codelieu " +
                     "ORDER BY  a.codeemp ASC, a.date DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, String> affectationMap = new HashMap<>();
                
                // Détails de l'employé
                affectationMap.put("code_employe", rs.getString("codeemp"));
                affectationMap.put("nom", rs.getString("nom"));
                affectationMap.put("prenoms", rs.getString("prenom")); // Note: "prenom" dans la requête mais "prenoms" dans la map
                affectationMap.put("poste", rs.getString("poste"));
                
                // Détails du lieu
                affectationMap.put("code_lieu", rs.getString("codelieu"));
                affectationMap.put("designation", rs.getString("designation"));
                affectationMap.put("province", rs.getString("province"));
                
                // Date d'affectation
                affectationMap.put("date", rs.getDate("date").toString());
                
                affectationsDetails.add(affectationMap);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Vous pourriez logger cette erreur ou la relancer
        }
        
        return affectationsDetails;
    }
    public int getNombreAffectations() {
        return compter("SELECT COUNT(*) FROM affecter");
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
