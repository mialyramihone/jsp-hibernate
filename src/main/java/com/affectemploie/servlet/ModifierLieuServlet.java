package com.affectemploie.servlet;

import com.affectemploie.dao.LieuDAO;
import com.affectemploie.model.Lieu;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/modifierLieuServlet")
public class ModifierLieuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codelieu = request.getParameter("codelieu");
        String designation = request.getParameter("designation");
        String province = request.getParameter("province");

        Lieu lieu = new Lieu(codelieu, designation, province);
        
        LieuDAO lieuDAO = new LieuDAO();
        boolean isUpdated = lieuDAO.modifierLieu(lieu);

        if (isUpdated) {
            response.sendRedirect("lieu.jsp");
        } else {
            request.setAttribute("errorMessage", "Échec de la modification du lieu.");
            request.getRequestDispatcher("lieu.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codelieu = request.getParameter("codelieu");
        
        LieuDAO lieuDAO = new LieuDAO();
        Lieu lieu = lieuDAO.getLieuByCode(codelieu);
        
        if (lieu != null) {
            request.setAttribute("lieu", lieu);
            request.getRequestDispatcher("modifierLieu.jsp").forward(request, response);
        } else {
            response.sendRedirect("lieu.jsp");
        }
    }
}
