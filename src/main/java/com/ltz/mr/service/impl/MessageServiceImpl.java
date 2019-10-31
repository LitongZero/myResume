package com.ltz.mr.service.impl;

import com.ltz.mr.dao.MessageDao;
import com.ltz.mr.po.Message;
import com.ltz.mr.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {
	@Autowired
	private MessageDao messageDao;


	@Override
	public boolean addMessage(Message msg) {
		return this.messageDao.addMessage(msg)>0 ? true:false;
	}


	@Override
	public List<Message> findAllMessage() {
		return this.messageDao.findAllMessage();
	}


	@Override
	public void delMessage(int id) {
		this.messageDao.delMessage(id);
	}
	

}
