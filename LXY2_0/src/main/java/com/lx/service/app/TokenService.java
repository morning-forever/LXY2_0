package com.lx.service.app;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lx.dao.DaoSupport;
import com.lx.entity.UserToken;
import com.lx.util.PageData;


@Service
public class TokenService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	public UserToken getToken(PageData pageData) throws Exception {
		return (UserToken) dao.findForObject("UserTokenMapper.getToken", pageData);
	}

	public UserToken getTokenByUid(PageData pageData) throws Exception {
		return (UserToken) dao.findForObject("UserTokenMapper.getTokenByUid", pageData);
	}

	public void insert(PageData pageData) throws Exception {
		dao.save("UserTokenMapper.insertToken", pageData);
	}

	public void update(PageData pageData) throws Exception {
		dao.update("UserTokenMapper.updateToken", pageData);
	}

	public void delete(PageData pageData) throws Exception {
		dao.update("UserTokenMapper.deleteToken", pageData);
	}
}
