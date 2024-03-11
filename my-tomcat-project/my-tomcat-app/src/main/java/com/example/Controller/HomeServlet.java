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

import org.json.JSONObject;

import com.example.DAO.DBManager;
import com.example.DAO.JobDAO;
import com.example.DAO.UserDAO;
import com.example.Model.Job;
import com.example.Model.User;

@WebServlet(urlPatterns = { "/home", "/home/detail" })

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
        for (User user : listUser) {
            int jobId = user.getJob_id();
            String jobName = jobDao.getJobNameById(jobId);
            user.setJob_name(jobName);
        }
        request.setAttribute("listUser", listUser);
        request.setAttribute("listJob", listJob);

        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        dispatcher.forward(request, response);
    }

    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int userId = Integer.parseInt(request.getParameter("id"));
        User user = userDao.getUserById(userId);

        int jobId = user.getJob_id();
        String jobName = jobDao.getJobNameById(jobId);

        // Tạo đối tượng JSON từ thông tin người dùng
        JSONObject userJSON = new JSONObject();
        userJSON.put("name", user.getName());
        userJSON.put("age", user.getAge());
        userJSON.put("gender", user.getGender());
        userJSON.put("email", user.getEmail());
        userJSON.put("job_name", jobName);

        // Gửi phản hồi JSON về trình duyệt
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(userJSON.toString());
    }

}
