<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="utf-8">
    <title>echarts图表</title>
    <base href="<%=basePath%>">
    <script src="ECharts/echarts.js"></script>
    <script src="jquery/jquery-1.11.1-min.js"></script>
    <script>
        $(function () {
            $.ajax({
                url:'workbench/main/getCharts.do',
                type:'get',
                dataType:"json",
                success:function (data){
                    //echarts需要的题类型和数量
                    var option = {
                        title: {
                            text: '题库类型分布',
                            left: 'center'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter : '{a} <br/>{b}: {c} ({d}%)'
                        },
                        legend: {
                            top: '5%',
                            left: 'center',
                            textStyle:{
                                fontSize:'15'
                            }
                        },
                        series: [
                            {
                                name: '当前题数',
                                type: 'pie',
                                radius: ['44%', '70%'],
                                avoidLabelOverlap: false,
                                label: {
                                    show: false,
                                    position: 'center'
                                },
                                emphasis: {
                                    label: {
                                        show: true,
                                        fontSize: '40',
                                        fontWeight: 'bold'
                                    }
                                },
                                labelLine: {
                                    show: false
                                },
                                data: data.datalist

                                /*[
                                    { value: 1048, name: 'Search Engine' },
                                    { value: 735, name: 'Direct' },
                                    { value: 580, name: 'Email' }
                                ]*/
                            }
                        ]
                    };
                    myChart.setOption(option);
                }
            });


            $.ajax({
                url:'ksxt/getPerc.do',
                type:'get',
                dataType:"json",
                success:function (data){
                    //echarts需要的题类型和数量
                    var option2 = {
                        title: {
                            text: '考试成绩比列',
                            left: 'center'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter : '{a} <br/>{b}: {c} ({d}%)'
                        },
                        legend: {
                            top: '5%',
                            left: 'center',
                            textStyle:{
                                fontSize:'15'
                            }
                        },
                        series: [
                            {
                                name: '所占比例',
                                type: 'pie',
                                radius: ['44%', '70%'],
                                avoidLabelOverlap: false,
                                label: {
                                    show: false,
                                    position: 'center'
                                },
                                emphasis: {
                                    label: {
                                        show: true,
                                        fontSize: '40',
                                        fontWeight: 'bold'
                                    }
                                },
                                labelLine: {
                                    show: false
                                },
                                data: data.datalist

                                /*[
                                    { value: 1048, name: 'Search Engine' },
                                    { value: 735, name: 'Direct' },
                                    { value: 580, name: 'Email' }
                                ]*/
                            }
                        ]
                    };
                    myChart2.setOption(option2);
                }

            });

        });
    </script>

</head>
<body>
<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div id="main" style="float:left;width: 540px;height:620px;"></div>
<div id="main2" style="float:right;width: 540px;height:620px;"></div>

<script>
    var myChart = echarts.init(document.getElementById('main'));
    var myChart2 = echarts.init(document.getElementById('main2'));
</script>

</body>
</html>
