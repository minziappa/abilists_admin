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
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.abilists.admin.service.AdminUsersService;
import com.abilists.core.bean.model.UsersModel;
import com.abilists.core.bean.model.sum.AdminProjectsSumByStatusModel;
import com.abilists.core.bean.model.sum.AdminUsersSumByMonthModel;
import com.abilists.core.bean.para.admin.SltUsersPara;
import com.abilists.core.bean.para.admin.UdtUsersPara;
import com.abilists.core.dao.MAdminDao;
import com.abilists.core.dao.SAdminDao;
import com.abilists.core.dao.SMasterDao;
import com.abilists.core.dao.SUsersDao;
import com.abilists.core.service.AbstractService;

import io.utility.letter.DateUtility;
import io.utility.security.CipherUtility;

@Service
public class AdminUsersServiceImpl extends AbstractService implements AdminUsersService {

	final Logger logger = LoggerFactory.getLogger(AdminUsersServiceImpl.class);

	@Autowired
	private SqlSession sAbilistsDao;
	@Autowired
    private Configuration configuration;	
	@Autowired
	private CipherUtility cipherUtility;

	@Override
	public UsersModel sltUsers(String userId) throws Exception {

		UsersModel user = null;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);

		try {
			user = sAbilistsDao.getMapper(SUsersDao.class).sltUser(map);
			
			String decryptedEmail = cipherUtility.decrypt(user.getUserEmail()); 
			user.setUserEmail(decryptedEmail);

		} catch (Exception e) {
			logger.error("Exception error", e);
			throw e;
		}

		return user;
	}

	@Override
	public List<UsersModel> sltUsersList() throws Exception {
		List<UsersModel> usersList = new ArrayList<UsersModel>();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nowPage", 0);
		map.put("row", configuration.getInt("paging.row.cnt"));

		try {
			usersList = sAbilistsDao.getMapper(SUsersDao.class).sltUsersList(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
			throw e;
		}

		return usersList;
	}

	@Override
	public List<UsersModel> sltUsersList(SltUsersPara sltUsersPara) throws Exception {

		List<UsersModel> usersList = null;

		// Get now page
		int nowPage = sltUsersPara.getNowPage();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nowPage", (nowPage - 1) * configuration.getInt("paging.row.cnt"));
		map.put("row", configuration.getInt("paging.row.cnt"));

		try {
			usersList = sAbilistsDao.getMapper(SUsersDao.class).sltUsersList(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
			throw e;
		}

		for(UsersModel user : usersList) {
			if(!"minziappa@gmail.com".equals(user.getUserEmail())) {
				String decryptedEmail = cipherUtility.decrypt(user.getUserEmail()); 
				user.setUserEmail(decryptedEmail);
			}
		}

		return usersList;
	}

	@Override
	public int sltUsersSum() throws Exception {
		int sum = 0;

		try {
			sum = sAbilistsDao.getMapper(SUsersDao.class).sltUsersSum();
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

	public List<AdminUsersSumByMonthModel> sltUsersSumByMonth() throws Exception {
		List<AdminUsersSumByMonthModel> adminUsersSumByMonthList = null;

		String strStartDate = DateUtility.formatDate(DateUtility.getStartDayOfMonth(-3), "yyyy-MM-dd HH:mm:ss");
		String strEndDate = DateUtility.formatDate(DateUtility.getEndDayOfMonth(3), "yyyy-MM-dd HH:mm:ss");

		logger.info("start >>> " + strStartDate);
		logger.info("end >>> " + strEndDate);

		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("startDate", strStartDate);
			map.put("endDate", strEndDate);

			adminUsersSumByMonthList = sAbilistsDao.getMapper(SAdminDao.class).sltAdminUserSumByMonth(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return adminUsersSumByMonthList;
	}

	@Override
	public List<AdminProjectsSumByStatusModel> sltProjectsSumByStatus() throws Exception {
		List<AdminProjectsSumByStatusModel> adminProjectsSumByStatusList = null;

		try {
			adminProjectsSumByStatusList = sAbilistsDao.getMapper(SAdminDao.class).sltAdminProjectsSumByStatus();
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return adminProjectsSumByStatusList;
	}

	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	@Override
	public boolean udtUsers(UdtUsersPara udtUsersPara) throws Exception {
		int intResult = 0;

		try {

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userId", udtUsersPara.getUserId());
			map.put("userAuth", udtUsersPara.getUserAuth());
			map.put("userStatus", udtUsersPara.getUserStatus());

			intResult = mAbilistsDao.getMapper(MAdminDao.class).udtUsers(map);

		} catch (Exception e) {
			logger.error("Exception error", e);
			throw e;
		}
		if(intResult < 1) {
			logger.error("udtUsers error, userId={}", udtUsersPara.getUserId());
			throw new Exception("Exception deliberated thrown to abort exception");
		}

		return true;
	}

	@Override
	public List<UsersModel> srhUsersList(SltUsersPara sltUsersPara) throws Exception {

		List<UsersModel> usersList = null;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", sltUsersPara.getUserId());
		map.put("nowPage", 0);
		map.put("row", configuration.getInt("paging.row.cnt"));

		try {
			usersList = sAbilistsDao.getMapper(SUsersDao.class).srhUsersList(map);

			for(UsersModel user : usersList) {
				String decryptedEmail = cipherUtility.decrypt(user.getUserEmail());
				user.setUserEmail(decryptedEmail);
			}

		} catch (Exception e) {
			logger.error("Exception error", e);
			throw e;
		}

		return usersList;
	}

	@Override
	public int sltTechsSum() throws Exception {
		int sum = 0;

		try {
			sum = sAbilistsDao.getMapper(SMasterDao.class).sltMTechSum(null);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

	@Override
	public int sltIndustrySum() throws Exception {
		int sum = 0;

		try {
			sum = sAbilistsDao.getMapper(SMasterDao.class).sltMIndustrySum(null);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

	@Override
	public int sltRolesSum() throws Exception {
		int sum = 0;

		try {
			sum = sAbilistsDao.getMapper(SMasterDao.class).sltMRoleSum(null);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

	@Override
	public int sltNotiSum() throws Exception {
		int sum = 0;

		try {
			sum = sAbilistsDao.getMapper(SMasterDao.class).sltMNotiSum();
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

}