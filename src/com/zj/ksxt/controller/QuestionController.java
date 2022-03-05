package com.zj.ksxt.controller;
import com.zj.domain.QuestionRemark;
import com.zj.domain.Score;
import com.zj.ksxt.service.QuestionService;
import com.zj.ksxt.service.impl.QuestionServiceImpl;
import com.zj.settings.service.UserService;
import com.zj.settings.service.impl.UserServiceImpl;
import com.zj.utils.DateTimeUtil;
import com.zj.utils.PrintJson;
import com.zj.utils.ServiceFactory;
import com.zj.vo.PaginationVO;
import com.zj.domain.Question;
import com.zj.domain.User;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QuestionController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("进入到试题管理控制器");
        String path = request.getServletPath();

        if ("/st/getUserList.do".equals(path)){
            getUserList(request,response);
        }else if ("/st/save.do".equals(path)){
            save(request,response);
        }else if ("/st/pageList.do".equals(path)){
            pageList(request,response);
        }else if ("/st/delete.do".equals(path)) {
            delete(request,response);
        }else if ("/st/getUserListAndQuestion.do".equals(path)){
            getUserListAndQuestion(request,response);
        }else if ("/st/update.do".equals(path)) {
            update(request,response);
        }else if ("/st/detail.do".equals(path)) {
            detail(request,response);
        }else if ("/st/getRemarkListByAid.do".equals(path)){
            getRemarkListByAid(request,response);
        }else if ("/st/deleteRemark.do".equals(path)){
            deleteRemark(request,response);
        }else if ("/st/saveRemark.do".equals(path)){
            saveRemark(request,response);
        }else if ("/st/updateRemark.do".equals(path)){
            updateRemark(request,response);
        }else if ("/workbench/main/getCharts.do".equals(path)){
            getCharts(request,response);
        }else if ("/st/getExam.do".equals(path)){
            getExam(request,response);
        }else if ("/st/doExam.do".equals(path)){
            doExam(request,response);
        }

    }

    private void doExam(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        QuestionService qs = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
        qs.doExam(request);


        request.getRequestDispatcher("/ksxt/save.do").forward(request,response);
    }

    private void getExam(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("进入到得到随机题目的操作");
        //多选10，多选5，判断5，一道5分。将一套题包装成List<question>用session作用域存放
        QuestionService qs = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
        HttpSession session = request.getSession(false);

         qs.getExam(session);
        request.getRequestDispatcher("/users/doExam.jsp").forward(request,response);
    }

    private void getCharts(HttpServletRequest request, HttpServletResponse response) {
        QuestionService qs = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
        Map<String,Object> map = qs.getCharts();
        PrintJson.printJsonObj(response,map);

    }

    private void updateRemark(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("进入到备注的修改操作");
        String id = request.getParameter("id");
        String noteContent = request.getParameter("noteContent");
        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User)request.getSession(false).getAttribute("user")).getUsername();
        String editFlag = "1";
        QuestionRemark qr = new QuestionRemark();

        qr.setId(id);
        qr.setNoteContent(noteContent);
        qr.setEditTime(editTime);
        qr.setEditBy(editBy);
        qr.setEditFlag(editFlag);
        QuestionService as = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
        boolean flag = as.updateRemark(qr);
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("success",true);
        map.put("qr",qr);
        PrintJson.printJsonObj(response,map);
    }

    private void saveRemark(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("进入到详情页面的添加备注操作");
        String noteContent = request.getParameter("noteContent");
        String questionId = request.getParameter("questionId");
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User)request.getSession(false).getAttribute("user")).getUsername();
        String editFlag = "0";
        StringBuilder sb = new StringBuilder();
        String date = DateTimeUtil.getSysTime();
        date = date.replace(":","");
        date = date.replace("-","");
        date = date.replace(" ","");

        QuestionRemark qr = new QuestionRemark();
       qr.setId(date);
        qr.setNoteContent(noteContent);
        qr.setQuestionId(questionId);
        qr.setCreateTime(createTime);
        qr.setCreateBy(createBy);
        qr.setEditFlag(editFlag);

        QuestionService as = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
        boolean flag = as.saveRemark(qr);
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("success",flag);
        map.put("qr",qr);
        PrintJson.printJsonObj(response,map);

    }

    private void deleteRemark(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("进入到删除备注操作");
        String id = request.getParameter("id");
        QuestionService as = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
        boolean flag = as.deleteRemark(id);
        PrintJson.printJsonFlag(response,flag);
    }

    private void getRemarkListByAid(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("进入到根据试题id，取得备注信息列表");
        String questionId = request.getParameter("questionId");
        QuestionService as = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
        List<Question> arList = as.getRemarkListByAid(questionId);
        PrintJson.printJsonObj(response,arList);
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("进入到跳转详细信息页的操作");
        String id = request.getParameter("id");
        QuestionService qs = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
        Question q = qs.detail(id);
        request.setAttribute("q",q);
        request.getRequestDispatcher("/st/detail.jsp").forward(request,response);
    }


    private void update(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("执行试题的修改操作");
        String id = request.getParameter("id");
        String owner  =request.getParameter("owner");
        String type =request.getParameter("type");
        String startDate =request.getParameter("startDate");
        String title =request.getParameter("title");
        String optionA =request.getParameter("optionA");
        String optionB =request.getParameter("optionB");
        String optionC =request.getParameter("optionC");
        String optionD =request.getParameter("optionD");
        String answer =request.getParameter("answer");
        //修改时间：当前系统时间
        String editTime = DateTimeUtil.getSysTime();
        //修改人：当前登录用户
        String editBy = ((User)request.getSession().getAttribute("user")).getUsername();

        QuestionService qs = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
        Question q = new Question();
        q.setId(Integer.valueOf(id));
        q.setOwner(owner);
        q.setType(type);
        q.setStartDate(startDate);
        q.setTitle(title);
        q.setOptionA(optionA);
        q.setOptionB(optionB);
        q.setOptionC(optionC);
        q.setOptionD(optionD);
        q.setAnswer(answer);
        q.setEditTime(editTime);
        q.setEditBy(editBy);
        boolean flag = qs.update(q);
        PrintJson.printJsonFlag(response,flag);
    }

    private void getUserListAndQuestion(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        QuestionService qs = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
        /*
            总结：
                controller调用service的方法，前端需要什么，service层返回值就返回什么
                （service只能返回多条单一的，不能一下返回所有想要的，于是乎在这个controller层需要将他们装到map里再一起返回到前端）
                前端
                aList
                a
                map
         */
        Map<String,Object> map =  qs.getUserListAndQuestion(id);
        PrintJson.printJsonObj(response,map);
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("进入到删除信息的操作");
        String ids[] = request.getParameterValues("id");
        QuestionService qs = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
        boolean flag = qs.delete(ids);
        PrintJson.printJsonFlag(response,flag);
    }

    private void pageList(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("进入到查询信息列表的操作(结合条件查询+分页查询)");
        String title = request.getParameter("title");
        String owner = request.getParameter("owner");
        String startDate = request.getParameter("startDate");
        String type = request.getParameter("type");
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);
        //每页展现的记录数
        String pageSizeStr = request.getParameter("pageSize");
        //计算出略过的记录数
        int pageSize = Integer.valueOf(pageSizeStr);
        int skipCount = (pageNo-1)*pageSize;
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("title",title);
        map.put("owner",owner);
        map.put("startDate",startDate);
        map.put("type",type);
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);

        QuestionService qs = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());

        PaginationVO<Question> vo = qs.pageList(map);

        PrintJson.printJsonObj(response,vo);

    }
    private void save(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("执行试题的添加操作");

        String owner = request.getParameter("owner");
        String type = request.getParameter("type");
        String startDate = request.getParameter("startDate");
        String title = request.getParameter("title");
        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");
        String answer = request.getParameter("answer");
        //创建时间：当前系统时间
        String createTime = DateTimeUtil.getSysTime();
        //创建人：当前登录用户
        String createBy = ((User)request.getSession().getAttribute("user")).getUsername();

        QuestionService qs = (QuestionService) ServiceFactory.getService(new QuestionServiceImpl());
        Question q = new Question();
        q.setOwner(owner);
        q.setType(type);
        q.setStartDate(startDate);
        q.setTitle(title);
        q.setOptionA(optionA);
        q.setOptionB(optionB);
        q.setOptionC(optionC);
        q.setOptionD(optionD);
        q.setAnswer(answer);
        q.setCreateTime(createTime);
        q.setCreateBy(createBy);
        boolean flag = qs.save(q);
        PrintJson.printJsonFlag(response,flag);



    }


    private void getUserList(HttpServletRequest request, HttpServletResponse response) {

        System.out.println("取得用户信息列表");

        UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
        List<User> uList = us.getUserList();
        PrintJson.printJsonObj(response,uList);

    }


}
