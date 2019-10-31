package com.ltz.mr;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
@MapperScan("com.ltz.mr.dao")
public class MrApplication {

    public static void main(String[] args) {
        SpringApplication.run(MrApplication.class, args);
    }

}
