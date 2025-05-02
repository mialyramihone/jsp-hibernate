package com.affectemploie.servlet;

import com.affectemploie.dao.LieuDAO;
import com.affectemploie.model.Lieu;


import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/ajouterLieuServlet")
public class AjouterLieuServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String codelieu = request.getParameter("codelieu");
		String designation = request.getParameter("designation");
		String province = request.getParameter("province");

		Lieu lieu = new Lieu(codelieu, designation, province);

		LieuDAO lieuDAO = new LieuDAO();
		boolean isAdded = lieuDAO.ajouterLieu(lieu);

		if (isAdded) {
		    response.sendRedirect("lieu.jsp");
		} else {
		    request.setAttribute("errorMessage", "Échec de l'ajout du lieu.");
		    request.getRequestDispatcher("lieu.jsp").forward(request, response);
		}

    }
}

