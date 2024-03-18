package com.example.Controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Connection;
import java.util.List;
import java.util.Properties;

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

@WebServlet(urlPatterns = { "/home", "/home/search" })

public class HomeServlet extends HttpServlet {

    private Connection con;
    private UserDAO userDao;
    private JobDAO jobDao;
    private int pageSize;
    private int pageNumber;

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

        Properties properties = new Properties();
        try {
            properties.load(getServletContext().getResourceAsStream("/WEB-INF/config.properties"));
            this.pageSize = Integer.parseInt(properties.getProperty("pageSize"));
            this.pageNumber = Integer.parseInt(properties.getProperty("pageNumber"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
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
                    case "/home/search":
                        performSearch(request, response);
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

        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            pageNumber = Integer.parseInt(pageStr);
        }

        List<User> listUser = userDao.Pagination(pageNumber, pageSize);
        List<Job> listJob = jobDao.getAllJob();
        for (User user : listUser) {
            int jobId = user.getJob_id();
            String jobName = jobDao.getJobNameById(jobId);
            user.setJob_name(jobName);
        }

        // Tính toán tổng số trang
        int totalUsers = userDao.getAllUsers().size();
        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
        int startRecord = (pageNumber - 1) * pageSize + 1;
        int endRecord = Math.min(pageNumber * pageSize, totalUsers);
        request.setAttribute("listUser", listUser);
        request.setAttribute("listJob", listJob);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("startRecord", startRecord);
        request.setAttribute("endRecord", endRecord);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/home.jsp");
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
        userJSON.put("id", user.getId());
        userJSON.put("name", user.getName());
        userJSON.put("job_name", jobName);
        userJSON.put("email", user.getEmail());

        // Gửi phản hồi JSON về trình duyệt
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(userJSON.toString());
    }

    private void performSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Job> listJob = jobDao.getAllJob();
        // Lấy các thông tin tìm kiếm từ request
        String name = request.getParameter("name").trim();
        String email = request.getParameter("email").trim();
        String jobParam = request.getParameter("job_id");
        String genderParam = request.getParameter("gender");

        Integer job = null;
        if (jobParam != null && !jobParam.isEmpty()) {
            job = Integer.parseInt(jobParam);
        }

        Boolean gender = null;
        if (genderParam != null && !genderParam.isEmpty()) {
            gender = "1".equals(genderParam.trim());
        }

        int minAge = (request.getParameter("minAge") != null && !request.getParameter("minAge").isEmpty())
                ? Integer.parseInt(request.getParameter("minAge").trim())
                : 0;

        int maxAge = (request.getParameter("maxAge") != null && !request.getParameter("maxAge").isEmpty())
                ? Integer.parseInt(request.getParameter("maxAge").trim())
                : 0;
        // Tạo đối tượng User chứa thông tin tìm kiếm
        User searchCriteria = new User();
        searchCriteria.setName(name);
        searchCriteria.setEmail(email);
        if (job != null) {
            searchCriteria.setJob_id(job);
        }
        if (genderParam != null && !genderParam.isEmpty()) {
            searchCriteria.setGender(gender);
        }
        // Gọi phương thức searchUsers từ DAO
        List<User> searchResult = userDao.searchUsers(searchCriteria, minAge,
                maxAge);

        for (User user : searchResult) {
            int jobId = user.getJob_id();
            String jobName = jobDao.getJobNameById(jobId);
            user.setJob_name(jobName);
        }

        request.setAttribute("pageSize", pageSize);
        
        int totalUsers = userDao.getAllUsers().size();
        int endRecord = searchResult.size();
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("endRecord", endRecord); 
        request.setAttribute("listJob", listJob);
        request.setAttribute("searchResult", searchResult);
        request.getRequestDispatcher("/search.jsp").forward(request, response);
    }
}
