package com.ltz.mr.service.impl;

import com.ltz.mr.service.CodeService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.Date;

@Service("codeService")
@Transactional
public class CodeServiceImpl implements CodeService {

	
	/**
	 * @param session :请求session
	 * @param code：用户输入的验证码
	 * @param timeout:设置超时时间
	 * 
	 * @return 
	 * 	0：验证成功
	 * 	1：验证码错误
	 * 	2：验证码超时
	 */
	@Override
	public int validation(HttpSession session, String code , int timeout) {
		
		String sessionCodeTime = session.getAttribute("sessionCodeTime").toString();
		Date nowDate = new Date();
		
		if (Long.valueOf(sessionCodeTime)+timeout*1000 <= nowDate.getTime()) {
			return 2;
		}
		String sessionCode = session.getAttribute("sessionCode").toString();
        if (code != null && !"".equals(code) && sessionCode != null && !"".equals(sessionCode)) {
          
        	if (code.equalsIgnoreCase(sessionCode)) {
//     		 验证通过
        		return 0;
            } else {
            	return 1;
            }
        } else {
        	return 1;
        }
	}

}
