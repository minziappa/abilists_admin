package com.abilists.admin.controller;

import java.io.IOException;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.validation.Validator;

import com.abilists.core.bean.para.users.InputUsersInfoPara;
import com.abilists.core.controller.BaseValidator;

public class MasterAbilistsValidator implements Validator, BaseValidator {

	final Logger logger = LoggerFactory.getLogger(MasterAbilistsValidator.class);

	@Autowired
	private MessageSource message;
	@Autowired
    private Configuration configuration;

	@Override
	public boolean supports(Class<?> clazz) {
		if(InputUsersInfoPara.class.equals(clazz)) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public void validate(Object object, Errors errors) {
		if (object instanceof InputUsersInfoPara) {
			InputUsersInfoPara editUserPara = (InputUsersInfoPara) object;

	        if(editUserPara != null) {
	    		if(editUserPara.getUserCode() == null){
					errors.rejectValue("validate", "parameter.error.message");
					logger.warn("the name is error.");
					// If you want to set the default value, remove the comment
	    			// sltUserPara.setUserName("user");
	    		}
	        }

		}
	}

	public Map<String, String> validateBusiness(Errors errors, Object object, HttpSession session) {

		Map<String, String> mapErrorMsg = new HashMap<String, String>();

		if (object instanceof InputUsersInfoPara) {

			for (Object objectError : errors.getAllErrors()) {

		        FieldError fieldError = (FieldError) objectError;
				Field[] declaredFields = InputUsersInfoPara.class.getDeclaredFields();

		        for(Field fieldPara:declaredFields){
		        	if(fieldError.getField().equals(fieldPara.getName())) {
		        		mapErrorMsg.put(fieldError.getField(), fieldError.getDefaultMessage());
		        	}
		        }
			}
		}

		return mapErrorMsg;
	}

	@Override
	public boolean validateSimple(String path, Configuration configuration) throws IOException {
		// TODO Auto-generated method stub
		return false;
	}


}
