package com.abilists.admin.controller;

import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.configuration.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.abilists.admin.service.AdminProjectsService;
import com.abilists.core.bean.AbilistsModel;
import com.abilists.core.bean.AdminAbilistsModel;
import com.abilists.core.bean.admin.TaskBean;
import com.abilists.core.bean.model.UserTaskModel;
import com.abilists.core.bean.para.task.DltTaskPara;
import com.abilists.core.bean.para.task.SltTaskPara;
import com.abilists.core.common.bean.CommonPara;
import com.abilists.core.controller.AbstractBaseController;
import com.abilists.core.service.TaskService;

@Controller
@RequestMapping("/project")
public class TaskAdminAbilistsController extends AbstractBaseController {

	final Logger logger = LoggerFactory.getLogger(TaskAdminAbilistsController.class);

	@Autowired
	private MessageSource message;
	@Autowired
	private AdminProjectsService adminProjectsService;
	@Autowired
	private TaskService taskService;

	@Autowired
    private Configuration configuration;

	@RequestMapping(value = {"sltTaskList"})
	public String sltTaskList(@Valid CommonPara commonPara, ModelMap model) throws Exception {

		AdminAbilistsModel adminAbilists = new AdminAbilistsModel();
		adminAbilists.setNavi("admin");
		adminAbilists.setMenu("taskList");

		// Set Paging list
		int intSum = adminProjectsService.sltUserTaskSum();
		adminAbilists.setPaging(adminProjectsService.makePaging(commonPara, intSum));

		// Execute the transaction
		adminAbilists.setUserTaskList(adminProjectsService.sltUserTaskList(commonPara));

		model.addAttribute("model", adminAbilists);

		return "admin/project/sltTaskList";
	}

	@RequestMapping(value="/sltTaskAjax")
	public @ResponseBody TaskBean sltTaskAjax(@RequestBody SltTaskPara sltTaskPara, 
			HttpSession session) throws Exception {

		TaskBean taskBean = new TaskBean();

		// Get your task - false -> Not to convert from \r to <br/> 
		UserTaskModel userTask = taskService.sltTask(sltTaskPara, false);
		taskBean.setUserTask(userTask);

		// User image
		String userImgData = this.handleReadImage(sltTaskPara.getUserId(), configuration.getString("upload.path.img"));
		taskBean.setUserImgData(userImgData);

		return taskBean;
	}

	@RequestMapping(value = {"dltTask"})
	public String dltTask(@Valid DltTaskPara dltTaskPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("project");
		abilistsModel.setMenu("sltTaskList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("dltTask - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Execute the transaction
		if(!taskService.dltTask(dltTaskPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "errors/error";
		}

		return "redirect:sltTaskList";
	}

}