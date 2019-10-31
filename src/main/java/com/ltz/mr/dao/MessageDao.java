package com.ltz.mr.dao;


import com.ltz.mr.po.Message;

import java.util.List;

/**
 * 用户DAO层接口
 */
public interface MessageDao {
	/**
	 * 通过账号和密码查询用户
	 */
	public int addMessage(Message msg);
	
	public List<Message> findAllMessage();

	public void delMessage(int id);
}
