package com.example.Controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.example.DAO.DBManager;

import java.sql.*;

@WebServlet("/registerServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String contact = request.getParameter("contact");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBManager.getConnection();

            if (con != null) {
                System.out.println("Connected to the database.");
                
                // Kiểm tra xem người dùng đã tồn tại trong cơ sở dữ liệu chưa
                if (isUserExist(con, name)) {
                    response.getWriter().write("exists");
                    return;
                }
                
                // Nếu người dùng không tồn tại, thêm vào cơ sở dữ liệu
                ps = con.prepareStatement("INSERT INTO user (name, email, password, contact, is_delete, created_by) VALUES (?, ?, ?, ?, ?, ?)");

                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, pass);
                ps.setString(4, contact);
                ps.setBoolean(5, false);
                ps.setString(6, email);

                int i = ps.executeUpdate();

                if (i > 0) {
                    System.out.println("Data inserted successfully.");
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("error.jsp");
                }
            } else {
                System.out.println("Failed to connect to the database.");
            }
      
        } catch (SQLException se) {
            se.printStackTrace();
        } finally {
            // Đóng kết nối và tuyên bố PreparedStatement ở đây
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Phương thức kiểm tra xem người dùng có tồn tại trong cơ sở dữ liệu hay không
    private boolean isUserExist(Connection con, String name) throws SQLException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean exist = false;
        try {
            ps = con.prepareStatement("SELECT * FROM user WHERE name = ?");
            ps.setString(1, name);
            rs = ps.executeQuery();
            if (rs.next()) {
                exist = true;
            }
        } finally {
            // Đóng ResultSet và PreparedStatement ở đây
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
}
