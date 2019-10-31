package com.ltz.mr.service;

import javax.servlet.http.HttpSession;

public interface CodeService {

	public int validation(HttpSession session, String code, int timeout);
}
