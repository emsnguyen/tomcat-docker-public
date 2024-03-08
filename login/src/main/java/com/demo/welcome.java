package com.demo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/welcome")
public class welcome extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	//if (session.getAttribute("username") != null) {
    	List<String> occupations = getOccupations();
	    request.setAttribute("occupations", occupations);
	    RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp");
	    dispatcher.forward(request, response);
//	    }
//    	else {
//    		response.sendRedirect("/login");
//    	}
    }
    
    public static List<String> getOccupations() {
        List<String> occupations = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM job";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        String occupation = resultSet.getString("name");
                        occupations.add(occupation);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return occupations;
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	String username = req.getParameter("name");
    	String ageString = req.getParameter("age");
    	Integer age = null;
    	if (!ageString.isEmpty()) {
    		age = Integer.decode(req.getParameter("age"));
        }
        String gender = req.getParameter("gender");
        String email = req.getParameter("email");
        String job = req.getParameter("job");

        if (username.isEmpty() || ageString.isEmpty() || gender.isEmpty() || email.isEmpty() || job.isEmpty()) {
        	popup(resp, "Insert Fail");
        }
        else {
	        try (Connection conn = DatabaseConnection.getConnection()) {
	            String sql = "INSERT INTO user_info (name, age, gender, email, job) VALUES (?, ?, ?, ?, ?)";
	            try (PreparedStatement statement = conn.prepareStatement(sql)) {
	                statement.setString(1, username);
	                statement.setInt(2, age);
	                statement.setString(3, gender);
	                statement.setString(4, email);
	                statement.setString(5, job);
	                statement.executeUpdate();
	                popup(resp, "Insert Successfully");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
        }
    }
    
    public static void popup(HttpServletResponse resp, String noti) {
    	resp.setContentType("text/html");
        PrintWriter out;
		try {
			out = resp.getWriter();
			out.println("<html><head><title>Popup</title></head><body>");
		    out.println("<script>");
		    out.println("alert('"+noti+"');");
		    out.println("window.location.href = 'search';");
		    out.println("</script>");
		    out.println("</body></html>");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
    }
}

