package com.example.Controller.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.sql.Connection;

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
            int job_id = Integer.parseInt(request.getParameter("job_id"));
            int age = Integer.parseInt(request.getParameter("age"));

            User newUser = new User();
            newUser.setName(name);
            newUser.setEmail(email);
            newUser.setPassword("password");
            newUser.setContact(contact);
            newUser.setGender(gender);
            newUser.setJob_id(job_id);
            newUser.setAge(age);
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
            boolean gender = "1".equals(request.getParameter("gender"));
            int job_id = Integer.parseInt(request.getParameter("job_id"));
            int age = Integer.parseInt(request.getParameter("age"));
            User updateUser = new User();

            updateUser.setId(userId);
            updateUser.setName(name);
            updateUser.setEmail(email);
            updateUser.setPassword("password");
            updateUser.setContact(contact);
            updateUser.setGender(gender);
            updateUser.setJob_id(job_id);
            updateUser.setAge(age);
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
            int userId = Integer.parseInt(request.getParameter("id"));
            User deleteUser = new User();
            deleteUser.setDeleted_by(currentUser);
            userDao.deleteUser(userId);
        }

        response.sendRedirect("/my-tomcat-app/home");
    }

}
