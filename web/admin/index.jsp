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

    <script type="text/javascript">
        $(function(){
            //为创建按钮绑定一个事件,打开添加操作的模态窗口
            $("#addBtn").click(function (){
                $("#userAddForm")[0].reset();
                $("#create-name").focus();
                /*
                    操作模态窗口的方式：
                        需要操作模态窗口的jquery对象，调用modal方法，该方法传递参数， show:打开模态窗口， hide：隐藏模态窗口
                 */
                // $("#createquestionModal").modal("show");
                        //当所有者下拉框处理完毕后，展现模态窗口
                $("#createUserModal").modal("show");

            })

            $("#saveBtn").click(function(){
                //获取账号和密码
                $("#msg").html("");
                var username = $.trim($("#create-name").val());
                var password = $.trim($("#create-pw").val());
                var email = $.trim($("#create-email").val());
                var sex = $.trim($("input[name='sex']:checked")[0].nextSibling.nodeValue);
                var reg = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
                if (username==""||password==""||email==""||sex==""){
                    $("#addMsg").html("所填信息不能为空，前后不能有空格！");
                    return false;
                }else if(!reg.test(email)){
                    $("#addMsg").html("邮箱格式有误，请重新填写！");
                    return false;
                }
                $.ajax({
                    url:"settings/user/saveRegist.do",
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
                        /*
                          data
                                {"success":true/false}
                         */
                        if (data.success){
                            //添加成功后
                            //刷新信息列表（局部刷新）
                            //清空模态窗口中的数据
                            $("#userAddForm")[0].reset();
                            //关闭添加操作的模态窗口
                            $("#createUserModal").modal("hide");
                            pageList(1,$("#userPage").bs_pagination('getOption', 'rowsPerPage'));
                        }else{
                            $("#addMsg").html(data.msg);
                            alert("添加失败");
                        }
                    }
                })
            })
            //页面加载完毕后出发第一个方法
            //默认展开页表的第一页，每页展现两条记录
            pageList(1,5);

            //为查询按钮绑定事件，出发pageList方法
            $("#searchBtn").click(function (){
                /*
                    点击查询按钮的时候，我们应该将搜索框中的信息保存起来，保存到隐藏域中
                */
                $("#hidden-name").val($.trim($("#search-name").val()));

                pageList(1,$("#userPage").bs_pagination('getOption', 'rowsPerPage'));
            })

            $("#qx").on("click",function (){
                $("input[name=xz]").prop("checked",this.checked);
            })
            $("#userBody").on("click",$("input[name=xz]"),function (){
                $("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);
            })
            //为删除按钮绑定事件，执行市场活动删除操作
            $("#deleteBtn").click(function (){
                //找到复选框中所有挑√的复选框的jquery对象
                var $xz = $("input[name=xz]:checked");
                if ($xz.length==0){
                    alert("请选择要删除的记录")
                }else{
                    if(confirm("确定要删除所选的记录吗？")){
                        //拼接参数
                        var param = "";

                        //将$xz中的每一个dom对象遍历出来，取其value值相当于取得了需要删除记录的id
                        for (var i=0;i<$xz.length;i++){
                            param += "id="+ $($xz[i]).val();
                            if (i<$xz.length-1){
                                param += "&";
                            }
                        }
                        $.ajax({
                            url:"settings/user/deleteUser.do",
                            data:param,
                            type:"post",
                            dataType:"json",
                            success:function (data){
                                if (data.success){
                                    pageList(1,$("#userPage").bs_pagination('getOption', 'rowsPerPage'));
                                }else {
                                    alert("删除用户失败")
                                }
                            }
                        })
                    }

                }
            })

            //为修改按钮绑定事件，打开修改操作的模态窗口
            $("#editBtn").click(function (){
                var $xz = $("input[name=xz]:checked");
                if ($xz.length==0){
                    alert("请选择需要修改的记录")
                }else if ($xz.length>1){
                    alert("对不起，一次只能同时修改一个记录，请重新选择")
                }else if ($xz.length==1){
                    var id = $xz.val();
                    $.ajax({
                        url:"settings/user/getUser.do",
                        data:{
                            "id":id
                        },
                        type:"get",
                        dataType:"json",
                        success:function (data){
                            $("#edit-name").val(data.username);
                            $("#edit-email").val(data.email);
                            $("input[value='"+data.sex+"']").prop("checked",true);
                            //所有的值都填写好之后，打开修改操作的模态窗口
                            $("#editUserModal").modal("show");
                        }
                    })
                }
            })

            //给更新按钮添加点击事件
            $("#updateBtn").click(function (){
                var username = $.trim($("#edit-name").val());
                var sex = $.trim($("input[name='sex']:checked")[0].nextSibling.nodeValue);
                $.ajax({
                    url: "settings/user/updateUser.do",
                    data:{
                        "username":username,
                        "sex":sex
                    },
                    type: "post",
                    dataType: "json",
                    success:function (data){
                        /*
                            data
                                {"success":true/false}
                         */
                        if (data.success){
                            //修改成功后
                            //（局部刷新）
                            // pageList(1,2);
                            //关闭修改操作的模态窗口
                            $("#editUserModal").modal("hide");
                            pageList($("#userPage").bs_pagination('getOption', 'currentPage')
                                ,$("#userPage").bs_pagination('getOption', 'rowsPerPage'));

                        }else{
                            alert("修改用户信息失败");
                        }
                    }
                })
            })

        });


        function pageList(pageNo,pageSize){
            //将全选复选框的√干掉
            $("#qx").prop("checked",false);
            //查询前，将隐藏域中保存的信息取出来，重新赋予到搜索框中
            $("#search-name").val($.trim($("#hidden-name").val()));
            $.ajax({
                url:"settings/user/pageList.do",
                data:{
                    "pageNo":pageNo,
                    "pageSize":pageSize,
                    "username":$.trim($("#search-name").val())
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
                        html += '<tr class="active">';
                        html += '<td><input type="checkbox" name="xz" value="'+n.id+'"/></td>';
                        // html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'st/detail.do?id='+n.id+'\';">'+n.title+'</a></td>';
                        html += '<td> <a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'admin/examinee.do?id='+n.id+'\';">'+n.username +'</a></td>';
                        html += '<td>'+n.sex+'</td>';
                        html += '<td>'+n.email+'</td>';
                        html += '<td>'+n.createTime+'</td>';
                        html += '</tr>';

                    })
                    $("#userBody").html(html);

                    //计算总页数
                    var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;


                    //数据添加完毕后，结合分页插件，对前端显示分页信息
                    $("#userPage").bs_pagination({
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

<input type="hidden" id="hidden-name"/>


<!-- 创建用户的模态窗口 -->
<div class="modal fade" id="createUserModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 600px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">

                </button>
                <h4 class="modal-title" id="myModalLabel1">添加用户</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form" id="userAddForm">

                    <div class="form-group">
                        <label for="create-name" class="col-sm-2 control-label"><span style="color: red">*</span>用户名</label>
                        <div class="col-sm-10" style="width:450px">
                            <input type="text" name="name" class="form-control" id="create-name" placeholder="请输入用户名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-email" class="col-sm-2 control-label"><span style="color: red">*</span>邮箱</label>
                        <div class="col-sm-10" style="width:450px">
                            <input type="text" name="email" class="form-control" id="create-email" placeholder="请输入邮箱">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-pw" class="col-sm-2 control-label"><span style="color: red">*</span>密码</label>
                        <div class="col-sm-10" style="width:450px">
                            <input type="password" name="password" class="form-control" id="create-pw" placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">

                        <label class="col-sm-2 control-label"><span style="color: red">*</span>性别</label>
                        <div class="radio col-sm-10">
                            <label for="create-sexm">
                                <input type="radio" id="create-sexm" name="sex" value="man" checked="checked">男
                            </label>
                            <label for="create-sexw">
                                <input type="radio" id="create-sexw" name="sex" value="wom">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                                <span id="addMsg" style="color:red;"></span>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveBtn">添加</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改用户的模态窗口 -->
<div class="modal fade" id="editUserModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改用户</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="edit-email" class="col-sm-2 control-label"><span style="color: red">*</span>邮箱</label>
                        <div class="col-sm-10" style="width:450px">
                            <input style="cursor:pointer" readonly="readonly" type="text" name="email" class="form-control" id="edit-email" readonly placeholder="请输入邮箱">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-name" class="col-sm-2 control-label"><span style="color: red">*</span>用户名</label>
                        <div class="col-sm-10" style="width:450px">
                            <input type="text" name="name" class="form-control" id="edit-name" placeholder="请输入用户名">
                        </div>
                    </div>

                    <div class="form-group">

                        <label  class="col-sm-2 control-label"><span style="color: red">*</span>性别</label>
                        <div class="radio col-sm-10">
                            <label for="edit-sexm">
                                <input type="radio" name="sex" id="edit-sexm" value="男">男
                            </label>
                            <label for="edit-sexw">
                                <input type="radio" name="sex" id="edit-sexw" value="女">女
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
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateBtn">更新</button>
            </div>
        </div>
    </div>
</div>




<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>用户信息列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名字</div>
                        <input class="form-control" type="text" id="search-name">
                    </div>
                </div>
                <button type="button" id="searchBtn" class="btn btn-default">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
                <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
                <button type="button" class="btn btn-danger"id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="qx"/></td>
                    <td>名字</td>
                    <td>性别</td>
                    <td>邮箱</td>
                    <td>创建时间</td>
                </tr>
                </thead>
                <tbody id="userBody">
                        <%--						<tr class="active">--%>
                        <%--							<td><input type="checkbox" /></td>--%>
                        <%--							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/question/detail.jsp';">发传单</a></td>--%>
                        <%--                            <td>zhangsan</td>--%>
                        <%--							<td>2020-10-10</td>--%>
                        <%--							<td>2020-10-20</td>--%>
                        <%--						</tr>--%>

                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: 30px;">
            <div id="userPage"></div>

        </div>

    </div>

</div>
</body>
</html>