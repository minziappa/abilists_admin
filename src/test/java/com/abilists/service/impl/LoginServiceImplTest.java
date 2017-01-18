package com.abilists.admin.service.impl;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/applicationContext.xml"})
public class LoginServiceImplTest {

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {

	}

	@Test
	public void testsltSample() throws Exception {
		if(passwordEncoder.matches("aabbccAABBCC123", "$2a$10$lyKt3olk3TwlVo0S4arl9OCzYIy188RQrJ.n62B0Q67.ndOPWcdce")) {
			System.out.println("true");
		} else {
			System.out.println("false");
		}
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		
	}

}
