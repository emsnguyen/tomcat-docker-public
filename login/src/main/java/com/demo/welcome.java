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

import com.demo.models.Job;
import com.demo.models.User;
@WebServlet("/user")
public class welcome extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//    	HttpSession session = request.getSession(false);
//    	if (session != null && session.getAttribute("username") != null) {
    	String action = req.getParameter("source");
    	String id = req.getParameter("id");
    	User user = getUserInfo(id);
    	if (action!=null) {
    	switch (action) {
			case "edit":
				req.setAttribute("userInfo", user);
				break;
			case "detail":
				req.setAttribute("userInfo", user);
				break;
			default:
				break;
	    	}
    	}
    	List<Job> occupations = getOccupations();
	    req.setAttribute("occupations", occupations);
	    RequestDispatcher dispatcher = req.getRequestDispatcher("add_user.jsp");
	    dispatcher.forward(req, resp);
//	    }
//    	else {
//    		response.sendRedirect("/login");
//    	}
    }
    
    public static  User getUserInfo(String id) {
    	User user = new User(0,"", 0, "", "", "");
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT user_info.id, user_info.name, user_info.age, user_info.gender, user_info.email, job.name AS job\r\n"
            		+ "FROM user_info\r\n"
            		+ "INNER JOIN job ON user_info.id_job = job.idjob\r\n"
            		+ "WHERE user_info.is_deleted = 0\r\n"
            		+ "AND user_info.id =" + id;
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                	while (resultSet.next()) {
	                	user.setId(Integer.decode(resultSet.getString("id")));
	                    user.setName(resultSet.getString("name"));
	                    user.setAge(Integer.decode(resultSet.getString("age")));
	                    user.setGender(resultSet.getString("gender"));
	                    user.setEmail(resultSet.getString("email"));
	                    user.setJob(resultSet.getString("job"));
                	}
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	String action = req.getParameter("action");
    	switch (action) {
		case "add":
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
		            String sql = "INSERT INTO user_info (name, age, gender, email, id_job) VALUES (?, ?, ?, ?, ?)";
		            try (PreparedStatement statement = conn.prepareStatement(sql)) {
		                statement.setString(1, username);
		                statement.setInt(2, age);
		                statement.setString(3, gender);
		                statement.setString(4, email);
		                int jobId = Integer.parseInt(job);
		                statement.setInt(5, jobId);
		                statement.executeUpdate();
		                popup(resp, "Insert Successfully");
		            }
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
	        }
			break;
		case "edit":
			String id = req.getParameter("userId");
			resp.sendRedirect("user?source=edit&id=" + id);
			break;
		case "save_edit":
	    	id = req.getParameter("userId");
			username = req.getParameter("name");
	    	ageString = req.getParameter("age");
	    	age = null;
	    	if (!ageString.isEmpty()) {
	    		age = Integer.decode(req.getParameter("age"));
	        }
	        gender = req.getParameter("gender");
	        email = req.getParameter("email");
	        job = req.getParameter("job");

	        if (username.isEmpty() || ageString.isEmpty() || gender.isEmpty() || email.isEmpty() || job.isEmpty()) {
	        	popup(resp, "Update Fail");
	        }
	        else {
				try (Connection conn = DatabaseConnection.getConnection()) {
		            String sql = "UPDATE user_info\r\n"
		            		+ "SET \r\n"
		            		+ "    name = ?,\r\n"
		            		+ "    age = ?,\r\n"
		            		+ "    gender = ?,\r\n"
		            		+ "    email = ?,\r\n"
		            		+ "    id_job = ?,\r\n"
		            		+ "WHERE id = " + id;
		            try (PreparedStatement statement = conn.prepareStatement(sql)) {
		                statement.setString(1, username);
		                statement.setInt(2, age);
		                statement.setString(3, gender);
		                statement.setString(4, email);
		                int jobId = Integer.parseInt(job);
		                statement.setInt(5, jobId);
		                statement.executeUpdate();
		                popup(resp, "Update Successfully");
		            }
		        } catch (SQLException e) {
		        	popup(resp, "Update Fail");
		            e.printStackTrace();
		        }
			}
			break;
		case "delete":
			String idDelete = req.getParameter("userId");
			deleteUserInfo(resp,Integer.parseInt(idDelete));
			break;
		case "cancel":
			resp.sendRedirect("home");
			break;
		default:
			break;
		}
    	
    }
    
	private void deleteUserInfo(HttpServletResponse resp, int userId) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE user_info SET is_deleted = ?  WHERE id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, 1);
            statement.setInt(2, userId);
            statement.executeUpdate();
            popup(resp,"Delete successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            popup(resp,"Delete fail");
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
		    out.println("window.location.href = 'home';");
		    out.println("</script>");
		    out.println("</body></html>");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
    }
}

