package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demo.models.User;

@WebServlet("/search")
public class searchServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<User> lstUser = getUserInfo();
		req.setAttribute("userList", lstUser);
	    RequestDispatcher dispatcher = req.getRequestDispatcher("search.jsp");
	    dispatcher.forward(req, resp);
	}

	public static  List<User> getUserInfo() {
    	List<User> lstUser = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT user_info.id, user_info.name, user_info.age, user_info.gender, user_info.email, job.name AS job\r\n"
            		+ "FROM user_info\r\n"
            		+ "INNER JOIN job ON user_info.id_job = job.idjob;";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                    	User user = new User("", "", 0, "", "");
                        user.setName(resultSet.getString("name"));
                        Integer age = null;
                    	age = Integer.decode(resultSet.getString("age"));
                        user.setAge(age);
                        user.setGender(resultSet.getString("gender"));
                        user.setEmail(resultSet.getString("email"));
                        user.setJob(resultSet.getString("job"));
                        lstUser.add(user);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lstUser;
    }

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String formType = request.getParameter("formType");

	    if ("formSearch".equals(formType)) {
	    	 response.sendRedirect("search");
	    } else if ("formTable".equals(formType)) {
	    	String action = request.getParameter("action");
		    if ("add".equals(action)) {
		    	 response.sendRedirect("welcome");
		    } else if ("edit".equals(action)) {
		    	 response.sendRedirect("search");
		    } else if ("delete".equals(action)) {
		    	 response.sendRedirect("search");
		    } else {
		    	 response.sendRedirect("search");
		    }
	    } else {
	    	 response.sendRedirect("search");
	    }
	}
}
