package com.abilists.admin.service;

import com.abilists.core.bean.model.UserTemp;
import com.abilists.core.bean.para.LoginPara;
import com.abilists.core.bean.para.login.CompleteConfirmPara;
import com.abilists.core.bean.para.login.CompleteResetPwdPara;
import com.abilists.core.bean.para.login.SignUpPara;

public interface LoginService {

	public boolean insertUserTemp(SignUpPara signUpPara) throws Exception;
	public void sendEmail(SignUpPara signUpPara) throws Exception;
	public void sendEmailForResetPwd(SignUpPara signUpPara) throws Exception;

	public boolean validateEmail(String userEmail) throws Exception;
	public boolean validatePwd(LoginPara loginPara) throws Exception;
	public UserTemp sltUserTemp(String token) throws Exception;

	public boolean updatePwd(CompleteResetPwdPara completeResetPwdPara) throws Exception;
}