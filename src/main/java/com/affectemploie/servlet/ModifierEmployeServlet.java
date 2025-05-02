package com.affectemploie.servlet;

import com.affectemploie.dao.EmployeDAO;
import com.affectemploie.model.Employe;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/modifierEmployeServlet")
public class ModifierEmployeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codeemp = request.getParameter("codeemp");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String poste = request.getParameter("poste");

        Employe employe = new Employe(codeemp, nom, prenom, poste);
        
        EmployeDAO employeDAO = new EmployeDAO();
        boolean isUpdated = employeDAO.modifierEmploye(employe);

        if (isUpdated) {
            response.sendRedirect("employe.jsp");
        } else {
            // Gérer l'erreur de mise à jour
            request.setAttribute("errorMessage", "Échec de la modification de l'employé.");
            request.getRequestDispatcher("employe.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codeemp = request.getParameter("codeemp");
        
        EmployeDAO employeDAO = new EmployeDAO();
        Employe employe = employeDAO.getEmployeByCode(codeemp);
        
        if (employe != null) {
            request.setAttribute("employe", employe);
            request.getRequestDispatcher("modifierEmploye.jsp").forward(request, response);
        } else {
            response.sendRedirect("employe.jsp");
        }
    }
}