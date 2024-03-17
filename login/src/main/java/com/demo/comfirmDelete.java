package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteUser")
public class comfirmDelete extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        deleteUserFromDatabase(response, userId);
    }

    private void deleteUserFromDatabase(HttpServletResponse response,int userId) {
    	try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE user_info SET is_deleted = ?  WHERE id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, 1);
            statement.setInt(2, userId);
            statement.executeUpdate();
        	user.popup(response, "Delete Successfully");
        } catch (SQLException e) {
        	user.popup(response, "Delete Fail");
            e.printStackTrace();
        }
    }
}