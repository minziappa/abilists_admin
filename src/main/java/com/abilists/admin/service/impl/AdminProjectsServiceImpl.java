package com.abilists.admin.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.configuration.Configuration;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.abilists.core.bean.model.UserProjectTechModel;
import com.abilists.core.bean.model.UserProjectsModel;
import com.abilists.core.bean.model.UserTaskModel;
import com.abilists.core.bean.para.users.SltUserProjectPara;
import com.abilists.core.bean.para.users.SltProjectTechPara;
import com.abilists.core.common.bean.CommonPara;
import com.abilists.core.dao.SAdminDao;
import com.abilists.core.dao.SUsersDao;
import com.abilists.core.service.AbstractService;
import com.abilists.admin.service.AdminProjectsService;

@Service
public class AdminProjectsServiceImpl extends AbstractService implements AdminProjectsService {

	final Logger logger = LoggerFactory.getLogger(AdminProjectsServiceImpl.class);

	@Autowired
	private SqlSession sAbilistsDao;
	@Autowired
    private Configuration configuration;	

	@Override
	public List<UserTaskModel> sltUserTaskList(CommonPara commonPara) throws Exception {

		List<UserTaskModel> userTaskList = new ArrayList<>();

		// Get now page
		int nowPage = commonPara.getNowPage();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nowPage", (nowPage - 1) * configuration.getInt("paging.row.cnt"));
		map.put("row", configuration.getInt("paging.row.cnt"));

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			userTaskList = sAbilistsDao.getMapper(SAdminDao.class).sltAdminTaskList(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return userTaskList;
	}

	@Override
	public int sltUserTaskSum() throws Exception {
		int sum = 0;

		try {
			sum = sAbilistsDao.getMapper(SAdminDao.class).sltAdminTaskSum();
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

	@Override
	public int sltUserProjectsSum(SltUserProjectPara sltUserProjectPara) throws Exception {
		int sum = 0;

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			sum = sAbilistsDao.getMapper(SUsersDao.class).sltUserProjectsSum(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

	@Override
	public List<UserProjectsModel> sltUserProjectsList(SltUserProjectPara sltUserProjectPara) throws Exception {

		List<UserProjectsModel> userProjectsList = new ArrayList<>();

		// Get now page
		int nowPage = sltUserProjectPara.getNowPage();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nowPage", (nowPage - 1) * configuration.getInt("paging.row.cnt"));
		map.put("row", configuration.getInt("paging.row.cnt"));

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			userProjectsList = sAbilistsDao.getMapper(SUsersDao.class).sltUserProjectsList(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return userProjectsList;
	}

	@Override
	public int sltUserProjectTechSum(SltProjectTechPara sltUserProjectTechPara) throws Exception {
		int sum = 0;

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			sum = sAbilistsDao.getMapper(SUsersDao.class).sltUserProjectTechSum(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

	@Override
	public List<UserProjectTechModel> sltUserProjectTechList(SltProjectTechPara sltUserProjectTechPara) throws Exception {
		List<UserProjectTechModel> userProjectTechList = null;

		// Get now page
		int nowPage = sltUserProjectTechPara.getNowPage();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nowPage", (nowPage - 1) * configuration.getInt("paging.row.cnt"));
		map.put("row", configuration.getInt("paging.row.cnt"));

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			userProjectTechList = sAbilistsDao.getMapper(SUsersDao.class).sltUserProjectTechList(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return userProjectTechList;
	}

	@Override
	public UserProjectsModel sltUserProjects(SltUserProjectPara sltUserProjectPara) throws Exception {

		UserProjectsModel userProjects = null;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("upNo", sltUserProjectPara.getUpNo());

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			userProjects = sAbilistsDao.getMapper(SUsersDao.class).sltUserProjects(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return userProjects;
	}

	@Override
	public UserProjectTechModel sltUserProjectTech(SltProjectTechPara sltUserProjectTechPara) throws Exception {
		UserProjectTechModel userProjectTech = null;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uptNo", sltUserProjectTechPara.getUptNo());

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			userProjectTech = sAbilistsDao.getMapper(SUsersDao.class).sltUserProjectTech(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return userProjectTech;
	}

}