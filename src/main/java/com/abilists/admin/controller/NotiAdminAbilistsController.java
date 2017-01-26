package com.abilists.admin.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.abilists.core.bean.AbilistsModel;
import com.abilists.core.bean.model.NotificationModel;
import com.abilists.core.bean.para.noti.DltNotiPara;
import com.abilists.core.bean.para.noti.IstNotiPara;
import com.abilists.core.bean.para.noti.SltNotiPara;
import com.abilists.core.bean.para.noti.UdtNotiPara;
import com.abilists.core.common.bean.CommonPara;
import com.abilists.core.controller.AbstractBaseController;
import com.abilists.core.service.NotiService;

@Controller
@RequestMapping("/noti")
public class NotiAdminAbilistsController extends AbstractBaseController {

	final Logger logger = LoggerFactory.getLogger(NotiAdminAbilistsController.class);

	@Autowired
	private MessageSource message;
	@Autowired
	private NotiService notiService;

	/*
	 * Input a notification
	 */
	@RequestMapping(value = {"istNoti"})
	public String istNoti(@ModelAttribute @Valid IstNotiPara istNotiPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request, 
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltNotiList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("istNoti - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Set user id
		this.handleSessionInfo(request.getSession(), istNotiPara);

		// Execute the transaction
		if(!notiService.istNotification(istNotiPara)) {
			mapErrorMessage = new HashMap<String, String>();
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.update.error.message", null, LOCALE));
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		return "redirect:sltNotiList";
	}

	/*
	 * Update a notification
	 */
	@RequestMapping(value = {"udtNoti"})
	public String udtNoti(@Valid UdtNotiPara udtNoti, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request, 
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltNotiList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("udtNoti - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Execute the transaction
		if(!notiService.udtNotification(udtNoti)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:sltNotiList";
	}

	/*
	 * Delete a notification
	 */
	@RequestMapping(value = {"dltNoti"})
	public String dltNoti(@Valid DltNotiPara dltNotiPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltNotiList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("deletedNoti - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Execute the transaction
		if(!notiService.deleteNotification(dltNotiPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:sltNotiList";
	}

	/*
	 * Notification
	 */
	@RequestMapping(value = {"sltNotiList"})
	public String sltNotiList(@Valid CommonPara commonPara, ModelMap model) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltNotiList");

		// Set Paging list
		int intSum = notiService.sltNotificationSum();
		abilistsModel.setPaging(notiService.makePaging(commonPara, intSum));

		// Execute the transaction
		abilistsModel.setNotificationList(notiService.sltNotificationList(commonPara));

		model.addAttribute("model", abilistsModel);

		return "admin/noti/sltNotiList";
	}

	/*
	 * Notification by Ajax
	 */
    @RequestMapping(value="/sltNotiAjax")
	public @ResponseBody NotificationModel sltNotiAjax(@Valid @RequestBody SltNotiPara sltNotiPara, 
			BindingResult bindingResult) throws Exception {

		// If it occurs a error, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("sltNotiAjax - it is occured a parameter error.");
			return null;
		}

    	return notiService.sltNotification(sltNotiPara);
	}

}