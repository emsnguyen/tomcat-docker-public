package com.example;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/registerServlet")
public class Register extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("register.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String contact = request.getParameter("contact");


        try {
            Connection con = DBManager.getConnection();

            if (con != null) {
                System.out.println("Connected to the database.");
                PreparedStatement ps = con.prepareStatement("INSERT INTO user (name, email, password,contact) VALUES (?, ?, ?, ?)");

                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, pass);
                ps.setString(4, contact);

                int i = ps.executeUpdate();

                if (i > 0) {
                    System.out.println("Data inserted successfully.");
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("error.jsp");
                }
            } else {
                System.out.println("Failed to connect to the database.");
            }
      
        } catch (SQLException se) {
            se.printStackTrace();
        }

    }
}
