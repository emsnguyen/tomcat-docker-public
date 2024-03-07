package com.example;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
   
    private static final long serialVersionUID = 1L;       
   
    public LoginServlet() {
        super();
    }
   
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBManager.getConnection();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement("SELECT * FROM user WHERE email = ? AND password = ?");

                ps.setString(1, email);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    out.println("You are successfully registered.");
                    System.out.println("Login successfully.");

                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("email", email);
                    response.sendRedirect("/my-tomcat-app/home");
                }
                else {
                    out.println("User not found.");
                    System.out.println("Login failed: User not found.");
                    response.sendRedirect("error.jsp");
                }
            }
            else {
                System.out.println("Connection failed");
                response.sendRedirect("error.jsp");
            }
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
}
