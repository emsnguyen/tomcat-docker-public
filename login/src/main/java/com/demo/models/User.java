package com.demo.models;
public class User {
    private String name;
    private String email;
    private int age;
    private String gender;
    private String job;

    public User(String name, String email, int age, String gender, String job) {
        this.name = name;
        this.email = email;
        this.age = age;
        this.gender = gender;
        this.job = job;
    }

    // Getters and setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }
}
