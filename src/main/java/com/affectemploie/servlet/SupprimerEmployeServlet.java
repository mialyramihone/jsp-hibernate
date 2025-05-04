package com.affectemploie.servlet;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.affectemploie.dao.AffectationDAO;
import com.affectemploie.dao.EmployeDAO;

@WebServlet("/supprimerEmployeServlet")
public class SupprimerEmployeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String codeEmploye = request.getParameter("codeemp");
        
        if (codeEmploye == null || codeEmploye.trim().isEmpty()) {
            response.sendRedirect("employe.jsp?error=invalid_input&message=Code employé manquant ou invalide");
            return;
        }

        EmployeDAO employeDAO = new EmployeDAO();
        AffectationDAO affectationDAO = new AffectationDAO();
        
        try {

            boolean affectationsDeleted = affectationDAO.deleteAffectationsByEmploye(codeEmploye);
            
            if (!affectationsDeleted) {
                System.out.println("Aucune affectation trouvée pour l'employé " + codeEmploye);
            }


            boolean employeDeleted = employeDAO.supprimerEmploye(codeEmploye);
            
            if (employeDeleted) {
                response.sendRedirect("employe.jsp?success=delete&code=" + codeEmploye);
            } else {
                response.sendRedirect("employe.jsp?error=not_found&code=" + codeEmploye + 
                                     "&message=Aucun employé trouvé avec ce code");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("employe.jsp?error=unexpected_error&code=" + codeEmploye + 
                               "&message=Erreur inattendue");
        }
    }
}