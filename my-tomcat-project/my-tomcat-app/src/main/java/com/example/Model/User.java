package com.example.Model;

import java.sql.Timestamp;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String contact;
    private Boolean gender;
    private int job_id;
    private int age;
    private String Job_name;
    private Boolean is_delete;
    private Timestamp created_at;
    private String created_by;
    private Timestamp updated_at;
    private String updated_by;
    private Timestamp deleted_at;
    private String deleted_by;

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
    
    // Getter và setter cho trường 'Job_name'
    public String getJob_name() {
        return Job_name;
    }

    public void setJob_name(String Job_name) {
        this.Job_name = Job_name;
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
    public Boolean getGender() {
        return gender;
    }

    public void setGender(Boolean gender) {
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


    // Getter và setter cho trường 'is_delete'
    public Boolean getis_delete() {
        return is_delete;
    }

    public void setis_delete(Boolean is_delete) {
        this.is_delete = is_delete;
    }

    // Getter và setter cho trường 'created_at'
    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    // Getter và setter cho trường 'created_by'
    public String getCreated_by() {
        return created_by;
    }

    public void setCreated_by(String created_by) {
        this.created_by = created_by;
    }

    // Getter và setter cho trường 'updated_at'
    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }

    // Getter và setter cho trường 'updated_by'
    public String getUpdated_by() {
        return updated_by;
    }

    public void setUpdated_by(String updated_by) {
        this.updated_by = updated_by;
    }

    // Getter và setter cho trường 'deleted_at'
    public Timestamp getDeleted_at() {
        return deleted_at;
    }

    public void setDeleted_at(Timestamp deleted_at) {
        this.deleted_at = deleted_at;
    }

    // Getter và setter cho trường 'deleted_by'
    public String getDeleted_by() {
        return deleted_by;
    }

    public void setDeleted_by(String deleted_by) {
        this.deleted_by = deleted_by;
    }
}
