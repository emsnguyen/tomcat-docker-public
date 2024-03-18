package com.example.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBManager {
    private static final String URL = "jdbc:mysql://localhost:3306/tomcatdb?characterEncoding=UTF-8";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "1234";
    private static Connection connection = null;

    private DBManager() {
    }

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            synchronized (DBManager.class) {
                if (connection == null || connection.isClosed()) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return connection;
    }
}
