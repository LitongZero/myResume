package com.ltz.mr.controller;

import com.ltz.mr.utils.CodeUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@Controller
public class CodeController {

	@RequestMapping(value = "/getCode", method = RequestMethod.GET)
	public void login(HttpServletRequest request, HttpServletResponse response) {
		response.setHeader("Pragma", "No-cache");  
        response.setHeader("Cache-Control", "no-cache");  
        response.setDateHeader("Expires", 0);  
        response.setContentType("image/jpeg");  
          
        //生成随机字串  
        String verifyCode = CodeUtil.generateVerifyCode(4);
        //存入会话session  
        HttpSession session = request.getSession(true);
        session.setAttribute("sessionCode", verifyCode.toLowerCase());

//      设置验证码生成时间
        session.setAttribute("sessionCodeTime", new Date().getTime());
        
        //生成图片  
        int w = 100, h = 40;  
        try {
			CodeUtil.outputImage(w, h, response.getOutputStream(), verifyCode);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
	}
}
