package com.abilists.admin.service.impl;

import static org.junit.Assert.*;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/applicationContext.xml"})
public class SampleServiceImplTest {

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {

	}

	@Test
	public void testsltSample() throws Exception {
//		sltUserPara sltUser = new sltUserPara();
//		sltUser.setUserName("admin");
//		sltUser.setUserData("2014-08-10");
//		List<SampleBean> userList = sampleService.sltSampleByName(sltUser);
//		assertNotNull(userList);
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		
	}

}