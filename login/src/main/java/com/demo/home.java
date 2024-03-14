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

@WebServlet("/home")
public class home extends HttpServlet {
	public int searchTotal = 0;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int recordsPerPage = 5;
        int currentPage = 1; 
        String currentPageParam = req.getParameter("currentPage");
        if (currentPageParam != null && !currentPageParam.isEmpty()) {
            currentPage = Integer.parseInt(currentPageParam);
        }
        int start = currentPage * recordsPerPage - recordsPerPage;
		List<User> lstUser = getUserInfo(start, recordsPerPage);
		int totalRecords = getTotalRecords();
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
		
		req.setAttribute("userList", lstUser);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("totalRecords", totalRecords);
		req.setAttribute("currentPage", currentPage);
		List<Job> occupations = getOccupations();
		req.setAttribute("occupations", occupations);
	    RequestDispatcher dispatcher = req.getRequestDispatcher("home.jsp");
	    dispatcher.forward(req, resp);
	}

	public static  List<User> getUserInfo(int start, int recordsPerPage) {
    	List<User> lstUser = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT user_info.id, user_info.name, user_info.age, user_info.gender, user_info.email, job.name AS job\r\n"
            		+ "FROM user_info\r\n"
            		+ "INNER JOIN job ON user_info.id_job = job.idjob\r\n"
            		+ "WHERE user_info.is_deleted = 0\r\n"
            		+ "ORDER BY user_info.update_date DESC\r\n"
            		+ "LIMIT ?,? ";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
            	statement.setInt(1, start);
            	statement.setInt(2, recordsPerPage);
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                    	User user = new User(0,"", 0, "", "", "");
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
	
	public static int getTotalRecords() {
        int totalRecords = 0;
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM user_info WHERE user_info.is_deleted = 0")) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalRecords = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRecords;
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
	
	public List<User> searchUserList(int start, int recordsPerPage, String name, int ageForm, int ageTo, String gender, String email, int jobId) {
        List<User> searchResults = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        PreparedStatement stmtCount = null;
        ResultSet rs = null;
        
        try {
        	conn = DatabaseConnection.getConnection();
        	StringBuilder sqlCount = new StringBuilder("SELECT COUNT(*) AS total FROM user_info WHERE user_info.is_deleted = 0 ");
        	StringBuilder sql = new StringBuilder("SELECT user_info.id, user_info.name, user_info.age, user_info.gender, user_info.email, job.name AS job\r\n"
            		+ "FROM user_info\r\n"
            		+ "INNER JOIN job ON user_info.id_job = job.idjob\r\n"
            		+ "WHERE user_info.is_deleted = 0 ");
            if (!name.isEmpty()) {
                sql.append(" AND user_info.name LIKE ? ");
                sqlCount.append(" AND user_info.name LIKE ? ");
            }
            if (ageForm > 0) {
                sql.append(" AND user_info.age > ? ");
                sqlCount.append(" AND user_info.age > ? ");
            }
            if (ageTo > 0) {
                sql.append(" AND user_info.age < ? ");
                sqlCount.append(" AND user_info.age < ? ");
            }
            if (!gender.isEmpty()) {
                sql.append(" AND user_info.gender = ? ");
                sqlCount.append(" AND user_info.gender = ? ");
            }
            if (!email.isEmpty()) {
                sql.append(" AND user_info.email LIKE ? ");
                sqlCount.append(" AND user_info.email LIKE ? ");
            }
            if (jobId > 0) {
                sql.append(" AND user_info.id_job = ? \r\n");
                sqlCount.append(" AND user_info.id_job = ? \r\n");
            }
            sql.append("ORDER BY user_info.update_date DESC \r\n"
            		+ "LIMIT ?,? ");
            stmt = conn.prepareStatement(sql.toString());
            stmtCount = conn.prepareStatement(sqlCount.toString());
            int parameterIndex = 1;
            int parameterIndex2 = 1;
            if (!name.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + name + "%");
                stmtCount.setString(parameterIndex2++, "%" + name + "%");
            }
            if (ageForm > 0) {
                stmt.setInt(parameterIndex++, ageForm);
                stmtCount.setInt(parameterIndex2++, ageForm);
            }
            if (ageTo > ageForm) {
                stmt.setInt(parameterIndex++, ageTo);
                stmtCount.setInt(parameterIndex2++, ageTo);
            }
            if (!gender.isEmpty()) {
                stmt.setString(parameterIndex++, gender);
                stmtCount.setString(parameterIndex2++, gender);
            }
            if (!email.isEmpty()) {
                stmt.setString(parameterIndex++, "%" + email + "%");
                stmtCount.setString(parameterIndex2++, "%" + email + "%");
            }
            if (jobId > 0) {
                stmt.setInt(parameterIndex++, jobId);
                stmtCount.setInt(parameterIndex2++, jobId);
            }
            stmt.setInt(parameterIndex++, start);
            stmt.setInt(parameterIndex++, recordsPerPage);
            rs = stmt.executeQuery();
            ResultSet rsCount = stmtCount.executeQuery();
            while (rsCount.next()) {
            	searchTotal = rsCount.getInt("total");
            }
            while (rs.next()) {
            	User user = new User(0,"", 0, "", "", "");
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

		String name = request.getParameter("name");
    	String ageParameter = request.getParameter("ageForm");
    	int age = -1;
    	if (ageParameter != null && !ageParameter.isEmpty()) {
    	    age = Integer.parseInt(ageParameter);
    	}
    	String ageParameterTo = request.getParameter("ageTo");
    	int ageTo = -1;
    	if (ageParameterTo != null && !ageParameterTo.isEmpty()) {
    		ageTo = Integer.parseInt(ageParameterTo);
    	}
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String jobParameter = request.getParameter("job");
        int jobId = 0; 
        if (!jobParameter.isEmpty()) {
        	jobId = Integer.parseInt(request.getParameter("job"));
        }
        
        
        int recordsPerPage = 5;
        int currentPage = 1; 
        String currentPageParam = request.getParameter("currentPage");
        if (currentPageParam != null && !currentPageParam.isEmpty()) {
            currentPage = Integer.parseInt(currentPageParam);
        }
        int start = currentPage * recordsPerPage - recordsPerPage;
        List<User> searchResults = searchUserList(start, recordsPerPage,name, age, ageTo, gender, email, jobId);
        int totalPages = (int) Math.ceil((double) searchTotal / recordsPerPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalRecords", searchTotal);
        
        User userSearch = new User(0, name, age, gender, email, jobParameter);
        request.setAttribute("ageForm", age);
        request.setAttribute("ageTo", ageTo);
        request.setAttribute("userSearch", userSearch);
        request.setAttribute("userList", searchResults);
		List<Job> occupations = getOccupations();
		request.setAttribute("occupations", occupations);
        request.getRequestDispatcher("home.jsp").forward(request, response);
	}
}
