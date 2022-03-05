package com;

import com.sun.scenario.effect.impl.sw.sse.SSEBlend_SRC_OUTPeer;
import com.zj.ksxt.service.QuestionService;
import com.zj.ksxt.service.impl.QuestionServiceImpl;
import com.zj.utils.DateTimeUtil;
import com.zj.utils.ServiceFactory;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class test {
    public static void main(String[] args) throws ParseException {
//        String date = DateTimeUtil.getSysTime();
//        QuestionService qs = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
//        QuestionService qs2 = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
//        System.out.println(qs);
//        System.out.println(qs2);
//        System.out.println( date.replace(":",""));
            Collection list = new ArrayList();
            list.add(1);
            list.add(2);
            list.add(3);
            list.add(4);
            list.add(5);
            int i  = 1;
            list.remove(i);
            Iterator  iterator = list.iterator();
            while (iterator.hasNext()){
                System.out.println(iterator.next());
            }




//        System.out.println(ad);
    }
}

/*

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(2, 'zs', '单选题', '2021-12-30', '启动Controller的过程：VuGen → 工具 → 创建控制器（   ）', '脚本', '场景', '任务', '界面', 'B', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(3, 'zs', '单选题', '2021-12-30', '场景组查看与监控中，查看和监控每个脚本中Vuser的运行（   ），并能够实时进行Vuser的灵活控制', '控制', '状态', '结果', '时间', 'B', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(4, 'zs', '单选题', '2021-12-30', '为什么要查看和监控，同查看服务器性能有什么关系？虚拟用户Vuser即负载，用于对系统施加（   ）。换言之，Vuser的运行状态直接影响到对系统服务器施加压力的大小，同系统性能的衡量有密切关系。', '压力', '影响', '数据', '同步', 'A', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(5, 'zs', '单选题', '2021-12-30', 'Running Vusers图：显示整个场景内（   ）的Vuser数量', '正在运行', '正在操作', '正在计算', '正在显示', 'A', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(6, 'zs', '单选题', '2021-12-30', 'Trans Response Time图：显示整个场景内完成（   ）所需的时间值', '每个运行', '每个事务', '每个操作', '每个任务', 'B', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(7, 'zs', '单选题', '2021-12-30', 'Hits per Second图：显示（   ）内每秒向服务器发送的点击次数', '操作场景', '运行场景', '整个场景', '每个场景', 'C', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(8, 'zs', '单选题', '2021-12-30', 'Windows Resources图：显示（   ）内待监测的各项Windows资源指标值', '10秒', '30秒', '90秒', '60秒', 'D', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(9, 'zs', '单选题', '2021-12-30', '在场景运行过程中，可在（   ）的配置窗口中查看并控制集合点状态', '集合点', '汇聚点', '运行点', '操作点', 'A', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(10, 'zs', '单选题', '2021-12-30', '一般在运行场景时，运行 Vuser 的计算机将调用“用于控制负载生成器上 Vuser 执行的（   ）”', '集合点', '代理', '事务', '操作', 'B', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(11, 'zs', '单选题', '2021-12-30', '场景执行期间，该代理将显示“就绪”、“正在运行”和“（   ）”的 Vuser 的概要', '事务', '代理', '暂停', '操作', 'C', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(12, 'zs', '单选题', '2021-12-30', '系统资源监控是Controller监控中的重要组成部分之一。可进一步对系统的（    ）问题准确定位', '功能', '性能', '事务', '操作', 'B', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(13, 'zs', '单选题', '2021-12-30', 'LR可以监控场景运行期间的计算机各项系统资源（既包括服务器系统资源也包括Load Generator的系统资源）的使用情况，并定位系统性能（   ）', '效率', '信息', '瓶颈', '问题', 'C', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(14, 'zs', '多选题', '2021-12-30', 'Controller的作用？', '分析场景', '设计场景', '运行场景', '监控场景', 'BCD', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(15, 'zs', '多选题', '2021-12-30', '场景设计主要包括对什么进行设置？', '测试脚本', 'Generator', 'Schedule', '集合点', 'ABCD', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(16, 'zs', '多选题', '2021-12-30', '场景设计主要包括对什么进行设置？', '综合参数', 'IP  Spoofer', '集合点', 'VuGen', 'ABC', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(17, 'zs', '多选题', '2021-12-30', '运行场景时，可监视场景组及Vuser运行的状态，并可做什么？', '监视及控制每个Vuser', '查看由Vuser生成的错误', '警告和通知消息', '监控场景运行中收集到的各种数据', 'ABCD', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(18, 'zs', '多选题', '2021-12-30', 'Controller运行窗口，主要有哪几个操作区域应用功能？', '启动场景', '场景组，查看与监控', '操作按钮', '计算操作', 'ABC', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(19, 'zs', '多选题', '2021-12-30', 'Controller运行窗口，主要有哪几个操作区域应用功能？', '场景状态，查看与监控', '查看可用数据图', '控制集合点', '压力计算', 'ABC', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(20, 'zs', '多选题', '2021-12-30', '面向目标的测试场景，目标类型主要有哪些？', '每秒事务数', '每秒点击次数', '事务响应时间', '每秒逻辑数', 'ABC', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(21, 'zs', '多选题', '2021-12-30', '面向目标的测试场景，目标类型主要有哪些？', '每分页面数', '事务响应时间', '每秒点击次数', '每秒计算数', 'ABC', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(22, 'zs', '多选题', '2021-12-30', 'Manual Scenario场景：是通过设置哪几种信息，详细模拟用户的真实活动场景', '加压方式', '场景持续运行时间', '减压方式', '计算方式', 'ABC', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(23, 'zs', '多选题', '2021-12-30', '解决“怎么做？”的问题，主要有哪几种方法？', '设置Vuser初始化方式', '设置加压方式，模拟用户同时或逐渐进入测试场景', '设置Vuser持续执行时间', '设置网速', 'ABC', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(24, 'zs', '多选题', '2021-12-30', '解决“怎么做？”的问题，主要有哪几种方法？', '设置减压方式，模拟用户同时或逐渐退出测试场景', '设置Vuser持续执行时间', '设置Vuser初始化方式', '设置网络宽度', 'ABC', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(25, 'zs', '多选题', '2021-12-30', '查看联机图，有哪几幅默认图？', 'Running Vusers图', 'Trans Response Time图', 'Hits per Second图', 'Windows Resources图', 'ABCD', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(26, 'zs', '判断题', '2021-12-30', '场景类型之手动场景，在验证系统能否达到目标，验收测试常用', '对', '错', NULL, NULL, 'B', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(27, 'zs', '判断题', '2021-12-30', '场景类型之目标场景，是定位性能瓶颈并了解系统处理能力', '对', '错', NULL, NULL, 'B', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(28, 'zs', '判断题', '2021-12-30', 'Controller提供了一种直接读取系统计数器的功能，通过添加计数器来实现对系统资源的监控', '对', '错', NULL, NULL, 'A', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(29, 'zs', '判断题', '2021-12-30', '系统监视前期准备工作注意事项：要监控服务器计算机上的资源，可以不连接到该计算机', '对', '错', NULL, NULL, 'B', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(30, 'zs', '判断题', '2021-12-30', 'Linux是一套免费使用和自由传播的类Unix操作系统，由全世界各地的成千上万的程序员设计和实现的。其目的是建立不受任何商品化软件的版权制约的、全世界都能自由使用的Unix兼容产品', '对', '错', NULL, NULL, 'A', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(31, 'zs', '判断题', '2021-12-30', 'Linux操作系统最大缺点在于其作为服务器的强大功能', '对', '错', NULL, NULL, 'B', '2021-12-30 20:35:50', 'zs');

        INSERT INTO question (`id`, `owner`, `type`, `startDate`, `title`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `createTime`, `createBy`) VALUES(32, 'zs', '判断题', '2021-12-30', '软件性能需求：通常是服务器的CPU使用率不超过75％ ，内存使用率分别不超过70％，处理列队中线程数不超过2', '对', '错', NULL, NULL, 'A', '2021-12-30 20:35:50', 'zs');


*/