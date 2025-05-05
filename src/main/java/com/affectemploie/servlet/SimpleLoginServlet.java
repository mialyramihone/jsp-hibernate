package com.affectemploie.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Un servlet de connexion simplifié qui utilise uniquement des identifiants statiques
 * sans dépendre d'une base de données.
 */
@WebServlet(name = "SimpleLoginServlet", urlPatterns = {"/login"})
public class SimpleLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Identifiants par défaut
    private static final String DEFAULT_USERNAME = "admin";
    private static final String DEFAULT_PASSWORD = "admin123";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Vérifier les identifiants
        if (DEFAULT_USERNAME.equals(username) && DEFAULT_PASSWORD.equals(password)) {
            // Créer une session
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            
            // Rediriger vers la page d'accueil
            response.sendRedirect("index.jsp");
        } else {
            // Rediriger vers la page de connexion avec un message d'erreur
            response.sendRedirect("login.jsp?error=1");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Pour la déconnexion ou d'autres cas GET
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}