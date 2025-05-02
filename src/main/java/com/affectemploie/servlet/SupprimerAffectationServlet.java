package com.affectemploie.servlet;

import com.affectemploie.dao.AffectationDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/supprimerAffectationServlet")
public class SupprimerAffectationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codeemp = request.getParameter("codeemp");
        String codelieu = request.getParameter("codelieu");
        
        AffectationDAO affectationDAO = new AffectationDAO();
        boolean isDeleted = affectationDAO.supprimerAffectation(codeemp, codelieu);

        if (isDeleted) {
            response.sendRedirect("affectation.jsp");
        } else {
            request.setAttribute("errorMessage", "Échec de la suppression de l'affectation.");
            request.getRequestDispatcher("affectation.jsp").forward(request, response);
        }
    }
}