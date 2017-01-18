package com.abilists.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.abilists.admin.service.AdminService;
import com.abilists.core.bean.model.UserProjectTechModel;
import com.abilists.core.dao.SUsersDao;
import com.abilists.core.service.AbstractService;
import com.abilists.core.service.StartStopService;

@Service
public class AdminServiceImpl extends AbstractService implements AdminService {

	final Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class);

	@Autowired
	private SqlSession sAbilistsDao;
	@Autowired
	private StartStopService startStopService;

	@Override
	public UserProjectTechModel sltUserProjectTech() throws Exception {
		UserProjectTechModel userProjectTech = null;

		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userId", "njoonk");

			userProjectTech = sAbilistsDao.getMapper(SUsersDao.class).sltUserProjectTech(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
			throw e;
		}

		return userProjectTech;
	}

	@Override
	public List<UserProjectTechModel> sltUserProjectTechList() throws Exception {
		List<UserProjectTechModel> userProjectTechList = null;

		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userId", "njoonk");

			userProjectTechList = sAbilistsDao.getMapper(SUsersDao.class).sltUserProjectTechList(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
			throw e;
		}

		return userProjectTechList;
	}

	@Override
	public boolean reloadMaster() throws Exception {

		try {
			startStopService.start();
		} catch (Exception e) {
			logger.error("startStopService.start() is error.", e);
			return false;
		}

		return true;
	}

}