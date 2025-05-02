package com.affectemploie.servlet;

import java.io.IOException;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.affectemploie.dao.AffectationDAO;
import com.affectemploie.dao.EmployeDAO;
import com.affectemploie.dao.LieuDAO;


@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        EmployeDAO employeDAO = new EmployeDAO();
        LieuDAO lieuDAO = new LieuDAO();
        AffectationDAO affectationDAO = new AffectationDAO();
        
        // Récupérer les comptages
        int nombreEmployes = employeDAO.getNombreEmployes();
        int nombreLieux = lieuDAO.getNombreLieux();
        int nombreAffectations = affectationDAO.getNombreAffectations();
        
        // Récupérer les dernières affectations avec les détails des employés et lieux
        List<Map<String, String>> affectationsDetails = affectationDAO.getAffectationsDetails();
        
        // Passer les attributs à la JSP
        request.setAttribute("nombreEmployes", nombreEmployes);
        request.setAttribute("nombreLieux", nombreLieux);
        request.setAttribute("nombreAffectations", nombreAffectations);
        request.setAttribute("affectations", affectationsDetails);
        
        // Rediriger vers la JSP
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}