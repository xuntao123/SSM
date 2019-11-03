<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
		http://localhost:3306/crud
 -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<body>
	
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Modal title</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									 form-control" id="email_update_input"
									placeholder="email@guigu.com">
									<span id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input"
									value="M" checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input"
									value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add_select">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id=emp_update_btn>更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Modal title</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="empName">
									<span id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									 form-control" id="email_add_input"
									placeholder="email@guigu.com">
									<span id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input"
									value="M" checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input"
									value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add_select">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id=emp_save_btn>保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="checkAll" >
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
					<%-- <c:forEach items="${pageinfo.list }" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.gender=="M"?"男":"女" }</th>
							<th>${emp.email }</th>
							<th>${emp.department.deptName }</th>
							<th>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</th>
						</tr>
					</c:forEach> --%>
				</table>
			</div>
		</div>

		<!-- 显示分页信息 -->
		<div class="row">
			<!--分页文字信息  -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
				<%--<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
					<c:if test="${pageinfo.hasPreviousPage }">
						<li><a href="${APP_PATH }/emps?pn=${pageinfo.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>


					<c:forEach items="${pageinfo.navigatepageNums }" var="page_Num">
						<c:if test="${page_Num == pageinfo.pageNum }">
							<li class="active"><a href="#">${page_Num }</a></li>
						</c:if>
						<c:if test="${page_Num != pageinfo.pageNum }">
							<li><a href="${APP_PATH }/emps?pn=${page_Num }">${page_Num }</a></li>
						</c:if>

					</c:forEach>
					<c:if test="${pageinfo.hasNextPage }">
						<li><a href="${APP_PATH }/emps?pn=${pageinfo.pageNum+1 }"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
					<li><a href="${APP_PATH }/emps?pn=${pageinfo.pages}">末页</a></li>
				</ul>
				</nav>--%>
			</div>
		</div>

	</div>
	<script type="text/javascript">
	var totalRecord,currentpage;
		$(function() {
			to_page(1)
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					build_emps_table(result);
					build_page_info(result);
					build_page_nav(result)
				}

			});
		}
		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageinfo.list;
			$.each(emps,function(index, item) {
								//var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
								var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>")
								var empIdTd = $("<td></td>").append(item.empId);
								var empNameTd = $("<td></td>").append(item.empName);
								var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
								var emailTd = $("<td></td>").append(item.email);
								var deptNameTd = $("<td></td>").append(item.department.deptName);
								/**
								<button class="">
													<span class="" aria-hidden="true"></span>
													编辑
												</button>
								 */
								var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
.append("编辑");
								 editBtn.attr("edit-id",item.empId)
								//为编辑按钮添加一个自定义的属性，来表示当前员工id
								editBtn.attr("edit-id", item.empId);
								var delBtn = $("<button></button>")
										.addClass(
												"btn btn-danger btn-sm delete_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-trash"))
										.append("删除");
								//为删除按钮添加一个自定义的属性来表示当前删除的员工id
								delBtn.attr("del-id", item.empId);
								var btnTd = $("<td></td>").append(editBtn)
										.append(" ").append(delBtn);
								//var delBtn = 
								//append方法执行完成以后还是返回原来的元素
								$("<tr></tr>").append(checkBoxTd).append(
										empIdTd).append(empNameTd).append(
										genderTd).append(emailTd).append(
										deptNameTd).append(btnTd).appendTo(
										"#emps_table tbody");
							});
		}
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前" + result.extend.pageinfo.pageNum + "页,总"
							+ result.extend.pageinfo.pages + "页,总"
							+ result.extend.pageinfo.total + "条记录");
			totalRecord=result.extend.pageinfo.total;
			currentpage=result.extend.pageinfo.pageNum
		}
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");

			//构建元素
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			if (result.extend.pageinfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//为元素添加点击翻页的事件
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageinfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (result.extend.pageinfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageinfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageinfo.pages);
				});
			}

			//添加首页和前一页 的提示
			ul.append(firstPageLi).append(prePageLi);
			//1,2，3遍历给ul中添加页码提示
			$.each(result.extend.pageinfo.navigatepageNums, function(index,
					item) {

				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageinfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页 的提示
			ul.append(nextPageLi).append(lastPageLi);

			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		};

		$("#emp_add_modal_btn").click(function() {
			$("#empAddModal form").find("*").removeClass("has-error has-success")
			$("#empAddModal form").find(".help-block").text("")
			$("#empAddModal form")[0].reset();
		    
getDepts("#empAddModal select");
			$("#empAddModal").modal({
				backdrop : "static"
			})
		});
		function getDepts(ele) {
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});

				}
			})
		};
		function show_validate_msg(ele,status,msg){
			$(ele).parent().removeClass("has-error has-success");
			$(ele).next().text("");
			if(status=="has-success"){
				$(ele).parent().addClass(status);
				$(ele).next().text("");
			}else{
				$(ele).parent().addClass(status);
				$(ele).next().text(msg);
			}
		}
		function validate_add_form(){
			
			var empName=$("#empName_add_input").val();
			var regName=/(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]+){2,5}/;
			if(!regName.test(empName)){
				/* alert("用户名geshi不正确");	 */
				show_validate_msg("#empName_add_input","has-error","用户名错误")
				return false;
			}else{
				show_validate_msg("#empName_add_input","has-success","")
			}
			var email=$("#email_add_input").val();
			var regEmail =/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_add_input","has-error","邮箱错误")
				return false;
			}else{
				show_validate_msg("#email_add_input","has-success","")
			}
			return true;
		}
		function test_houduan(){
			var empName=$("#empName_add_input").val();
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					
					 if(result.code==100){
						show_validate_msg("#empName_add_input","has-success","用户名可用")
						$("#emp_save_btn").attr("ajax-va","success");
					}
					else{
						show_validate_msg("#empName_add_input","has-error","用户名重复")
						$("#emp_save_btn").attr("ajax-va","error");
						
						
					} 
				}
			})
		}
		$("#empName_add_input").change(function(){
			
			var empName=this.value;
			var regName=/(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]+){2,5}/;
			if(!regName.test(empName)){
				/* alert("用户名geshi不正确");	 */
				show_validate_msg("#empName_add_input","has-error","用户名错误")
				$("#emp_save_btn").attr("ajax-va","error");
				return false;
			}else{
				test_houduan()
				if($("helpBlock2").val="用户名错误"){
					return false;
				}
				//show_validate_msg("#empName_add_input","has-success","")
			}
			var email=$("#email_add_input").val();
			var regEmail =/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_add_input","has-error","邮箱错误")
				test_houduan()
				return false;
			}else{
				show_validate_msg("#email_add_input","has-success","")
			}
			/* $.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					
					 if(result.code==100){
						show_validate_msg("#empName_add_input","has-success","用户名可用")
						$("#emp_save_btn").attr("ajax-va","success");
					}
					else{
						show_validate_msg("#empName_add_input","has-error","用户名重复")
						$("#emp_save_btn").attr("ajax-va","error");
					} 
				}
			}) */
			return true;
		})
		$("#emp_save_btn").click(function(){
			/* alert($("#empAddModal form").serialize()); */
			/* if(!validate_add_form()){
				return false;
			} */
			var empName=this.value;
			var regName=/(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]+){2,5}/;
			if(!regName.test(empName)){
				/* alert("用户名geshi不正确");	 */
				show_validate_msg("#empName_add_input","has-error","用户名错误")
				$("#emp_save_btn").attr("ajax-va","error");
				return false;
			}else{
				test_houduan()
				if($("#helpBlock2").val="用户名错误"){
					return false;
				}
			}
			if($(this).attr("ajax-va")=="error"){
			return false;
		}
			  $.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					$("#empAddModal").modal('hide');
					to_page(totalRecord);
				}
			});  
				
			});
		
		$(document).on("click",".edit_btn",function(){
			getDepts("#empUpdateModal select")
			getEmp($(this).attr("edit-id"));
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop:"static"
			})
		})
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					
					  
					 $("#empName_update_static").text(result.extend.emp.empName);
					$("#email_update_input").val(result.extend.emp.email);  
					$("#empUpdateModal input[name=gender]").val([result.extend.emp.gender]);
					$("#empUpdateModal select").val([result.extend.emp.dId]);
				}
			})
			
		}
		
		
		$("#emp_update_btn").click(function(){
			var email=$("#email_update_input").val();
			var regEmail =/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input","has-error","邮箱错误")
				return false;
			}else{
				show_validate_msg("#email_update_input","has-success","")
			}
			
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					$("#empUpdateModal").modal("hide")
					
					to_page(currentpage);
				}
				
				
			})
			
		})
		
		
		$(document).on("click",".delete_btn",function(){
			var empName=$(this).parents("tr").find("td:eq(1)").text();
			if(confirm("确定删除"+empName+"吗")){
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("del-id"),
					type:"DELETE",
					success:function(result){
						to_page(currentpage);
						
					}
				})
			}
		})
		
		
			
			
			$("#checkAll").click(function(){
				
				$(".check_item").prop("checked",$(this).prop("checked"))
			})
			
			$(document).on("click",".check_item",function(){
				var flag=$(".check_item:checked").length==$(".check_item").length
					$("#checkAll").prop("checked",flag)
				
			})
			$("#emp_delete_all_btn").click(function(){
				var empNames="";
				var del_idstr="";
				$.each($(".check_item:checked"),function(){
					empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
					del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-"
				})
				empNames=empNames.substring(0,empNames.length-1);
				del_idstr=del_idstr.substring(0,del_idstr.length-1);
				if(confirm("确定删除"+empNames+"吗")){
					$.ajax({
						url:"${APP_PATH}/emp/"+del_idstr,
						type:"DELETE",
						success:function(result){
							to_page(currentpage);
							
						}
					})
				}
			})
		
	</script>
</body>
</html>