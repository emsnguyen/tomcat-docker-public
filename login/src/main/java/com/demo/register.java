package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class register extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String username = request.getParameter("username");
        String password = request.getParameter("password");
        if (CheckUserName(username)==0) {
	        try (Connection conn = DatabaseConnection.getConnection()) {
	            String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
	            try (PreparedStatement statement = conn.prepareStatement(sql)) {
	                statement.setString(1, username);
	                statement.setString(2, password);
	                statement.executeUpdate();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        response.sendRedirect("/login");
        }
        else {
        	String mail = request.getParameter("contact");
            String name = request.getParameter("name");
    		request.setAttribute("userExist", 1);
    		request.setAttribute("name", name);
    		request.setAttribute("mail", mail);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    public int CheckUserName(String UserName) {
    	try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT COUNT(*) as total FROM users where userName = ?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, UserName);
                ResultSet resultSet = statement.executeQuery();
                int total = 0;
                while (resultSet.next()) {
                	total = resultSet.getInt("total");
                }
                return total;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
}

