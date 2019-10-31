package com.ltz.mr.service;


import com.ltz.mr.po.Message;

import java.util.List;

public interface MessageService {
	
	public List<Message> findAllMessage();

	public boolean addMessage(Message msg);

	public void delMessage(int id);
}
