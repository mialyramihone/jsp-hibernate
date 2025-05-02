package com.affectemploie.servlet;

import com.affectemploie.dao.LieuDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/supprimerLieuServlet")
public class SupprimerLieuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codelieu = request.getParameter("codelieu");
        
        LieuDAO lieuDAO = new LieuDAO();
        boolean isDeleted = lieuDAO.supprimerLieu(codelieu);

        if (isDeleted) {
            response.sendRedirect("lieu.jsp");
        } else {
            request.setAttribute("errorMessage", "Échec de la suppression du lieu.");
            request.getRequestDispatcher("lieu.jsp").forward(request, response);
        }
    }
}
