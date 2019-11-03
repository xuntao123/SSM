package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

@Service
public class DepartmentService {
	@Autowired
	DepartmentMapper departmentMapper;
	public List<Department> getDepts() {
		// TODO Auto-generated method stub
		List<Department> selectByExample = departmentMapper.selectByExample(null);
		return selectByExample;
		
		
	}
	
}
