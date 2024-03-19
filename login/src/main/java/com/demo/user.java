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
import java.sql.Timestamp;
import java.util.Date;
@WebServlet("/user")
public class user extends HttpServlet {
	String page;
	String name;
	static Date date = new Date();
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//    	HttpSession session = request.getSession(false);
//    	if (session != null && session.getAttribute("username") != null) {
    	String action = req.getParameter("source");
    	String id = req.getParameter("id");
    	page = req.getParameter("page");
    	User user = getUserInfo(id);
    	name = user.getName();
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
            String sql = "SELECT user_info.id, user_info.name, user_info.age, user_info.gender, user_info.email, user_info.update_date, job.name AS job\r\n"
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
	                    Timestamp timestamp = resultSet.getTimestamp("update_date");
	                    date = new Date(timestamp.getTime());
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
	        	if(CheckEmail(email)==0) {
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
	        	else {
		        	resp.sendRedirect("user?source=add&username="+username+"&age="+age+"&gender="+gender+"&email="+email+"&job="+job+"&emailExist=true");
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
	        	try {
	        		User newData = new User(Integer.parseInt(id),
	        								username,
	        								age,
	        								gender,
	        								email,
	        								job);
	                Date lastUpdate = getLastUpdateById(Integer.parseInt(id));
	                if (lastUpdate != null && lastUpdate.equals(date)) {
	                    boolean success = updateRecord(Integer.parseInt(id), newData);
	                    if (success) {
	                    	popup(resp, "Insert Successfully");
	                    } else {
	                    	popup(resp, "Insert fail");
	                    }
	                } else {
	                	resp.setContentType("text/html");
                        PrintWriter out;
                		try {
                			out = resp.getWriter();
                			out.println("<html><head><title>Popup</title></head><body>");
                		    out.println("<script>");
                		    out.println("alert('The record was updated while you are editing. Please reload!');");
                		    out.println("window.location.href = 'user?source=edit&id="+id+"';");
                		    out.println("</script>");
                		    out.println("</body></html>");
                		} catch (IOException e) {
                			e.printStackTrace();
                		}
	                }
	            } catch (SQLException e) {
	                e.printStackTrace();
	                popup(resp, "Update Fail");
	            }
			}
			break;
		case "delete":
			try {
				id = req.getParameter("userId");
				Date lastUpdate = getLastUpdateById(Integer.parseInt(id));
	            if (lastUpdate != null && lastUpdate.equals(date)) {
	            	resp.setContentType("text/html;charset=UTF-8");
	    	        PrintWriter out = resp.getWriter();
	    	        out.println("<html><body>");
	    	        out.println("<script>");
	    	        out.println("var confirmResult = confirm('Are you sure you want to delete user with name " +name+" ');");
	    	        out.println("if (confirmResult) {");
	    	        out.println("    window.location.href = 'deleteUser?id=" + id + "';"); 
	    	        out.println("}");
	    	        out.println("else{");
	    	        out.println("    window.location.href = 'user?source=detail&id=" + id + "&page=" + page +"';"); 
	    	        out.println("}");
	    	        out.println("</script>");
	    	        out.println("</body></html>");
	    	        out.close();
	            } else {
	            	resp.setContentType("text/html");
	                PrintWriter out;
	        		try {
	        			out = resp.getWriter();
	        			out.println("<html><head><title>Popup</title></head><body>");
	        		    out.println("<script>");
	        		    out.println("alert('The record was updated while you are editing. Please reload!');");
	        		    out.println("window.location.href = 'user?source=detail&id="+id+ "&page=" + page +"';");
	        		    out.println("</script>");
	        		    out.println("</body></html>");
	        		} catch (IOException e) {
	        			e.printStackTrace();
	        		}
	            }
			} catch (Exception e) {
				e.printStackTrace();
			}
			
	        break;
		case "cancel":
			id = req.getParameter("userId");
			resp.sendRedirect("home?currentPage="+page+"&id=" + id);
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
    
    public int CheckEmail(String Email) {
    	try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT COUNT(*) as total FROM user_info where email = ?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, Email);
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
    
    public Date getLastUpdateById(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Date lastUpdate = null;

        try {
            conn = DatabaseConnection.getConnection();
            String query = "SELECT update_date FROM user_info WHERE id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("update_date");
                lastUpdate = new Date(timestamp.getTime());
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return lastUpdate;
    }

    public boolean updateRecord(int id, User newData) throws SQLException {
        boolean success = false;

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE `user_info`\r\n"
            		+ "SET \r\n"
            		+ "    name = ?,\r\n"
            		+ "    age = ?,\r\n"
            		+ "    gender = ?,\r\n"
            		+ "    email = ?,\r\n"
            		+ "    id_job = ?\r\n"
            		+ "WHERE id = ?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, newData.getName());
                statement.setInt(2, newData.getAge());
                statement.setString(3, newData.getGender());
                statement.setString(4, newData.getEmail());
                int jobId = Integer.parseInt(newData.getJob());
                statement.setInt(5, jobId);
                statement.setInt(6, newData.getId());
                int rowsAffected = statement.executeUpdate();
                success = rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
}

