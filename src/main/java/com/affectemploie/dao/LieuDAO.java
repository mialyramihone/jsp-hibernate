package com.affectemploie.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.affectemploie.model.Lieu;

public class LieuDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/affectation";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String SELECT_ALL_LIEUX = "SELECT * FROM lieu";


    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // JDBC driver
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }

    public List<Lieu> getAllLieux() {
        List<Lieu> lieux = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_LIEUX)) {

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String codelieu = rs.getString("codelieu");
                String designation = rs.getString("designation");
                String province = rs.getString("province");
                lieux.add(new Lieu(codelieu, designation, province));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lieux;
    }
    
    

    
    public boolean ajouterLieu(Lieu lieu) {
        System.out.println("Ajout du lieu : " + lieu.getDesignation()); // Log pour vérifier
        try (Connection conn = getConnection()) {
            String query = "INSERT INTO lieu (codelieu, designation, province) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, lieu.getCodelieu());
            stmt.setString(2, lieu.getDesignation());
            stmt.setString(3, lieu.getProvince());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    
    public boolean modifierLieu(Lieu lieu) {
        try (Connection conn = getConnection()) {
            String query = "UPDATE lieu SET designation=?, province=? WHERE codelieu=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, lieu.getDesignation());
            stmt.setString(2, lieu.getProvince());
            stmt.setString(3, lieu.getCodelieu());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Lieu getLieuByCode(String codelieu) {
        Lieu lieu = null;
        try (Connection conn = getConnection()) {
            String query = "SELECT * FROM lieu WHERE codelieu=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, codelieu);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String designation = rs.getString("designation");
                String province = rs.getString("province");
                lieu = new Lieu(codelieu, designation, province);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lieu;
    }

    public boolean supprimerLieu(String codelieu) {
        try (Connection conn = getConnection()) {
            String query = "DELETE FROM lieu WHERE codelieu=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, codelieu);

            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    public List<Lieu> searchLieux(String term) {
        List<Lieu> results = new ArrayList<>();
        String query = "SELECT * FROM lieu WHERE designation LIKE ? OR province LIKE ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
             
            stmt.setString(1, "%" + term + "%");
            stmt.setString(2, "%" + term + "%");
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                results.add(new Lieu(
                    rs.getString("codelieu"),
                    rs.getString("designation"),
                    rs.getString("province")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }



    public int getNombreLieux() {
        return compter("SELECT COUNT(*) FROM lieu");
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