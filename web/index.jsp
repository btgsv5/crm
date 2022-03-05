<%@ page contentType="text/html;charset=UTF-8" language="java"  isErrorPage="true"%>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>"/>
</head>
<body>
    <h1>学生管理系统</h1>
    <a href="add.do">添加信息</a>
    <a href="drop.do">删除信息</a>
    <a href="update.do">修改信息</a>
    <a href="find.do">查询信息</a>
</body>
</html>
