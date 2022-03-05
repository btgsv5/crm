<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>"/>
    <meta charset="UTF-8">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <link rel="shortcut icon" href="#" />
    <style>
        button {
            background-color: transparent;
        }

        button:focus {
            outline: 0;
            border: 1px #ddd solid;
        }

        #itemChoose button {
            width: 18px;
            height: 18px;
            text-align: center;
            font-size: 14px;
            border: 1px solid #39CB76;
            border-radius: 3px;
            color: #39CB76;
            float: left;
            margin: 6px 3px 6px 6px;
        }
        #markInfo {
            background: linear-gradient(to right, #D5EDDF, #D6EEE0 97.9%, #A4BAAD 98%, #D2E8DB 100%);
        }
    </style>
</head>
<script>

</script>
<body>
<form action="st/getExam.do" method="get">
<h1 style="text-align: center;"><span style="color: red;">*</span>考前须知</h1>
<div style="width: 500px;margin: auto">
    <p style="font-size: 30px">对在考试过程中被发现有作弊行为的考生，我们保留进一步调查和处理直至取消其考试成绩的权利。
    对于在考试结束后发现的作弊行为或重大作弊嫌疑，我们有权对相关考生进行调查，并暂停发布其成绩或取消已发布的成绩，直至调查完毕，
        考生应对此予以配合。
    对于拒绝配合的考生，我们有权取消该考生成绩。</p>
<button style="margin-left: 36%;" type="submit" class="btn btn-success">我已知悉，进入考试</button>
</div>
</form>


</body>
</html>
