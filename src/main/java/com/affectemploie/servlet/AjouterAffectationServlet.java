package com.affectemploie.servlet;

import com.affectemploie.dao.AffectationDAO;
import com.affectemploie.model.Affectation;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/ajouterAffectationServlet")
public class AjouterAffectationServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String codeemp = request.getParameter("codeemp");
            String codelieu = request.getParameter("codelieu");
            String dateStr = request.getParameter("date");

            // Validation basique
            if(codeemp == null || codelieu == null || dateStr == null) {
                throw new Exception("Tous les champs sont requis");
            }

            // Vérifier si l'affectation existe déjà
            AffectationDAO dao = new AffectationDAO();
            if(dao.getAffectation(codeemp, codelieu) != null) {
                throw new Exception("Cette affectation existe déjà");
            }

            // Conversion date
            Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
            
            // Création et sauvegarde
            Affectation nouvelleAffectation = new Affectation(codeemp, codelieu, date);
            boolean succes = dao.ajouterAffectation(nouvelleAffectation);
            
            if(succes) {
                response.sendRedirect("affectation.jsp?success=Affectation+ajoutée");
            } else {
                throw new Exception("Échec de l'ajout");
            }
            
        } catch (ParseException e) {
            response.sendRedirect("affectation.jsp?error=Format+de+date+invalide");
        } catch (Exception e) {
            response.sendRedirect("affectation.jsp?error=" + URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}