<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getRequestURI();
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>"/>
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

    <script type="text/javascript">
        $(function () {
            $('[data-toggle="popover"]').popover()

            $("#searchBtn").click(function () {
                let tdv = $("#"+${user.id}).children(":first").text();
                if (tdv.length>0){
                    $("#searchBtn").attr("data-content","当前你的排名为"+tdv);
                }else {
                    $("#searchBtn").attr("data-content","当前未获取到你的成绩，请参加考试后再尝试！");
                }

            });

            pageList(1,10);
            function pageList(pageNo,pageSize){
                //将全选复选框的√干掉
                $("#qx").prop("checked",false);
                //查询前，将隐藏域中保存的信息取出来，重新赋予到搜索框中
                $("#search-title").val($.trim($("#hidden-title").val()));
                $("#search-owner").val($.trim($("#hidden-owner").val()));
                $("#search-startDate").val($.trim($("#hidden-startDate").val()));
                $("#search-type").val($.trim($("#hidden-type").val()));
                $.ajax({
                    url:"ksxt/getRankList.do",
                    data:{
                        "pageNo":pageNo,
                        "pageSize":pageSize
                    },
                    type:"get",
                    dataType:"json",
                    success:function (data){
                        /*
                            data
                                我们需要的，信息列表
                                [{1},{2},{3},{4}] List<question> aList
                                一会儿分页插件需要的，查询出来的总记录数
                                {"total":100} int total

                                {"total":100,"dataList":[{1},{2},{3},{4}]

                         */
                        var html = "";
                        $.each(data.dataList,function (i,n){
                            let count = pageNo*pageSize-pageSize+i+1;
                            html += '<tr id="'+n.uId+'" class="active">';
                            html += '<td id="td_'+ count +'">'+ count + '</td>';
                            html += '<td>'+n.username+'</td>';
                            html += '<td>'+n.sex+'</td>';
                            html += '<td>'+n.email+'</td>';
                            html += '<td>'+n.createTime+'</td>';
                            html += '<td>'+n.score+'</td>';
                            html += '</tr>';

                        });
                        //为当前用户成绩表格显示颜色
                        $("#getRankListBody").html(html);
                        var userId = "${user.id}";
                        $("#"+userId).addClass("success");
                        //计算总页数
                        var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;


                        //数据添加完毕后，结合分页插件，对前端显示分页信息
                        $("#rankPage").bs_pagination({
                            currentPage: pageNo, // 页码
                            rowsPerPage: pageSize, // 每页显示的记录条数
                            maxRowsPerPage: 50, // 每页最多显示的记录条数
                            totalPages: totalPages, // 总页数
                            totalRows: data.total, // 总记录条数

                            visiblePageLinks: 3, // 显示几个卡片

                            showGoToPage: true,
                            showRowsPerPage: true,
                            showRowsInfo: true,
                            showRowsDefaultInfo: true,

                            onChangePage : function(event, data){
                                pageList(data.currentPage , data.rowsPerPage);
                            }
                        });

                    }
                })

            }
        })
    </script>
</head>
<body>


<button style="float: right;margin-bottom: 20px" type="button"
        class="btn btn-success btn-lg" id="searchBtn"
        data-container="body" data-toggle="popover"
        data-placement="left" >双击查看当前页面自己成绩排名</button>


<table style="margin-top: 30px;margin-left: 50px;" class="table table-hover">
    <thead>
    <tr style="color: #B3B3B3;">
        <td>排名</td>
        <td>名字</td>
        <td>性别</td>
        <td>邮箱</td>
        <td>作答时间</td>
        <td>最高成绩</td>
    </tr>
    </thead>
    <tbody id="getRankListBody">

    </tbody>
</table>

<div style="height: 50px; position: relative;top: 30px;">
    <div id="rankPage"></div>
    <a style="float: right"  href="<%=path%>#top" class="back-to-top"> 点击回到顶部 </a>
</div>

</body>
</html>
