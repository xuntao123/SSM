package com.atguigu.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.atguigu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
	@Autowired
	WebApplicationContext context;
	
	MockMvc mockMvc;
	@Before
	public void initMockMvc() throws Exception {
		mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testmvc() throws Exception {
		MvcResult andReturn = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","5")).andReturn();
		MockHttpServletRequest request = andReturn.getRequest();
		PageInfo pi =  (PageInfo) request.getAttribute("pageinfo");
		System.out.println(pi.getPageNum()+"当前页码");
		System.out.println(pi.getPages()+"总页码");
		System.out.println(pi.getTotal()+"总记录数");
		int[] navigatepageNums = pi.getNavigatepageNums();
		int ii=0;
		for (int i : navigatepageNums) {
			System.out.print(i+"");
			ii++;
			if (ii==5) {
				System.out.println();
				
			}
			
		}
		List<Employee> list = pi.getList();
		for (Employee object : list) {
			System.out.println("id  "+object.getEmpId()+"  name  "+object.getEmpName());
			
		}
	
		
	}

}
