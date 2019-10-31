package com.ltz.mr.po;

import java.io.Serializable;

public class Message implements Serializable {
    private static final long serialVersionUID = 1L;
    //	主键
    private String id;
    //	用户名称
    private String name;
    //	用户邮箱
    private String email;
    //	主题
    private String subject;
    //	信息
    private String msg;
    //	时间
    private String date;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

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

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

}
