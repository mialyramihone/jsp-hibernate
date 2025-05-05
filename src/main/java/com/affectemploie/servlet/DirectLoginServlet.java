package com.affectemploie.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Version du servlet de connexion sans annotation @WebServlet.
 * Cette classe est configurée directement dans web.xml.
 */
public class DirectLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    private static final String DEFAULT_USERNAME = "admin";
    private static final String DEFAULT_PASSWORD = "admin123";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");


        if (DEFAULT_USERNAME.equals(username) && DEFAULT_PASSWORD.equals(password)) {

            HttpSession session = request.getSession();
            session.setAttribute("username", username);


            response.sendRedirect("index.jsp");
        } else {

            response.sendRedirect("login.jsp?error=1");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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