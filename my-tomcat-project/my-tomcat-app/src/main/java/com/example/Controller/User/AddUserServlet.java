package com.example.Controller.User;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.DAO.DBManager;
import com.example.DAO.JobDAO;
import com.example.DAO.UserDAO;
import com.example.Model.Job;
import com.example.Model.User;

@WebServlet(urlPatterns = { "/user", "/user/insert", "/user/edit", "/user/update", "/user/delete", "/user/detail", })
public class AddUserServlet extends HttpServlet {
	private Connection con;
	private UserDAO userDao;
	private JobDAO jobDao;

	@Override
	public void init() throws ServletException {
		super.init();
		try {
			this.con = DBManager.getConnection();
			this.userDao = new UserDAO(con);
			this.jobDao = new JobDAO(con);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session != null && session.getAttribute("email") != null) {
			doGet(request, response);
		} else {
			response.sendRedirect("/my-tomcat-app/index.jsp");
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("email") != null) {
			String action = request.getServletPath();
			System.out.println(action);
			try {
				switch (action) {
				case "/user/edit":
					showEditForm(request, response);
					break;
				case "/user/update":
					updateUser(request, response);
					break;
				case "/user/insert":
					createUser(request, response);
					break;
				case "/user/delete":
					deleteUser(request, response);
					break;
				case "/user/detail":
					showDetailForm(request, response);
					break;
				case "/user":
					showForm(request, response);
					break;
				}
			} catch (SQLException ex) {
				ex.printStackTrace();

			}
		} else {
			response.sendRedirect("/my-tomcat-app/index.jsp");
		}
	}

	private boolean isUserExist(Connection con, String email) throws SQLException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean exist = false;
		try {
			ps = con.prepareStatement("SELECT * FROM user WHERE email = ?");
			ps.setString(1, email);
			rs = ps.executeQuery();
			if (rs.next()) {
				exist = true;
			}
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return exist;
	}



	private boolean isEdited(Connection con, int id, String updated_at) throws SQLException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean updated = false;
		try {
			ps = con.prepareStatement("SELECT updated_at FROM user WHERE id = ?");
			ps.setInt(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				Timestamp dbUpdatedAt = rs.getTimestamp("updated_at");
				Timestamp updated_at_timestamp = Timestamp.valueOf(updated_at);
				if (dbUpdatedAt.equals(updated_at_timestamp)) {
					updated = true;
				}
			}
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return updated;
	}


	private Integer parseIntegerParameter(String param) {
		if (param != null && !param.isEmpty()) {
			try {
				return Integer.parseInt(param);
			} catch (NumberFormatException e) {
				return null; 
			}
		}
		return null; 
	}


	private void showForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		List<Job> listJob = jobDao.getAllJob();
		request.setAttribute("listJob", listJob);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/user.jsp");
		dispatcher.forward(request, response);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		int userId = Integer.parseInt(request.getParameter("id"));
		User userExist = userDao.getUserById(userId);
		List<Job> listJob = jobDao.getAllJob();
		RequestDispatcher dispatcher = request.getRequestDispatcher("/user.jsp");
		request.setAttribute("userExist", userExist);
		request.setAttribute("listJob", listJob);
		dispatcher.forward(request, response);
	}

	private void showDetailForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		int userId = Integer.parseInt(request.getParameter("id"));
		User userExist = userDao.getUserById(userId);
		int jobId = userExist.getJob_id();
		String jobName = jobDao.getJobNameById(jobId);
		userExist.setJob_name(jobName);
		request.setAttribute("userExist", userExist);
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"/detail.jsp");
		dispatcher.forward(request, response);
	}

	private void createUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("email") != null) {
			request.setCharacterEncoding("UTF-8");
			String currentUser = (String) session.getAttribute("email");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String contact = request.getParameter("contact");
			boolean gender = "1".equals(request.getParameter("gender"));
			Integer job_id = parseIntegerParameter(request.getParameter("job_id"));
			Integer age = parseIntegerParameter(request.getParameter("age"));


			if (isUserExist(con, email)) {
				response.getWriter().write("exists");
				return;
			}

			User newUser = new User();
			newUser.setName(name);
			newUser.setEmail(email);
			newUser.setPassword("password");
			newUser.setContact(contact);
			newUser.setGender(gender);
			if(job_id != null && job_id > 0) {
				newUser.setJob_id(job_id);
			}
			if(age != null && age > 0 ) {
				newUser.setAge(age);
			}else {
				newUser.setAge(0);
			}

			newUser.setis_delete(false);
			newUser.setCreated_by(currentUser);

			userDao.createUser(newUser);
		}

		response.sendRedirect("/my-tomcat-app/home");
	}

	private void updateUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("email") != null) {
			String currentUser = (String) session.getAttribute("email");
			request.setCharacterEncoding("UTF-8");

			int userId = Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String contact = request.getParameter("contact");
			String updated_at = request.getParameter("updated_at");
			boolean gender = "1".equals(request.getParameter("gender"));

			Integer job_id = parseIntegerParameter(request.getParameter("job_id"));
			Integer age = parseIntegerParameter(request.getParameter("age"));


			if (isEdited(con, userId, updated_at)) {
				response.getWriter().write("updated");
				return;
			}
			User updateUser = new User();

			updateUser.setId(userId);
			updateUser.setName(name);
			updateUser.setEmail(email);
			updateUser.setPassword("password");
			updateUser.setContact(contact);

			if(job_id != null && job_id > 0) {
				updateUser.setJob_id(job_id);
			}
			if(age != null && age > 0 ) {
				updateUser.setAge(age);
			}else {
				updateUser.setAge(0);
			}
			updateUser.setGender(gender);
			updateUser.setUpdated_by(currentUser);

			userDao.updateUser(updateUser);
		}
		response.sendRedirect("/my-tomcat-app/home");
	}

	private void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("email") != null) {
			String currentUser = (String) session.getAttribute("email");
			String updated_at = request.getParameter("updated_at");
			int userId = Integer.parseInt(request.getParameter("id"));
			if (isEdited(con, userId, updated_at)) {
				response.getWriter().write("updated");
				return;
			}
			else {
				User deleteUser = new User();
				deleteUser.setDeleted_by(currentUser);
				userDao.deleteUser(userId);
			}
		}
		response.sendRedirect("/my-tomcat-app/home");
	}

}
