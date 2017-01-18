package com.abilists.admin.service;

import java.util.List;

import com.abilists.core.bean.model.UserProjectTechModel;
import com.abilists.core.service.PagingService;

public interface AdminService extends PagingService {

	public UserProjectTechModel sltUserProjectTech() throws Exception;
	public List<UserProjectTechModel> sltUserProjectTechList() throws Exception;

	public boolean reloadMaster() throws Exception;
}