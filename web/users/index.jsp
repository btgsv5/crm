<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="jquery/bootstrap_3.3.0/css/bootstrap.min.css">
	<script src="ECharts/echarts.js"></script>
	<script src="jquery/jquery-1.11.1-min.js" type="text/javascript"></script>
	<script src="jquery/bootstrap_3.3.0/js/bootstrap.min.js" type="text/javascript"></script>
	<link rel="shortcut icon" href="#" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
</head>

<script>
	$(function () {
		$('.nav-pills li').click(function () {
			$(this).siblings().removeClass('active');
			$(this).addClass('active');
		});

		$("#loginOut").click(function () {
			$.ajax({
				url:"settings/user/loginOut.do",
				type: "get",
				dataType:"json",
				success:function (data){
					if(data.success){
						window.location.href='login.jsp';
					}else{
						alert("退出失败");
					}
				}
			})
		});

		// 默认打开第一个工作台
		window.open("users/main.jsp","workareaFrame");

	})
</script>
</head>
<body>
<!-- 我的资料 -->
<div class="modal fade" id="myInformation" role="dialog">
	<div class="modal-dialog" role="document" style="width: 30%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">我的资料</h4>
			</div>
			<div class="modal-body">
				<div style="position: relative; left: 40px;">
					用户名：<b>${user.username}</b><br><br>
					性别：<b>${user.sex}</b><br><br>
					邮箱：<b>${user.email}</b><br><br>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- 修改密码的模态窗口 -->
<div class="modal fade" id="editPwdModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 70%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">修改密码</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form">
					<div class="form-group">
						<label for="oldPwd" class="col-sm-2 control-label">原密码</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="oldPwd" style="width: 200%;">
						</div>
					</div>

					<div class="form-group">
						<label for="newPwd" class="col-sm-2 control-label">新密码</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="newPwd" style="width: 200%;">
						</div>
					</div>

					<div class="form-group">
						<label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='login.jsp';">更新</button>
			</div>
		</div>
	</div>
</div>

<!-- 退出系统的模态窗口 -->
<div class="modal fade" id="exitModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 30%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">离开</h4>
			</div>
			<div class="modal-body">
				<p>您确定要退出系统吗？</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" id="loginOut">确定</button>
			</div>
		</div>
	</div>
</div>

<!-- 顶部 -->
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
	<div style=" top: 8px; left: 20px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">考试系统&nbsp;</div>
	<div style="top:5px;position: absolute;margin: auto;left: 150px">
		<ul class="nav nav-pills">
		<li role="presentation" class="active"><a href="users/main.jsp" target="workareaFrame"><span class="glyphicon glyphicon-home"></span>主页</a></li>
		<li role="presentation"><a href="st/getExam.jsp"  target="workareaFrame"><span class="glyphicon glyphicon-pencil"></span>考试练习</a></li>
		<li role="presentation"><a href="users/rank.jsp"  target="workareaFrame"><span class="glyphicon glyphicon-signal" style="margin-right: 3px;"></span>查看排名</a></li>
		</ul>
	</div>
	<div style="position: absolute; top: 15px; right: 50px;">


		<ul>

			<li class="dropdown user-dropdown">
				<a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
					<span class="glyphicon glyphicon-user"></span>${user.username}<span class="caret"></span>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</a>
				<ul class="dropdown-menu">
					<li><a href="settings/index.html"><span class="glyphicon glyphicon-wrench"></span>系统设置</a></li>
					<li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file"></span> 我的资料</a></li>
					<li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
					<li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> 退出</a></li>
				</ul>
			</li>
		</ul>
	</div>
</div>


	<!-- 工作区 -->
	<div id="workarea" style="position: absolute;  width: 100%; height: 100%;">
		<iframe name="workareaFrame" style="border-width: 0px;width: 100%; height: 100%"></iframe>
	</div>

</body>

</html>