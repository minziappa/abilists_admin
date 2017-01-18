package com.abilists.admin.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.abilists.core.controller.AbstractBaseController;

@Controller
@RequestMapping("/charts")
public class ChartsAdminAbilistsController extends AbstractBaseController {

	final Logger logger = LoggerFactory.getLogger(ChartsAdminAbilistsController.class);

	@RequestMapping(value = {"{sltcharts}"})
	public String usersList(@PathVariable String sltcharts, 
			HttpSession session, ModelMap model) throws Exception {

		return "admin/charts/" + sltcharts;
	}

}