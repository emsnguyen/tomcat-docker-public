package com.example.DAO;

import com.example.Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private Connection con;

    public UserDAO(Connection con) throws SQLException {
        this.con = DBManager.getConnection();
    }

    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM user WHERE is_delete = false";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setContact(rs.getString("contact"));
                user.setGender(rs.getBoolean("gender"));
                user.setJob_id(rs.getInt("job_id"));
                user.setAge(rs.getInt("age"));
                users.add(user);
            }
        }
        return users;
    }

    public User getUserById(int userId) throws SQLException {
        User user = null;
        String query = "SELECT * FROM user WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setContact(rs.getString("contact"));
                user.setGender(rs.getBoolean("gender"));
                user.setJob_id(rs.getInt("job_id"));
                user.setAge(rs.getInt("age"));
            }
        }
        return user;
    }

    // public List<User> searchUsers(User searchCriteria, int minAge, int maxAge)
    // throws SQLException {
    public List<User> searchUsers(User searchCriteria) throws SQLException {
        List<User> users = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM user WHERE is_delete = 0");
        System.out.println("searchCriteria" + queryBuilder);
        if (searchCriteria.getName() != null && !searchCriteria.getName().isEmpty()) {
            queryBuilder.append(" AND name LIKE ?");
        }
        if (searchCriteria.getEmail() != null &&
                !searchCriteria.getEmail().isEmpty()) {
            queryBuilder.append(" AND email LIKE ?");
        }
        if (searchCriteria.getJob_id() > 0) {
            queryBuilder.append(" AND job_id = ?");
        }
        if (searchCriteria.getGender()) {
            queryBuilder.append(" AND gender = ?");
        }
        // if (minAge > 0) {
        // queryBuilder.append(" AND age >= ?");
        // }
        // if (maxAge > 0) {
        // queryBuilder.append(" AND age <= ?");
        // }

        try (PreparedStatement ps = con.prepareStatement(queryBuilder.toString())) {
            int parameterIndex = 1;
            if (searchCriteria.getName() != null && !searchCriteria.getName().isEmpty()) {
                ps.setString(parameterIndex++, "%" + searchCriteria.getName() + "%");
            }
            if (searchCriteria.getEmail() != null &&
                    !searchCriteria.getEmail().isEmpty()) {
                ps.setString(parameterIndex++, "%" + searchCriteria.getEmail() + "%");
            }
            if (searchCriteria.getJob_id() > 0) {
                ps.setInt(parameterIndex++, searchCriteria.getJob_id());
            }
            if (searchCriteria.getGender()) {
                ps.setBoolean(parameterIndex++, searchCriteria.getGender());
            }
            // if (minAge > 0) {
            // ps.setInt(parameterIndex++, minAge);
            // }
            // if (maxAge > 0) {
            // ps.setInt(parameterIndex++, maxAge);
            // }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setGender(rs.getBoolean("gender"));
                user.setJob_id(rs.getInt("job_id"));
                user.setAge(rs.getInt("age"));
                users.add(user);
            }
        }
        return users;
    }

    public void createUser(User user) throws SQLException {
        String query = "INSERT INTO user (name, email, password, contact, gender, job_id, age, is_delete) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getContact());
            ps.setBoolean(5, user.getGender());
            ps.setInt(6, user.getJob_id());
            ps.setInt(7, user.getAge());
            ps.setBoolean(8, user.getis_delete());

            ps.executeUpdate();
        }
    }

    public void updateUser(User user) throws SQLException {
        String query = "UPDATE user SET name = ?, email = ?, password = ?, contact = ?, gender = ?, job_id = ?, age = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getContact());
            ps.setBoolean(5, user.getGender());
            ps.setInt(6, user.getJob_id());
            ps.setInt(7, user.getAge());
            ps.setInt(8, user.getId()); // UserID for update
            ps.executeUpdate();
        }
    }

    public void deleteUser(int userId) throws SQLException {
        String query = "UPDATE user SET is_delete = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setBoolean(1, true);
            ps.setInt(2, userId); // UserID for update
            ps.executeUpdate();
        }
    }
}
