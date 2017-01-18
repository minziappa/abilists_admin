package com.abilists.admin.controller;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.abilists.admin.service.AdminProjectsService;
import com.abilists.core.bean.AbilistsModel;
import com.abilists.core.bean.UserProjectsTechDetailBean;
import com.abilists.core.bean.model.MTechDetailModel;
import com.abilists.core.bean.model.UserProjectTechModel;
import com.abilists.core.bean.model.UserProjectsModel;
import com.abilists.core.bean.para.users.DltProjectTechPara;
import com.abilists.core.bean.para.users.DltProjectsPara;
import com.abilists.core.bean.para.users.IstProjectTechPara;
import com.abilists.core.bean.para.users.IstProjectsPara;
import com.abilists.core.bean.para.users.SltProjectTechPara;
import com.abilists.core.bean.para.users.SltUserProjectPara;
import com.abilists.core.bean.para.users.UdtProjectTechPara;
import com.abilists.core.bean.para.users.UdtProjectsPara;
import com.abilists.core.common.bean.CommonBean;
import com.abilists.core.controller.AbstractBaseController;
import com.abilists.core.service.UsersService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/admin/project")
public class ProjectsAdminAbilistsController extends AbstractBaseController {

	final Logger logger = LoggerFactory.getLogger(ProjectsAdminAbilistsController.class);

	@Autowired
	private MessageSource message;
	@Autowired
	private AdminProjectsService adminProjectsService;
	@Autowired
	private UsersService usersService;
	@Autowired
	private CommonBean commonBean;

	@RequestMapping(value = {"sltProjectsList"})
	public String sltProjectsList(@Valid SltUserProjectPara sltUserProjectPara, 
			ModelMap model) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltProjectsList");

		// Set Paging list
		int intSum = adminProjectsService.sltUserProjectsSum(sltUserProjectPara);
		abilistsModel.setPaging(adminProjectsService.makePaging(sltUserProjectPara, intSum));

		// Get user projects
		List<UserProjectsModel> userProjectsList = adminProjectsService.sltUserProjectsList(sltUserProjectPara);
		abilistsModel.setUserProjectsList(userProjectsList);

		model.addAttribute("model", abilistsModel);

