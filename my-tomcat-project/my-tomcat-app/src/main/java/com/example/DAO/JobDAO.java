package com.example.DAO;

import com.example.Model.Job;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {
    private Connection con;

    public JobDAO(Connection con) throws SQLException {
        this.con = DBManager.getConnection();
    }

    public List<Job> getAllJob() throws SQLException {
        List<Job> Jobs = new ArrayList<>();
        String query = "SELECT * FROM Job";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Job Job = new Job();
                Job.setName(rs.getString("name"));
                Jobs.add(Job);
            }
        }
        return Jobs;
    }
}
