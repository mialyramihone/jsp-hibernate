package com.affectemploie.servlet;

import com.affectemploie.dao.AffectationDAO;
import com.affectemploie.model.Affectation;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/modifierAffectationServlet")
public class ModifierAffectationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String originalCodeemp = request.getParameter("originalCodeemp");
        String originalCodelieu = request.getParameter("originalCodelieu");
        String codeemp = request.getParameter("codeemp");
        String codelieu = request.getParameter("codelieu");
        String dateStr = request.getParameter("date");

        // Conversion de la date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        try {
            date = sdf.parse(dateStr);
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Format de date invalide.");
            request.getRequestDispatcher("modifierAffectation.jsp").forward(request, response);
            return;
        }

        Affectation affectation = new Affectation(codeemp, codelieu, date);
        
        AffectationDAO affectationDAO = new AffectationDAO();
        
        // Vérification si l'affectation existe déjà (si les codes ont changé)
        if (!originalCodeemp.equals(codeemp) || !originalCodelieu.equals(codelieu)) {
            Affectation existingAffectation = affectationDAO.getAffectation(codeemp, codelieu);
            if (existingAffectation != null) {
                request.setAttribute("errorMessage", "Cette affectation existe déjà.");
                request.getRequestDispatcher("affectation.jsp").forward(request, response);
                return;
            }
        }

        boolean isUpdated = affectationDAO.modifierAffectation(originalCodeemp, originalCodelieu, affectation);

        if (isUpdated) {
            response.sendRedirect("affectation.jsp");
        } else {
            request.setAttribute("errorMessage", "Erreur lors de la modification de l'affectation.");
            request.getRequestDispatcher("affectation.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codeemp = request.getParameter("codeemp");
        String codelieu = request.getParameter("codelieu");
        
        AffectationDAO affectationDAO = new AffectationDAO();
        Affectation affectation = affectationDAO.getAffectation(codeemp, codelieu);
        
        if (affectation != null) {
            request.setAttribute("affectation", affectation);
            request.getRequestDispatcher("affectation.jsp").forward(request, response);
        } else {
            response.sendRedirect("affectation.jsp");
        }
    }
}