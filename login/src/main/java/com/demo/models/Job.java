package com.demo.models;

public class Job {
    private int idJob;
    private String name;

    // Constructor
    public Job(int idJob, String name) {
        this.idJob = idJob;
        this.name = name;
    }

    // Getter for idJob
    public int getIdJob() {
        return idJob;
    }

    // Setter for idJob
    public void setIdJob(int idJob) {
        this.idJob = idJob;
    }

    // Getter for name
    public String getName() {
        return name;
    }

    // Setter for name
    public void setName(String name) {
        this.name = name;
    }
}
