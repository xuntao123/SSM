package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.bean.EmployeeExample.Criteria;
import com.atguigu.crud.dao.EmployeeMapper;
import com.github.pagehelper.PageHelper;
@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;

	public List<Employee> getall() {
		// TODO Auto-generated method stub
		
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void save(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}

	public boolean checkuser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example=new EmployeeExample();
		Criteria createCriteria = example.createCriteria();
		createCriteria.andEmpNameEqualTo(empName);
		long countByExample = employeeMapper.countByExample(example);
		return countByExample==0;
	}

	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee selectByPrimaryKey = employeeMapper.selectByPrimaryKey(id);
		return selectByPrimaryKey;
	}

	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	public void deleteemp(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}

	public void deleteBath(List<Integer> list) {
		// TODO Auto-generated method stub
		EmployeeExample example=new EmployeeExample();
		Criteria createCriteria = example.createCriteria();
		createCriteria.andEmpIdIn(list);
		employeeMapper.deleteByExample(example);
	}

	
	
}
