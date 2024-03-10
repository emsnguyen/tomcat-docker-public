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
                Job.setId(rs.getInt("id"));
                Job.setName(rs.getString("name"));
                Jobs.add(Job);
            }
        }
        return Jobs;
    }

    public String getJobNameById(int jobId) throws SQLException {
        String jobName = null;
        String query = "SELECT name FROM Job WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                jobName = rs.getString("name");
            }
        }
        return jobName;
    }
}
