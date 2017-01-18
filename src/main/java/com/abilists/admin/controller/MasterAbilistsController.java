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

import com.abilists.core.bean.AbilistsModel;
import com.abilists.core.bean.model.MIndustryModel;
import com.abilists.core.bean.model.MRoleModel;
import com.abilists.core.bean.model.MTechDetailModel;
import com.abilists.core.bean.model.MTechModel;
import com.abilists.core.bean.para.admin.DltMIndustryPara;
import com.abilists.core.bean.para.admin.DltMRolePara;
import com.abilists.core.bean.para.admin.DltMTechDetailPara;
import com.abilists.core.bean.para.admin.DltMTechPara;
import com.abilists.core.bean.para.admin.IstMIndustryPara;
import com.abilists.core.bean.para.admin.IstMRolePara;
import com.abilists.core.bean.para.admin.IstMTechDetailPara;
import com.abilists.core.bean.para.admin.IstMTechPara;
import com.abilists.core.bean.para.admin.SltMIndustryPara;
import com.abilists.core.bean.para.admin.SltMRolePara;
import com.abilists.core.bean.para.admin.SltMTechDetailPara;
import com.abilists.core.bean.para.admin.SltMTechPara;
import com.abilists.core.bean.para.admin.UdtMIndustryPara;
import com.abilists.core.bean.para.admin.UdtMRolePara;
import com.abilists.core.bean.para.admin.UdtMTechDetailPara;
import com.abilists.core.controller.AbstractBaseController;
import com.abilists.core.service.AdminMasterService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/admin/master")
public class MasterAbilistsController extends AbstractBaseController {

	final Logger logger = LoggerFactory.getLogger(MasterAbilistsController.class);

	@Autowired
	private MessageSource message;
	@Autowired
	private AdminMasterService adminMasterService;

	/*
	 * Tech
	 */
	@RequestMapping(value = {"sltMTechList"})
	public String sltMTechList(@Valid SltMTechPara sltMTechPara, 
			ModelMap model) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltMTechList");

		// Set Paging list
		int intSum = adminMasterService.sltMTechSum(sltMTechPara);
		abilistsModel.setPaging(adminMasterService.makePaging(sltMTechPara, intSum));

		// Execute the transaction
		abilistsModel.setmTechList(adminMasterService.sltMTechList(sltMTechPara));
		abilistsModel.setSltMTechPara(sltMTechPara);

		model.addAttribute("model", abilistsModel);

