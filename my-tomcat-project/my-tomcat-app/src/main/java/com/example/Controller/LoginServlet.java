package com.example.Controller;

import com.example.DAO.DBManager;
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
					String dbEmail = rs.getString("email");
					String dbPassword = rs.getString("password");

					if (email.equals(dbEmail) && password.equals(dbPassword)) {
						HttpSession httpSession = request.getSession();
						httpSession.setAttribute("email", email);
						System.out.println("Login successfully.");						
						response.sendRedirect("/my-tomcat-app/home");
					} else {
						System.out.println("Login failed: Username or password does not match.");
						response.getWriter().write("notfound");
						return;
					}
				} else {
					System.out.println("Login failed: Username or password does not match.");
					response.getWriter().write("notfound");
					return;
				}
			} else {
				System.out.println("Connection failed");
				response.sendRedirect("error.jsp");
			}
		} catch (SQLException se) {
			se.printStackTrace();
		}
	}
}
