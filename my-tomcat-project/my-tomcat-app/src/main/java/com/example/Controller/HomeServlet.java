package com.example.Controller;

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

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("email") != null) {
            String action = request.getServletPath();
            System.out.println("action: " + action);

            try {
                switch (action) {
                    case "/home/insert":
                        createUser(request, response);
                        break;
                    case "/home/update":
                        updateUser(request, response);
                        break;
                    case "/home/delete":
                        deleteUser(request, response);
                        break;
                    case "/home/detail":
                        viewUser(request, response);
                        break;
                    default:
                        listUser(request, response);
                        break;
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    private void listUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<User> listUser = userDao.getAllUsers();
        List<Job> listJob = jobDao.getAllJob();
        request.setAttribute("listUser", listUser);
        request.setAttribute("listJob", listJob);
        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        dispatcher.forward(request, response);
    }

    private void createUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        int job_id = Integer.parseInt(request.getParameter("job_id"));
        int age = Integer.parseInt(request.getParameter("age"));

        User newUser = new User();
        newUser.setName(name);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setContact(contact);
        newUser.setGender(gender);
        newUser.setJob_id(job_id);
        newUser.setAge(age);

        userDao.createUser(newUser);

        response.sendRedirect("home");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        int job_id = Integer.parseInt(request.getParameter("job_id"));
        int age = Integer.parseInt(request.getParameter("age"));

        User updateUser = new User();
        updateUser.setId(userId);
        updateUser.setName(name);
        updateUser.setEmail(email);
        updateUser.setPassword(password);
        updateUser.setContact(contact);
        updateUser.setGender(gender);
        updateUser.setJob_id(job_id);
        updateUser.setAge(age);

        userDao.updateUser(updateUser);

        response.sendRedirect("home");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        userDao.deleteUser(userId);

        response.sendRedirect("home");
    }

    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        User user = userDao.getUserById(userId);
        request.setAttribute("user", user);
        RequestDispatcher dispatcher = request.getRequestDispatcher("detail.jsp");
        dispatcher.forward(request, response);
    }

}
