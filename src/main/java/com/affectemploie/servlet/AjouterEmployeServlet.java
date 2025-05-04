package com.affectemploie.servlet;

import com.affectemploie.dao.EmployeDAO;
import com.affectemploie.model.Employe;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/ajouterEmployeServlet")
public class AjouterEmployeServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codeemp = request.getParameter("codeemp");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String poste = request.getParameter("poste");

        Employe employe = new Employe(codeemp, nom, prenom, poste);
        
        EmployeDAO employeDAO = new EmployeDAO();
        boolean isAdded = employeDAO.ajouterEmploye(employe);

        if (isAdded) {
            response.sendRedirect("employe.jsp");
        } else {

            request.setAttribute("errorMessage", "Échec de l'ajout de l'employé.");
            request.getRequestDispatcher("employe.jsp").forward(request, response);
        }
    }
}

