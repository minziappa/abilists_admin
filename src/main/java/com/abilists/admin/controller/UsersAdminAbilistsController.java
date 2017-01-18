package com.abilists.admin.controller;

import java.util.List;
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

import com.abilists.admin.service.AdminUsersService;
import com.abilists.core.bean.AbilistsModel;
import com.abilists.core.bean.model.UsersModel;
import com.abilists.core.bean.para.admin.SltUsersPara;
import com.abilists.core.bean.para.admin.UdtUsersPara;
import com.abilists.core.controller.AbstractBaseController;

@Controller
@RequestMapping("/admin/users")
public class UsersAdminAbilistsController extends AbstractBaseController {

	final Logger logger = LoggerFactory.getLogger(UsersAdminAbilistsController.class);

	@Autowired
	private MessageSource message;
	@Autowired
	private AdminUsersService adminUserService;
	@Autowired
    private Configuration configuration;

	@RequestMapping(value = {"sltUsersList"})
	public String usersList(@Valid SltUsersPara sltUsersPara, 
			ModelMap model) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("usersList");

		// Set Paging list
		int intSum = adminUserService.sltUsersSum();
		abilistsModel.setPaging(adminUserService.makePaging(sltUsersPara, intSum));

		// Execute the transaction
		abilistsModel.setUsersList(adminUserService.sltUsersList(sltUsersPara));
	
		model.addAttribute("model", abilistsModel);

		return "admin/users/sltUsersList";
	}

	@RequestMapping(value = {"udtUsers"})
	public String udtUsers(@Valid UdtUsersPara udtUsersPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("usersList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("udtTask - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "error/error";
		}

		// Execute the transaction
		if(!adminUserService.udtUsers(udtUsersPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "error/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:sltUsersList";
	}

	/*
	 * Users by Ajax
	 */
    @RequestMapping(value="/sltUsersAjax")
	public @ResponseBody UsersModel sltUsersAjax(@Valid @RequestBody SltUsersPara sltUsersPara, 
			BindingResult bindingResult) throws Exception {

		// If it occurs a error, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("sltUsersAjax - it is occured a parameter error.");
			return null;
		}

		// Read image with byte
		String userImgData = this.handleReadImage(sltUsersPara.getUserId(), 
				configuration.getString("upload.path.img"));

		// Get user information
		UsersModel users = adminUserService.sltUsers(sltUsersPara.getUserId());

		// Set user's image data
		users.setUserImgData(userImgData);

    	return users;
	}

	/*
	 * Users by Ajax
	 */
    @RequestMapping(value="/sltUsersListAjax")
	public @ResponseBody List<UsersModel> sltUsersListAjax(@Valid @RequestBody SltUsersPara sltUsersPara, 
			BindingResult bindingResult) throws Exception {

		// If it occurs a error, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("sltNotiAjax - it is occured a parameter error.");
			return null;
		}

		// Get user information
		List<UsersModel> usersList = adminUserService.srhUsersList(sltUsersPara);

		// Read image with byte
		for (UsersModel user : usersList) {
			String imgData = this.handleReadImage(user.getUserId(), configuration.getString("upload.path.img"));
			user.setUserImgData(imgData);
		}

    	return usersList;
	}

	@RequestMapping(value = {"searchForUsers"})
	public String searchForUsers(@Valid SltUsersPara sltUsersPara, ModelMap model) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("usersList");

		// Get user information
		List<UsersModel> usersList = adminUserService.srhUsersList(sltUsersPara);

		// Read image with byte
		for (UsersModel user : usersList) {
			String imgData = this.handleReadImage(user.getUserId(), configuration.getString("upload.path.img"));
			user.setUserImgData(imgData);
		}

		abilistsModel.setUsersList(usersList);

		model.addAttribute("model", abilistsModel);

		return "admin/users/sltUsersList";
	}

}