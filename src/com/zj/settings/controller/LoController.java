package com.zj.settings.controller;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.zj.settings.service.UserService;
import com.zj.settings.service.impl.UserServiceImpl;
import com.zj.utils.PrintJson;
import com.zj.utils.ServiceFactory;
import com.zj.domain.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class LoController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/settings/user/login.do".equals(path)){
            System.out.println("登录");
            login(request,response);
        }if ("/settings/user/loginOut.do".equals(path)){
            System.out.println("退出");
            loginOut(request,response);
        }
    }

    private void loginOut(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null){
            session.invalidate();
        }
        PrintJson.printJsonFlag(response,true);
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
        String loginAct = request.getParameter("loginAct");
        String loginPwd = request.getParameter("loginPwd");
        UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());

        try {
                User user = us.login(loginAct,loginPwd);
                request.getSession().setAttribute("user",user);
                Map<String,Object> map = new HashMap<String,Object>();
                map.put("success",true);
                //管理员权限为1
                if (user.getIsAdmin()==0){
                    map.put("ud","users/index.jsp");
                }else {
                    map.put("ud","admin/show.jsp");
                }
                ObjectMapper om = new ObjectMapper();
                String json = om.writeValueAsString(map);
                response.getWriter().print(json);

        }catch (Exception e){
            e.printStackTrace();
            String msg = e.getMessage();
            Map<String,Object> map = new HashMap<>();
            map.put("success",false);
            map.put("msg",msg);
            PrintJson.printJsonObj(response,map);
        }
    }
}
