package com.atguigu.crud.controller;

import java.lang.reflect.Method;
import java.util.*;

import javax.print.attribute.standard.Media;
import javax.servlet.http.HttpServlet;
import javax.validation.Valid;

import org.aspectj.bridge.MessageWriter;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployyController {
	@Autowired
	EmployeeService employeeService;
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getempswithjson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getall();

		PageInfo<Employee> page = new PageInfo<Employee>(emps, 5);
		return Msg.success().add("pageinfo", page);
	}
	//@RequestMapping("/emps")
	/*public String getemps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getall();

		PageInfo<Employee> page = new PageInfo<Employee>(emps, 5);
		
		model.addAttribute("pageinfo", page);
	
		return "list";
	}*/
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		employeeService.save(employee);
		return Msg.success();
	}
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName")String empName) {
		boolean b=employeeService.checkuser(empName);
		if (b) {
			return Msg.success();
		}else {
			return Msg.fail();
		}
		
	}
	@RequestMapping(value="emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee=employeeService.getEmp(id);
		
		return Msg.success().add("emp", employee);
	}
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
		System.out.println(employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpbyId(@PathVariable("ids") String ids) {
		List<Integer> list=new ArrayList<Integer>();
		if (ids.contains("-")) {
			String[] split = ids.split("-");
			for (String string : split) {
				int id = Integer.parseInt(string);
				list.add(id);
				
				
			}
			employeeService.deleteBath(list);
		}else {
			int id = Integer.parseInt(ids);
			employeeService.deleteemp(id);
		}
		return Msg.success();
		
	}
	
}
