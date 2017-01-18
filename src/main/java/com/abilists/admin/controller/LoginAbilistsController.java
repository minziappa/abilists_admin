package com.abilists.admin.controller;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.abilists.admin.service.LoginService;
import com.abilists.core.bean.AbilistsModel;
import com.abilists.core.bean.model.UserTemp;
import com.abilists.core.bean.para.login.SignUpPara;
import com.abilists.core.common.bean.CommonBean;
import com.abilists.core.controller.AbstractBaseController;

import io.utility.security.TokenUtility;

/**
 * Login and Logout
 * 
 * @author Joon
 *
 */
@SessionAttributes(value = {"commonBean", "userPicture"})
@Controller
@RequestMapping("/login")
public class LoginAbilistsController extends AbstractBaseController {

	final String TOKEN_KEY = "tokenKey";
	final Logger logger = LoggerFactory.getLogger(LoginAbilistsController.class);

	@Autowired
	private MessageSource message;
	@Autowired
	private LoginService loginService;
	@Autowired
	private CommonBean commonBean;

	/**
	 * Login page and to register new
	 * 
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value = {"/", "", "index"}, method=RequestMethod.GET)
	public String index(HttpSession session, ModelMap model) throws Exception {
		AbilistsModel abilistsModel = new AbilistsModel();

		abilistsModel.setNavi("abilists");

	   	model.addAttribute("model", abilistsModel);
		model.addAttribute("commonBean", commonBean);
		return "login/index";
	}

	/**
	 * To input a user id and password.
	 * 
	 * @param signUpPara
	 * @param bindingResult
	 * @param model
	 * @param response
	 * @param redirectAttributes
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"introSingup"})
	public String introSingup(@Valid SignUpPara signUpPara, BindingResult bindingResult, 
			ModelMap model, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("abilists");

		// If it occurs a error, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("sendEmail - it is occured a parameter error.");
			response.setStatus(400);

			Map<String, String> mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors());
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Check if there is a user information in USER table.
		if(!loginService.validateEmail(signUpPara.getUserEmail())) {
			logger.error("confirmSingup - your email=" + signUpPara.getUserEmail());
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, LOCALE));
			return "errors/error";
		}

		UserTemp userTemp = loginService.sltUserTemp(signUpPara.getToken());
		if(userTemp != null) {
			logger.error("loginService.sltUserTemp - there is no temporary user data. userEmail=" + signUpPara.getUserEmail());
			model.addAttribute("errorMessage", "Reloaded");
			abilistsModel.setUserTemp(userTemp);
			model.addAttribute("model", abilistsModel);
			return "login/introSingup";
		}

		String token = TokenUtility.generateToken(TokenUtility.SHA_256);
		signUpPara.setToken(token);

		// Register a temporary user information
		signUpPara.setUserStatus("0"); // 0: to register
		loginService.insertUserTemp(signUpPara);

//		// Send an email to user by asynchronous
//		loginService.sendEmail(signUpPara);

		// Set a token at hidden of Input tag.
		userTemp = new UserTemp();
		userTemp.setUserTempToken(token);
		abilistsModel.setUserTemp(userTemp);

		model.addAttribute("model", abilistsModel);

		return "login/introSingup";
	}

//	/**
//	 * The business logic for login.
//	 * @param loginPara
//	 * @param bindingResult
//	 * @param response
//	 * @param model
//	 * @param session
//	 * @param redirectAttributes
//	 * @return
//	 * @throws Exception
//	 */
//	@RequestMapping(value = {"login"})
//	public String login(@Valid LoginPara loginPara, BindingResult bindingResult, 
//			HttpServletResponse response, ModelMap model, HttpSession session, 
//			RedirectAttributes redirectAttributes) throws Exception {
//
//		String errorMessage = "";
//		// session clear
//		session.removeAttribute("user");
//		session.removeAttribute("notiCnt");
//
//		// If it occurs errors, set the default value.
//		if (bindingResult.hasErrors()) {
//			logger.error("login - it is occured a parameter error.");
//			response.setStatus(400);
//			Locale locale = Locale.forLanguageTag(this.handleLang(session));
//			// Map<String, String> mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
//			// model.addAttribute("mapErrorMessage",  mapErrorMessage);
//			errorMessage = message.getMessage("parameter.login.id.pwd.error.message", null, locale);
//			model.addAttribute("errorMessage", errorMessage);
//			return "login/index";
//		}
//
//		// Check if user has a right password
//		if(!loginService.validatePwd(loginPara)) {
//			logger.error("There is no the account or different password");
//			Locale locale = Locale.forLanguageTag(this.handleLang(session));
//			errorMessage = message.getMessage("parameter.login.id.pwd.error.message", null, locale);
//			model.addAttribute("errorMessage", errorMessage);
//			return "login/index";
//		}
//
//		CommonPara commonPara = new CommonPara();
//		commonPara.setUserId(loginPara.getUserId());
//		UsersModel usersModel = profileService.sltUser(commonPara);
//
//		List<NotificationJoinUserNotiModel> userNotiList = notiService.sltUserNotiList(commonPara);
//
//		session.setAttribute("notiCnt", userNotiList.size());
//		session.setAttribute("userNotiList", userNotiList);
//		session.setAttribute("user", usersModel);
//		// Set user image into session
//		session.setAttribute("myPicture", 
//				this.handleReadImage(commonPara.getUserId(), configuration.getString("upload.path.img")));
//
//		session.setMaxInactiveInterval(100*60);
//
//		return "redirect:/abilists";
//	}

	/**
	 * Log out
	 * 
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"logout"})
	public String logout(ModelMap model, HttpSession session) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();

		abilistsModel.setMenu("login");

		// Clear data in the session.
		session.invalidate();

		return "redirect:/";
	}

	@RequestMapping(value = {"sendEmailResetPwd"})
	public String sendEmailResetPwd(ModelMap model, HttpSession session) throws Exception {

		return "login/sendEmailResetPwd";
	}

	@RequestMapping(value = {"denied"})
	public String denied(ModelMap model, HttpSession session) throws Exception {

		return "login/denied";
	}

}