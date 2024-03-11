package com.example.Model;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String contact;
    private boolean gender;
    private int job_id;
    private int age;
    private String job_name;
    private boolean is_delete;

    // Getter và setter cho trường 'id'
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter và setter cho trường 'name'
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Getter và setter cho trường 'email'
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // Getter và setter cho trường 'password'
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // Getter và setter cho trường 'contact'
    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    // Getter và setter cho trường 'gender'
    public boolean getGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    // Getter và setter cho trường 'job_id'
    public int getJob_id() {
        return job_id;
    }

    public void setJob_id(int job_id) {
        this.job_id = job_id;
    }

    // Getter và setter cho trường 'age'
    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    // Getter và setter cho trường 'job_name'
    public String getJob_name() {
        return job_name;
    }

    public void setJob_name(String job_name) {
        this.job_name = job_name;
    }

    // Getter và setter cho trường 'is_delete'
    public boolean getis_delete() {
        return is_delete;
    }

    public void setis_delete(boolean is_delete) {
        this.is_delete = is_delete;
    }
}
