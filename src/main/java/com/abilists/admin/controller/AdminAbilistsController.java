package com.abilists.admin.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.configuration.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.abilists.admin.service.AdminProjectsService;
import com.abilists.admin.service.AdminService;
import com.abilists.admin.service.AdminUsersService;
import com.abilists.core.bean.AbilistsModel;
import com.abilists.core.bean.AdminAbilistsModel;
import com.abilists.core.bean.admin.TaskBean;
import com.abilists.core.bean.model.UserTaskModel;
import com.abilists.core.common.bean.CommonPara;
import com.abilists.core.controller.AbstractBaseController;

@Controller
@RequestMapping("/admin")
public class AdminAbilistsController extends AbstractBaseController {

	final Logger logger = LoggerFactory.getLogger(AdminAbilistsController.class);

	@Autowired
	private MessageSource message;
	@Autowired
	private AdminUsersService adminUsersService;
	@Autowired
	private AdminProjectsService adminProjectsService;
	@Autowired
	private AdminService adminService;
	@Autowired
    private Configuration configuration;

	/*
	 * The Dashboard for Admin
	 */
	@RequestMapping(value = {"", "/", "index"})
	public String index(@Valid CommonPara commonPara, ModelMap model, HttpSession session) throws Exception {

		AdminAbilistsModel adminAbilists = new AdminAbilistsModel();
		adminAbilists.setNavi("admin");
		adminAbilists.setMenu("users");

		List<TaskBean> taskBeanList = new ArrayList<>();
		List<UserTaskModel> taskList = adminProjectsService.sltUserTaskList(commonPara);

		// Read image with byte
		for (UserTaskModel task : taskList) {
			String imgData = this.handleReadImage(task.getUserId(), configuration.getString("upload.path.img"));
			TaskBean taskBean = new TaskBean();
			taskBean.setUserImgData(imgData);
			taskBean.setUserTask(task);

			taskBeanList.add(taskBean);
		}

		// User task list with images
		adminAbilists.setTaskBeanList(taskBeanList);

		// Sum user count by month
		adminAbilists.setAdminUsersSumByMonthList(adminUsersService.sltUsersSumByMonth());

		// Sum projects count by status
		adminAbilists.setAdminProjectsSumByStatusList(adminUsersService.sltProjectsSumByStatus());

		// Sum Techs
		adminAbilists.setTechsSum(adminUsersService.sltTechsSum());		
		// Sum Industry
		adminAbilists.setIndustrySum(adminUsersService.sltIndustrySum());
		// Sum Roles
		adminAbilists.setRolesSum(adminUsersService.sltRolesSum());
		// Notification
		adminAbilists.setNotiSum(adminUsersService.sltNotiSum());

		model.addAttribute("model", adminAbilists);

		return "admin/index";
	}

	/*
	 * Reload the master data.
	 */
	@RequestMapping(value = {"reloadMaster"})
	public String reloadMaster(HttpServletRequest request, ModelMap model, 
			RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("reloadMaster");

		// Set user id
		CommonPara commonPara = new CommonPara();
		this.handleSessionInfo(request.getSession(), commonPara);

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		// Set Paging list
		if(!adminService.reloadMaster()) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "errors/error";
		}

		model.addAttribute("model", abilistsModel);

		logger.info("Reloaded the master data.");
		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "admin/master/reloadMaster";
	}

}