package com.example;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); 

        if (session != null && session.getAttribute("email") != null) {
            String userEmail = (String) session.getAttribute("email");
            System.out.println("User email: " + userEmail);
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}