		return "admin/master/sltMTechList";
	}

	/*
	 * Role (position)
	 */
	@RequestMapping(value = {"sltMRoleList"})
	public String sltMRoleList(@Valid SltMRolePara sltMRolePara, 
			HttpSession session, ModelMap model) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltMRoleList");

		// Set Paging list
		int intSum = adminMasterService.sltMRoleSum(sltMRolePara);
		abilistsModel.setPaging(adminMasterService.makePaging(sltMRolePara, intSum));

		// Execute the transaction
		abilistsModel.setmRoleList(adminMasterService.sltMRoleList(sltMRolePara));
		abilistsModel.setSltMRolePara(sltMRolePara);

		model.addAttribute("model", abilistsModel);

		return "admin/master/sltMRoleList";
	}

	/*
	 * Detail on the Tech
	 */
	@RequestMapping(value = {"sltMTechDetailList/{mtNo}"})
	public String sltMTechDetailList(@PathVariable String mtNo, 
			@RequestParam(value="mlCode", required=false) String mlCode, ModelMap model) throws Exception {
	
		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltMTechList");
	
		// Get a project
		SltMTechPara sltMTechPara = new SltMTechPara();
		sltMTechPara.setMtNo(mtNo);
		MTechModel mTech = adminMasterService.sltMTech(sltMTechPara);
		abilistsModel.setmTech(mTech);
	
		// Get a tech list on a project.
		SltMTechDetailPara sltMTechDetailPara = new SltMTechDetailPara();
		sltMTechDetailPara.setMtNo(mtNo);
		sltMTechDetailPara.setMlCode(mlCode);

		List<MTechDetailModel> mTechDetailList = adminMasterService.sltMTechDetailList(sltMTechDetailPara);
		abilistsModel.setSltMTechDetailPara(sltMTechDetailPara);

		abilistsModel.setmTechDetailList(mTechDetailList);
		model.addAttribute("model", abilistsModel);
	
		return "admin/master/sltMTechDetailList";
	}

	/*
	 * Industry
	 */
	@RequestMapping(value = {"sltMIndustryList"})
	public String sltMIndustryList(@Valid SltMIndustryPara sltMIndustryPara, 
			ModelMap model) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltMIndustryList");

		// Set Paging list
		int intSum = adminMasterService.sltMIndustrySum(sltMIndustryPara);
		abilistsModel.setPaging(adminMasterService.makePaging(sltMIndustryPara, intSum));

		// Execute the transaction
		abilistsModel.setmIndustryList(adminMasterService.sltMIndustryList(sltMIndustryPara));
		abilistsModel.setSltMIndustryPara(sltMIndustryPara);

		model.addAttribute("model", abilistsModel);

		return "admin/master/sltMIndustryList";
	}

	/*
	 * Tech by Ajax
	 */
	@RequestMapping(value="/sltMTechAjax")
	public void sltMTechAjax(@RequestParam("body") String body, HttpSession session, 
			HttpServletResponse response) throws Exception {

    	ObjectMapper mapper = new ObjectMapper();
    	JSONParser parser=new JSONParser();
    	Object obj = parser.parse(body);
    	JSONObject jsonObject = (JSONObject) obj;
    	String mtNo = (String)jsonObject.get("mtNo");

    	SltMTechPara sltMTechPara = new SltMTechPara();
    	sltMTechPara.setMtNo(mtNo);

		MTechModel mTech = adminMasterService.sltMTech(sltMTechPara);
		Map<String, MTechModel> map = new LinkedHashMap<String, MTechModel>();
		map.put("result", mTech);

		//Convert object to JSON string
		String jsonInString = mapper.writeValueAsString(map);

		this.handleWriteAjax(jsonInString, response);
	}

	/*
	 * Detail on Tech by Ajax
	 */
	@RequestMapping(value = {"sltMTechDetailAjax"})
	public void sltMTechDetailAjax(@RequestParam("body") String body,
			HttpSession session, HttpServletResponse response) throws Exception {

		ObjectMapper mapper = new ObjectMapper();

		JSONParser parser=new JSONParser();
		Object obj = parser.parse(body);
		JSONObject jsonObject = (JSONObject) obj;
		String mtdNo = (String)jsonObject.get("mtdNo");

		SltMTechDetailPara sltMTechDetailPara = new SltMTechDetailPara();
		sltMTechDetailPara.setMtdNo(mtdNo);
		// Set user id
		this.handleSessionInfo(session, sltMTechDetailPara);

		MTechDetailModel mTechDetail = adminMasterService.sltMTechDetail(sltMTechDetailPara);
		Map<String, MTechDetailModel> map = new LinkedHashMap<String, MTechDetailModel>();
		map.put("result", mTechDetail);
	
		//Convert object to JSON string
		String jsonInString = mapper.writeValueAsString(map);

		this.handleWriteAjax(jsonInString, response);
	}

	/*
	 * Role
	 */
    @RequestMapping(value="/sltMRoleAjax")
	public void sltMRoleAjax(@RequestParam("body") String body, HttpSession session, 
			HttpServletResponse response) throws Exception {

    	ObjectMapper mapper = new ObjectMapper();
    	JSONParser parser=new JSONParser();
    	Object obj = parser.parse(body);
    	JSONObject jsonObject = (JSONObject) obj;
    	String mrNo = (String)jsonObject.get("mrNo");

    	SltMRolePara sltMRolePara = new SltMRolePara();
    	sltMRolePara.setMrNo(mrNo);

		MRoleModel mRole = adminMasterService.sltMRole(sltMRolePara);
		Map<String, MRoleModel> map = new LinkedHashMap<String, MRoleModel>();
		map.put("result", mRole);

		// Convert object to JSON string
		String jsonInString = mapper.writeValueAsString(map);

		this.handleWriteAjax(jsonInString, response);
	}

    /*
     * Industry
     */
    @RequestMapping(value="/sltMIndustryAjax")
	public void sltMIndustryAjax(@RequestParam("body") String body, HttpSession session, 
			HttpServletResponse response) throws Exception {

    	ObjectMapper mapper = new ObjectMapper();
    	JSONParser parser=new JSONParser();
    	Object obj = parser.parse(body);
    	JSONObject jsonObject = (JSONObject) obj;
    	String miNo = (String)jsonObject.get("miNo");

    	SltMIndustryPara sltMIndustryPara = new SltMIndustryPara();
    	sltMIndustryPara.setMiNo(miNo);

		MIndustryModel mIndustry = adminMasterService.sltMIndustry(sltMIndustryPara);
		Map<String, MIndustryModel> map = new LinkedHashMap<String, MIndustryModel>();
		map.put("result", mIndustry);

		// Convert object to JSON string
		String jsonInString = mapper.writeValueAsString(map);

		this.handleWriteAjax(jsonInString, response);
	}

    /*
     * Update a Tech information for master data
     */
	@RequestMapping(value = {"udtMTech"})
	public String udtMTech(@Valid SltMTechPara sltMTechPara, 
			BindingResult bindingResult, ModelMap model, HttpSession session,  
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("udtMTech");

		Map<String, String> mapErrorMessage = null;

		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("udtMTech - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors());
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "admin/master/sltMTechList";
		}
		// Set user id
		this.handleSessionInfo(session, sltMTechPara);

		// Execute the transaction
		if(!adminMasterService.udtMTech(sltMTechPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, LOCALE));
			return "admin/master/sltMTechList";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/master/sltMTechList";
	}

	/*
	 * Update a detail informaton on the Tech for master data
	 */
	@RequestMapping(value = {"udtMTechDetail"})
	public String udtMTechDetail(@Valid UdtMTechDetailPara udtMTechDetailPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("users");
		abilistsModel.setMenu("sltMTechDetailList");
		model.addAttribute("model", abilistsModel);

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("udtMTechDetail - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

//		// Set user id
//		this.handleSessionInfo(request.getSession(), udtMTechDetailPara);

		// Execute the transaction
		if(!adminMasterService.udtMTechDetail(udtMTechDetailPara)) {
			mapErrorMessage = new HashMap<String, String>();
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.error.message", null, locale));
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/master/sltMTechDetailList/" + udtMTechDetailPara.getMtNo();
	}

	@RequestMapping(value = {"udtMRole"})
	public String udtMRole(@Valid UdtMRolePara udtMRolePara, 
			BindingResult bindingResult, ModelMap model, HttpSession session,  
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("udtMRole");

		Map<String, String> mapErrorMessage = null;

		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("udtMRole - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors());
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}
		// Set user id
		this.handleSessionInfo(session, udtMRolePara);

		// Execute the transaction
		if(!adminMasterService.udtMRole(udtMRolePara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, LOCALE));
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/master/sltMRoleList";
	}

	@RequestMapping(value = {"udtMIndustry"})
	public String udtMIndustry(@Valid UdtMIndustryPara udtMIndustryPara, 
			BindingResult bindingResult, ModelMap model, HttpSession session,  
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltMIndustryList");

		Map<String, String> mapErrorMessage = null;

		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("udtMRole - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors());
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}
		// Set user id
		this.handleSessionInfo(session, udtMIndustryPara);

		// Execute the transaction
		if(!adminMasterService.udtMIndustry(udtMIndustryPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, LOCALE));
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/master/sltMIndustryList";
	}

	@RequestMapping(value = {"istMTech"})
	public String istMTech(@Valid IstMTechPara istMTechPara, 
			BindingResult bindingResult, ModelMap model, HttpSession session,  
			HttpServletResponse response) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltMTechList");

		Map<String, String> mapErrorMessage = null;

		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("updatedUserProjects - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors());
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Set user id
		this.handleSessionInfo(session, istMTechPara);

		// Execute the transaction
		if(!adminMasterService.istMTech(istMTechPara)) {
			mapErrorMessage = new HashMap<String, String>();
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.update.error.message", null, LOCALE));
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		return "redirect:/admin/master/sltMTechList";
	}

	@RequestMapping(value = {"istMTechDetail"})
	public String istMTechDetail(@Valid IstMTechDetailPara istMTechDetailPara, 
			BindingResult bindingResult, ModelMap model, HttpSession session,  
			HttpServletResponse response) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("users");
		abilistsModel.setMenu("istMTechDetail");

		Map<String, String> mapErrorMessage = null;

		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("istMTechDetail - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors());
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "admin/master/sltMTechDetailList";
		}

		// Execute the transaction
		if(!adminMasterService.istMTechDetail(istMTechDetailPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, LOCALE));
			return "admin/master/sltMTechDetailList";
		}

		return "redirect:/admin/master/sltMTechDetailList/" + istMTechDetailPara.getMtNo() + 
				"?mlCode=" + istMTechDetailPara.getMlCode();
	}

	@RequestMapping(value = {"istMRole"})
	public String istMRole(@Valid IstMRolePara istMRolePara, 
			BindingResult bindingResult, ModelMap model, HttpSession session,  
			HttpServletResponse response) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("users");
		abilistsModel.setMenu("sltUserProjectsList");

		Map<String, String> mapErrorMessage = null;

		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("istMRole - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors());
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Set user id
		this.handleSessionInfo(session, istMRolePara);

		// Execute the transaction
		if(!adminMasterService.istMRole(istMRolePara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, LOCALE));
			return "errors/error";
		}

		return "redirect:/admin/master/sltMRoleList";
	}

	@RequestMapping(value = {"istMIndustry"})
	public String istMIndustry(@Valid IstMIndustryPara istMIndustryPara, 
			BindingResult bindingResult, ModelMap model, HttpSession session,  
			HttpServletResponse response) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltMIndustryList");

		Map<String, String> mapErrorMessage = null;

		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("istMIndustry - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors());
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Set user id
		this.handleSessionInfo(session, istMIndustryPara);

		// Execute the transaction
		if(!adminMasterService.istMIndustry(istMIndustryPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, LOCALE));
			return "errors/error";
		}

		return "redirect:/admin/master/sltMIndustryList";
	}

	@RequestMapping(value = {"dltMTech"})
	public String dltMTech(@Valid DltMTechPara dltMTechPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltMTechList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("dltMTech - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Execute the transaction
		if(!adminMasterService.dltMTech(dltMTechPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/master/sltMTechList";
	}

	@RequestMapping(value = {"dltMTechDetail"})
	public String dltMTechDetail(@Valid DltMTechDetailPara dltMTechDetailPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltMTechList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("dltMTechDetail - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Execute the transaction
		if(!adminMasterService.dltMTechDetail(dltMTechDetailPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/master/sltMTechDetailList/" + dltMTechDetailPara.getMtNo();
	}

	@RequestMapping(value = {"dltMRole"})
	public String dltMRole(@Valid DltMRolePara dltMRolePara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltMRoleList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);
		
		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("dltMRole - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Execute the transaction
		if(!adminMasterService.dltMRole(dltMRolePara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/master/sltMRoleList";
	}

	@RequestMapping(value = {"dltMIndustry"})
	public String dltMIndustry(@Valid DltMIndustryPara dltMIndustryPara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("admin");
		abilistsModel.setMenu("sltMTechList");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("dltMTechDetail - it is occured a parameter error.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "errors/error";
		}

		// Execute the transaction
		if(!adminMasterService.dltMIndustry(dltMIndustryPara)) {
			model.addAttribute("errorMessage", message.getMessage("parameter.error.message", null, locale));
			return "errors/error";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/admin/master/sltMIndustryList";
	}

}