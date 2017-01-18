package com.abilists.admin.service;

import java.util.List;

import com.abilists.core.bean.model.UserProjectTechModel;
import com.abilists.core.bean.model.UserProjectsModel;
import com.abilists.core.bean.model.UserTaskModel;
import com.abilists.core.bean.para.users.SltUserProjectPara;
import com.abilists.core.bean.para.users.SltProjectTechPara;
import com.abilists.core.common.bean.CommonPara;
import com.abilists.core.service.PagingService;

public interface AdminProjectsService extends PagingService {

	public List<UserTaskModel> sltUserTaskList(CommonPara commonPara) throws Exception;
	public List<UserProjectsModel> sltUserProjectsList(SltUserProjectPara sltUserProjectPara) throws Exception;
	public List<UserProjectTechModel> sltUserProjectTechList(SltProjectTechPara sltUserProjectTechPara) throws Exception;

	public UserProjectsModel sltUserProjects(SltUserProjectPara sltUserProjectPara) throws Exception;
	public UserProjectTechModel sltUserProjectTech(SltProjectTechPara sltUserProjectTechPara) throws Exception;

	public int sltUserTaskSum() throws Exception;
	public int sltUserProjectsSum(SltUserProjectPara sltUserProjectPara) throws Exception;
	public int sltUserProjectTechSum(SltProjectTechPara sltUserProjectTechPara) throws Exception;
}