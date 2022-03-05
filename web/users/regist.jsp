<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>用户注册</title>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <link rel="shortcut icon" href="#" />
</head>
<script type="text/javascript">
    $(function () {
        //页面加载完毕后，将用户文本框中的内容清空
        $(".form-horizontal")[0].reset();
        $("#registName").focus();
        $("#registBtn").click(function () {
            //获取账号和密码
            $("#msg").html("");
            var username = $.trim($("#registName").val());
            var password = $.trim($("#registPw").val());
            var email = $.trim($("#registEmail").val());
            var sex = $.trim($("input[name='sex']:checked")[0].nextSibling.nodeValue);
            var reg = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
            if (username==""||password==""||email==""||sex==""){
                $("#msg").html("所填信息不能为空，前后不能有空格！");
                return false;
            }else if(!reg.test(email)){
                $("#msg").html("邮箱格式有误，请重新填写！");
                return false;
            }
            $.ajax({
                url:"users/saveRegist.do",
                data:{
                    "username":username,
                    "password":password,
                    "email":email,
                    "sex":sex
                },
                type:"post",
                async:true,
                dataType:"json",
                success: function(data) {
                    if (data.success){
                        alert("注册成功，自动跳转登录页面...");
                        window.location.href="login.jsp";
                    }else{
                        $("#msg").html(data.msg);
                    }
                }
            })
        })
    })
</script>
<body>
<div style="width:900px;height:400px;margin: auto;border: 1px solid gray">
    <div>
        <div style="text-align: center" class="page-header">
            <h1>创建用户</h1>
        </div>
        <form action="" method="post" class="form-horizontal">
            <div class="form-group">
                <label for="registName" class="col-sm-2 control-label"><span style="color: red">*</span>用户名</label>
                <div class="col-sm-10">
                    <input type="text" name="name" class="form-control" id="registName" placeholder="请输入用户名">
                </div>
            </div>
            <div class="form-group">
                <label for="registEmail" class="col-sm-2 control-label"><span style="color: red">*</span>邮箱</label>
                <div class="col-sm-10">
                    <input type="text" name="email" class="form-control" id="registEmail" placeholder="请输入邮箱">
                </div>
            </div>
            <div class="form-group">
                <label for="registPw" class="col-sm-2 control-label"><span style="color: red">*</span>密码</label>
                <div class="col-sm-10">
                    <input type="password" name="password" class="form-control" id="registPw" placeholder="请输入密码">
                </div>
            </div>
            <div class="form-group">

                <label for="registpw" class="col-sm-2 control-label"><span style="color: red">*</span>性别</label>
                <div class="radio col-sm-10">
                <label>
                        <input type="radio" name="sex" id="sexm" value="man" checked="checked">男
                </label>
                <label>
                        <input type="radio" name="sex" id="sexw" value="wom">女
                </label>
            </div>
                </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox">
                        <span id="msg" style="color:red;"></span>
                    </div>
                </div>
            </div>
            <div class="form-group" style="margin: auto;">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="button" class="btn btn-default" id="registBtn">点击注册</button>
                    <button type="reset" class="btn btn-default">重置</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
