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

import com.demo.models.Job;
import com.demo.models.User;

@WebServlet("/search")
public class searchServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<User> lstUser = getUserInfo();
		req.setAttribute("userList", lstUser);
		List<Job> occupations = getOccupations();
		req.setAttribute("occupations", occupations);
	    RequestDispatcher dispatcher = req.getRequestDispatcher("search.jsp");
	    dispatcher.forward(req, resp);
	}

	public static  List<User> getUserInfo() {
    	List<User> lstUser = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT user_info.id, user_info.name, user_info.age, user_info.gender, user_info.email, job.name AS job\r\n"
            		+ "            		FROM user_info\r\n"
            		+ "            		INNER JOIN job ON user_info.id_job = job.idjob\r\n"
            		+ "                 where user_info.is_deleted = 0";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                    	User user = new User(0,"", "", 0, "", "");
                    	user.setId(Integer.decode(resultSet.getString("id")));
                        user.setName(resultSet.getString("name"));
                        user.setAge(Integer.decode(resultSet.getString("age")));
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
	
	private void deleteUserInfo(int userId) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE user_info SET is_deleted = ?  WHERE id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, 1);
            statement.setInt(2, userId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	
	public List<User> searchUserList(String name, int age, String gender, String email, int jobId) {
        List<User> searchResults = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
        	conn = DatabaseConnection.getConnection();
            
            StringBuilder sql = new StringBuilder("SELECT *, job.name AS job \r\n"
            		+ "FROM java_login.user_info\r\n"
            		+ "INNER JOIN job ON user_info.id_job = job.idjob\r\n"
            		+ "where user_info.is_deleted = 0");
            if (!name.isEmpty()) {
                sql.append(" AND user_info.name LIKE ?");
            }
            if (age > 0) {
                sql.append(" AND user_info.age = ?");
            }
            if (!gender.isEmpty()) {
                sql.append(" AND user_info.gender = ?");
            }
            if (!email.isEmpty()) {
                sql.append(" AND user_info.email LIKE ?");
            }
            if (jobId > 0) {
                sql.append(" AND user_info.id_job = ?");
            }
            
            stmt = conn.prepareStatement(sql.toString());
            int parameterIndex = 1;
            if (!name.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + name + "%");
            }
            if (age > 0) {
                stmt.setInt(parameterIndex++, age);
            }
            if (!gender.isEmpty()) {
                stmt.setString(parameterIndex++, gender);
            }
            if (!email.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + email + "%");
            }
            if (jobId > 0) {
                stmt.setInt(parameterIndex++, jobId);
            }
            rs = stmt.executeQuery();
            
            while (rs.next()) {
            	User user = new User(0,"", "", 0, "", "");
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setAge(rs.getInt("age"));
                user.setGender(rs.getString("gender"));
                user.setEmail(rs.getString("email"));
                user.setJob(rs.getString("job"));
                searchResults.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return searchResults;
    }
	
	public static List<Job> getOccupations() {
        List<Job> occupations = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM job";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                    	Job occupation = new Job(0,"");
                    	occupation.setIdJob(resultSet.getInt("idjob"));
                    	occupation.setName(resultSet.getString("name"));
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String formType = request.getParameter("formType");

	    if ("formSearch".equals(formType)) {
	    	String name = request.getParameter("name");
	    	String ageParameter = request.getParameter("age");
	    	int age = 0;
	    	if (ageParameter != null && !ageParameter.isEmpty()) {
	    	    age = Integer.parseInt(ageParameter);
	    	}
	        String gender = request.getParameter("gender");
	        String email = request.getParameter("email");
	        String jobParameter = request.getParameter("job");
	        int jobId = 0; 
	        if (!jobParameter.isEmpty()) {
	        	jobId = Integer.parseInt(request.getParameter("job"));
	        }
	        
	        List<User> searchResults = searchUserList(name, age, gender, email, jobId);
	        
	        request.setAttribute("searchResults", searchResults);
	        request.getRequestDispatcher("search.jsp").forward(request, response);
	    } else if ("formTable".equals(formType)) {
	    	String action = request.getParameter("action");
		    if ("add".equals(action)) {
		    	 response.sendRedirect("welcome");
		    } else if ("edit".equals(action)) {
		    	 response.sendRedirect("search");
		    } else if ("delete".equals(action)) {
		    	String[] selectedIds = request.getParameterValues("selectedIds");
	    	    if (selectedIds != null && selectedIds.length > 0) {
	    	        for (String id : selectedIds) {
	    	            int userId = Integer.parseInt(id);
	    	            deleteUserInfo(userId);
	    	        }
	    	    } else {
	    	    }
		    	response.sendRedirect("search");
		    } else {
		    	 response.sendRedirect("search");
		    }
	    } else {
	    	 response.sendRedirect("search");
	    }
	}
}