		return "admin/project/sltProjectsList";
	}

	@RequestMapping(value = {"sltProjectTechList"})
	public String sltProjectTechList(@Valid SltProjectTechPara sltUserProjectTechPara, 
			HttpSession session, ModelMap model) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltProjectTechList");

		// Set Paging list
		int intSum = adminProjectsService.sltUserProjectTechSum(sltUserProjectTechPara);
		abilistsModel.setPaging(adminProjectsService.makePaging(sltUserProjectTechPara, intSum));

		// Get a tech list on a project.
		List<UserProjectTechModel> userProjectTechList = adminProjectsService.sltUserProjectTechList(sltUserProjectTechPara);
		abilistsModel.setUserProjectTechList(userProjectTechList);

		model.addAttribute("model", abilistsModel);

		return "admin/project/sltProjectTechList";
	}

	@RequestMapping(value = {"sltProjectTechList/{upNo}"})
	public String sltProjectTechList(@PathVariable String upNo, 
			HttpSession session, ModelMap model) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("project");
		abilistsModel.setMenu("sltProjectsList");

		// Get a project
		SltUserProjectPara sltUserProjectPara = new SltUserProjectPara();
		sltUserProjectPara.setUpNo(upNo);

		UserProjectsModel userProjects = usersService.sltUserProjects(sltUserProjectPara);
		abilistsModel.setUserProjects(userProjects);

		// Get a tech list on a project.
		SltProjectTechPara sltProjectTechPara = new SltProjectTechPara();
		sltProjectTechPara.setUpNo(upNo);

		List<UserProjectTechModel> userProjectTechList = usersService.sltUserProjectTechList(sltProjectTechPara);
		abilistsModel.setUserProjectTechList(userProjectTechList);
		model.addAttribute("model", abilistsModel);

		return "admin/project/sltProjectTechList";
	}

	@RequestMapping(value="/sltProjectsAjax")
	public void sltProjectsAjax(@RequestParam("body") String body, HttpSession session, 
			HttpServletResponse response) throws Exception {
	
		logger.info("sltProjectsAjax. upNo is " + body);

		ObjectMapper mapper = new ObjectMapper();
		JSONParser parser=new JSONParser();
		Object obj = parser.parse(body);
		JSONObject jsonObject = (JSONObject) obj;
		String upNo = (String)jsonObject.get("upNo");
	
		SltUserProjectPara sltUserProjectPara = new SltUserProjectPara();
		sltUserProjectPara.setUpNo(upNo);
	
		// Set user id
		this.handleSessionInfo(session, sltUserProjectPara);
		UserProjectsModel userProjects = adminProjectsService.sltUserProjects(sltUserProjectPara);
		Map<String, UserProjectsModel> map = new LinkedHashMap<String, UserProjectsModel>();
		map.put("result", userProjects);
	
		//Convert object to JSON string
		String jsonInString = mapper.writeValueAsString(map);
	
		this.handleWriteAjax(jsonInString, response);
	}

	@RequestMapping(value = {"sltProjectTechAjax"})
	public void sltProjectTechAjax(@RequestParam("body") String body,
			HttpSession session, HttpServletResponse response) throws Exception {

		ObjectMapper mapper = new ObjectMapper();

		JSONParser parser=new JSONParser();
		Object obj = parser.parse(body);
		JSONObject jsonObject = (JSONObject) obj;
		String uptNo = (String)jsonObject.get("uptNo");
		String mtNo = (String)jsonObject.get("mtNo");

		SltProjectTechPara sltUserProjectTechPara = new SltProjectTechPara();
		sltUserProjectTechPara.setUptNo(uptNo);

		// Get Techs of a project
		UserProjectTechModel userProjectTech = adminProjectsService.sltUserProjectTech(sltUserProjectTechPara);
		// Get data in detail
		List<MTechDetailModel> mTechDetailList = commonBean.getmTechDetailMap().get(mtNo);

		UserProjectsTechDetailBean userProjectsTechDetail = new UserProjectsTechDetailBean();
		userProjectsTechDetail.setUserProjectTech(userProjectTech);
		userProjectsTechDetail.setmTechDetailList(mTechDetailList);

		Map<String, UserProjectsTechDetailBean> map = new LinkedHashMap<String, UserProjectsTechDetailBean>();
		map.put("result", userProjectsTechDetail);

		//Convert object to JSON string
		String jsonInString = mapper.writeValueAsString(map);

		this.handleWriteAjax(jsonInString, response);
	}

	@RequestMapping(value = {"istProjects"})
	public String istProjects(@Valid IstProjectsPara istProjectsPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request, 
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("project");
		abilistsModel.setMenu("sltProjectsList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("istProjects - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);

			return "errors/error";
		}

		// Set user id
		this.handleSessionInfo(request.getSession(), istProjectsPara);

		// Execute the transaction
		if(!usersService.insertUserProjects(istProjectsPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/project/sltProjectsList";
	}

	@RequestMapping(value = {"istProjectTech"})
	public String istProjectTech(@Valid IstProjectTechPara istProjectTechPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("project");
		abilistsModel.setMenu("sltProjectTechList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("istProjectTech - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Set user id
		this.handleSessionInfo(request.getSession(), istProjectTechPara);

		// Execute the transaction
		if(!usersService.insertUserProjectTech(istProjectTechPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/project/sltProjectTechList/" + istProjectTechPara.getUpNo();
	}

	@RequestMapping(value = {"udtProjects"})
	public String udtProjects(@Valid UdtProjectsPara udtProjectsPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request, 
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("project");
		abilistsModel.setMenu("sltProjectsList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("udtProjects - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Execute the transaction
		if(!usersService.updateUserProjects(udtProjectsPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/project/sltProjectsList";
	}

	@RequestMapping(value = {"udtProjectTech"})
	public String udtProjectTech(@Valid UdtProjectTechPara udtProjectTechPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("project");
		abilistsModel.setMenu("sltProjectTechList");
		model.addAttribute("model", abilistsModel);

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("udtProjectTech - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Execute the transaction
		if(!usersService.updateUserProjectTech(udtProjectTechPara)) {
			mapErrorMessage = new HashMap<String, String>();
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.error.message", null, locale));
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/project/sltProjectTechList/" + udtProjectTechPara.getUpNo();
	}

	@RequestMapping(value = {"dltProjects"})
	public String dltProjects(@Valid DltProjectsPara dltProjectsPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request, 
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("project");
		abilistsModel.setMenu("sltProjectsList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("dltProjects - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Execute the transaction
		if(!usersService.dltUserProjectsWithTech(dltProjectsPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "errors/error";
		}

		return "redirect:/admin/project/sltProjectsList";
	}

	@RequestMapping(value = {"dltProjectTech"})
	public String dltProjectTech(@Valid DltProjectTechPara dltProjectTechPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("project");
		abilistsModel.setMenu("sltProjectTechList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("dltProjectTech - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Execute the transaction
		if(!usersService.deleteUserProjectTech(dltProjectTechPara)) {
			mapErrorMessage = new HashMap<String, String>();
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.update.error.message", null, locale));
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/project/sltProjectTechList/" + dltProjectTechPara.getUpNo();
	}

}