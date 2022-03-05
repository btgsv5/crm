<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
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
            pageList(1,10);
        })

        function pageList(pageNo,pageSize){
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
                        html += '<tr class="active">';
                        // html += '<td><input type="checkbox" name="xz" value="'+n.id+'"/></td>';
                        html += '<td id="td_'+ count +'">'+ count + '</td>';
                        html += '<td>'+n.username+'</td>';
                        html += '<td>'+n.sex+'</td>';
                        html += '<td>'+n.email+'</td>';
                        html += '<td>'+n.createTime+'</td>';
                        html += '<td>'+n.score+'</td>';
                        html += '</tr>';

                    })
                    $("#questionBody").html(html);

                    //计算总页数
                    var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;


                    //数据添加完毕后，结合分页插件，对前端显示分页信息
                    $("#rankPage").bs_pagination({
                        currentPage: pageNo, // 页码
                        rowsPerPage: pageSize, // 每页显示的记录条数
                        maxRowsPerPage: 20, // 每页最多显示的记录条数
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
    </script>

</head>
<body>

<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>总排名列表</h3>
        </div>
    </div>
</div>

<div style="position: relative;top: 10px;">
    <table class="table table-hover">
        <thead>
        <tr style="color: #B3B3B3;">
            <td>排名</td>
            <td>名字</td>
            <td>邮箱</td>
            <td>性别</td>
            <td>作答日期</td>
            <td>成绩</td>
        </tr>
        </thead>
        <tbody id="questionBody">


        </tbody>
    </table>
</div>

<div style="height: 50px; position: relative;top: 30px;">
    <div id="rankPage">

    </div>

</div>
</body>
</html>
