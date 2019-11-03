package com.atguigu.crud.test;

import java.util.Random;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:applicationContext.xml")
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeemapper;
	@Autowired
	SqlSession sqlsession;
	@Test
	public void TestMapper() {
		System.out.println(departmentMapper);
		/*departmentMapper.insertSelective(new Department(null,"研发部"));
		departmentMapper.insertSelective(new Department(null,"开发部"));
		employeemapper.insertSelective(new Employee(null,"xu","m","223@qq.com", 1));*/
		EmployeeMapper mapper = sqlsession.getMapper(EmployeeMapper.class);
		for(int x=7;x<50;x++) {
			String substring = UUID.randomUUID().toString().substring(0,4);
			mapper.insertSelective(new Employee(x,substring,"M",substring+"223@qq.com",1));
		}
		System.out.println("wancheng");
	}
}
