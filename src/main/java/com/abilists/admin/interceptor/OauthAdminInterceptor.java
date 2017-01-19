package com.abilists.admin.interceptor;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

import com.abilists.core.bean.model.UsersModel;

public class OauthAdminInterceptor implements HandlerInterceptor {

	final Logger logger = LoggerFactory.getLogger(OauthAdminInterceptor.class);
	
	String DEFAULT_TAG = "lang";
	String LANG = "en-US";
	String LANG_SET = "en";

	private void setLocaleWithLang(HttpServletRequest request, HttpServletResponse response, 
			String lang) throws Exception{
		HttpSession session = request.getSession();

		Locale locale = Locale.forLanguageTag(lang);
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
		localeResolver.setLocale(request, response, locale);

		// Set locale language in menu.
		session.setAttribute(DEFAULT_TAG, lang);
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object object, ModelAndView modelAndView) throws Exception {

		// Set the language tag for displaying it.
		Locale locale = RequestContextUtils.getLocale(request);
		logger.debug("LanguageTag in postHandle >>>> " + locale.toLanguageTag());

		// Set locale language into Session
		HttpSession session = request.getSession();
		session.setAttribute(DEFAULT_TAG, locale.toLanguageTag());
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception {

		String pathInfo = request.getPathInfo();
		logger.info("pathInfo >>> " + pathInfo);
		logger.debug("protocal >>> " + request.getScheme());

		HttpSession session = request.getSession();

		// Get a language you did.
		String paraLang = request.getParameter(DEFAULT_TAG);
		logger.debug("paraLang >> " + paraLang);
		if(paraLang != null) {
			// Set locale by your browser.
			this.setLocaleWithLang(request, response, paraLang);
		}

		// Get an object of the locale from session.
		Object objValue = session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
		logger.debug("objValue >> " + objValue);
		// Set Locale into your browser automatically.
		if(objValue == null && paraLang == null) {
			// Get your language.
			String acceptLanguage = request.getHeader("Accept-Language");
			if (acceptLanguage == null) {
				acceptLanguage = LANG;
			}
			String languageSet = acceptLanguage.split("-")[0];
			logger.debug("languageSet >> " + languageSet);

			// Set locale by your browser.
			this.setLocaleWithLang(request, response, languageSet);
			logger.debug("languageTag in preHandle >>> " + languageSet);
		}

//		// When the rewrite rule is not used,
//		// Can access without login.
//		if(pathInfo.startsWith("/login") && "http".equals(request.getScheme())) {
//			logger.info("redirect to https");
//			RedirectView redirectView = new RedirectView();
//			StringBuffer sb = new StringBuffer();
//			sb.append("https://").append(request.getServerName()).append(pathInfo);
//			logger.info("https url >>> " + sb.toString());
//			redirectView.setUrl(sb.toString());
//			redirectView.setHttp10Compatible(false);
//			ModelAndView mv = new ModelAndView(redirectView);
//			ModelAndViewDefiningException mvde = new ModelAndViewDefiningException(mv);
//			throw mvde;
//		}

		// Can access without login.
		if(pathInfo.startsWith("/admin/login")
				|| pathInfo.equals("/admin/")
				|| pathInfo.startsWith("/static")) {
			return true;
		}

		// Get userInfo from session
		UsersModel user = (UsersModel) session.getAttribute("user");
		// This is product version.
		if(user != null) {
			session.setAttribute("user", user);
			logger.debug("PathInfo=" + pathInfo + ", userId = " + user.getUserId());
			session.setMaxInactiveInterval(100*60);
		}else {
			logger.debug("redirect");
			RedirectView redirectView = new RedirectView();
			redirectView.setUrl("/admin/login/");
			// redirectView.setHttp10Compatible(false);
			ModelAndView mv = new ModelAndView(redirectView);
			ModelAndViewDefiningException mvde = new ModelAndViewDefiningException(mv);
			throw mvde;
		}

		return true;
	}

	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	}

}