<%@ page import="com.zj.domain.Score" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() + request.getContextPath() + "/";
    List<Score> datalist = (List<Score>) request.getAttribute("datalist");
%>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>"/>
    <meta charset="UTF-8">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

    <script>
        $(function () {
            $.ajax({
                url:"admin/getExaminee.do",
                data:{
                    "id":"${u.id}"
                },
                type:"get",
                dataType:"json",
                success:function (data) {
                    if (data.success){
                        var html = "";
                        $.each(data.dataList,function (i,n){
                            html += '<tr class="active">';
                            html += '<td>第'+(i+1)+'次</td>';
                            html += '<td>'+n.username+'</td>';
                            html += '<td>'+n.sex+'</td>';
                            html += '<td>'+n.email+'</td>';
                            html += '<td>'+n.createTime+'</td>';
                            html += '<td>'+n.score+'</td>';
                            html += '</tr>';
                        })
                        $("#getRankListBody").html(html);

                    }else {
                        $("#msg").html(data.msg);
                    }
                }
            })
        })
    </script>
</head>
<body>

<div>
    <!-- 返回按钮 -->
    <div style="position: relative; top: 35px; left: 10px;">
        <a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
    </div>
    <!-- 大标题 -->
    <div style="position: relative; left: 40px; top: -30px;">
        <div class="page-header">
            <h3>${u.username}的最近7次成绩信息</h3>
        </div>
    </div>
</div>


<table style="margin-left: 10px;" class="table table-hover">
    <thead>
    <tr style="color: #B3B3B3;">
        <td>考试次数</td>
        <td>名字</td>
        <td>性别</td>
        <td>邮箱</td>
        <td>作答时间</td>
        <td>成绩</td>
    </tr>
    </thead>
    <tbody id="getRankListBody">

    </tbody>

</table>
<div class="checkbox"  style="position: relative;top: 30px; left: 10px;text-align: center">

    <span id="msg" style="color:red;"></span>

</div>
</body>
</html>
