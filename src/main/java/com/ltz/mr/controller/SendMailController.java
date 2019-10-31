package com.ltz.mr.controller;

import com.ltz.mr.po.Message;
import com.ltz.mr.service.CodeService;
import com.ltz.mr.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class SendMailController {
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private MessageService messageService;
	
	@RequestMapping(value="/index", method= RequestMethod.GET)
	public String index(){
		
		return "index";
	}
	
	@RequestMapping(value = "/sendMail" ,method = RequestMethod.POST)
	public void sendMail(Model model, HttpSession httpSession, String code , String name , String email, String subject, String message, HttpServletRequest request, HttpServletResponse response) {
		int success =0;
		
		int flag = codeService.validation(httpSession , code , 60*5);
		if (flag==0) {
			Message msg = new Message();
			msg.setName(name);
			msg.setEmail(email);
			msg.setSubject(subject);
			msg.setMsg(message);
			if (messageService.addMessage(msg)) {
				success=1;
			}
			
		}else if (flag==1) {
//			验证码错误
			success=2;
		}else if (flag==2) {
//			验证码超时
			success=3;
		}
		try {
			response.getWriter().write("{\"success\":"+success+"}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value="/looklook", method= RequestMethod.GET)
	public String look( Model model){
		List<Message> messages = null;
		messages = messageService.findAllMessage();
		System.out.println(messages);
		model.addAttribute("messages",messages);
		return "look";
	}
	
	@RequestMapping(value="/delete", method= RequestMethod.GET)
	public String del(int id){
		messageService.delMessage(id);
		return "redirect:looklook";
	}
}
