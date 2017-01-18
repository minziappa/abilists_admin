package com.abilists.admin.service;

import java.util.List;

import com.abilists.core.bean.model.UsersModel;
import com.abilists.core.bean.model.sum.AdminProjectsSumByStatusModel;
import com.abilists.core.bean.model.sum.AdminUsersSumByMonthModel;
import com.abilists.core.bean.para.admin.SltUsersPara;
import com.abilists.core.bean.para.admin.UdtUsersPara;
import com.abilists.core.service.PagingService;

public interface AdminUsersService extends PagingService {

	public boolean udtUsers(UdtUsersPara udtUsersPara) throws Exception;
	public UsersModel sltUsers(String userCode) throws Exception;
	public List<UsersModel> sltUsersList(SltUsersPara sltUsersPara) throws Exception;
	public List<UsersModel> srhUsersList(SltUsersPara sltUsersPara) throws Exception;
	public List<UsersModel> sltUsersList() throws Exception;
	public int sltUsersSum() throws Exception;

	public List<AdminUsersSumByMonthModel> sltUsersSumByMonth() throws Exception;
	public List<AdminProjectsSumByStatusModel> sltProjectsSumByStatus() throws Exception;

	public int sltTechsSum() throws Exception;
	public int sltIndustrySum() throws Exception;
	public int sltRolesSum() throws Exception;
	public int sltNotiSum() throws Exception;

}