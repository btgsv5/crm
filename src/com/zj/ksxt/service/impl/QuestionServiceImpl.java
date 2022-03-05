package com.zj.ksxt.service.impl;

import com.zj.domain.QuestionRemark;
import com.zj.domain.User;
import com.zj.ksxt.dao.QuestionDao;
import com.zj.ksxt.dao.QuestionRemarkDao;
import com.zj.ksxt.service.QuestionService;
import com.zj.settings.dao.UserDao;
import com.zj.utils.SqlSessionUtil;
import com.zj.vo.PaginationVO;
import com.zj.domain.Question;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

public class QuestionServiceImpl implements QuestionService {
    private QuestionDao questionDao = SqlSessionUtil.getSqlSession().getMapper(QuestionDao.class);
    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);
    private QuestionRemarkDao questionRemarkDao = SqlSessionUtil.getSqlSession().getMapper(QuestionRemarkDao.class);
    @Override
    public boolean save(Question q){
        boolean flag = true;
        int count = questionDao.save(q);
        if (count!=1){
            flag = false;
        }
        return flag;
    }

    @Override
    public PaginationVO<Question> pageList(Map<String, Object> map) {
        //取得total
        int total = questionDao.getTotalByCondition(map);
        //取得dataList
        List<Question> dataList = questionDao.getQuestionListByCondition(map);

        //创建一个vo对象，将total和dataList封装到vo中
        PaginationVO<Question> vo = new PaginationVO();
        vo.setTotal(total);
        vo.setDataList(dataList);
        //将vo返回
        return vo;
    }

    @Override
    public boolean delete(String[] ids) {
        boolean flag = true;
           int count = questionDao.delete(ids);
        if (count!= ids.length){
            flag = false;
        }
        return flag;

    }

    @Override
    public Map<String, Object> getUserListAndQuestion(String id) {
        //取uList
        List<User> uList = userDao.getUserList();

        // 取q
        Question q = questionDao.getById(id);

        //将uList和q打包到map
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("uList",uList);
        map.put("q",q);
        //再返回map就可以了
        return map;
    }

    @Override
    public boolean update(Question q) {
        boolean flag = true;
        int count = questionDao.update(q);
        if (count!=1){
            flag = false;
        }
        return flag;
    }

    @Override
    public Question detail(String id) {
        return  questionDao.getById(id);

    }

    @Override
    public List<Question> getRemarkListByAid(String questionId) {
        List<Question> arList = questionRemarkDao.getRemarkListByAid(questionId);
        return arList;
    }

    @Override
    public boolean deleteRemark(String id) {
        boolean flag = true;
        int count = questionRemarkDao.deleteRemark(id);
        if (count!=1){
            flag=false;
        }
        return flag;
    }

    @Override
    public boolean saveRemark(QuestionRemark qr) {
        boolean flag = true;
        int count = questionRemarkDao.saveRemark(qr);
        if (count!=1){
            flag=false;
        }
        return flag;
    }

    @Override
    public boolean updateRemark(QuestionRemark qr) {
        boolean flag = true;
        int count = questionRemarkDao.updateRemark(qr);
        if (count != 1){
            flag=false;
        }
        return flag;
    }

    @Override
    public Map<String, Object> getCharts() {
        List<Map<String,Object>> datalist =  questionDao.getEchartsList();
        Map<String,Object>map = new HashMap<>();
        map.put("datalist",datalist);
        return map;
    }

    @Override
    public void getExam(HttpSession session) {
    session.setAttribute("dataDan",questionDao.getExam("单选题",10));
    session.setAttribute("dataDuo",questionDao.getExam("多选题",5));
    session.setAttribute("dataPan",questionDao.getExam("判断题",5));
/*        for (Map.Entry<String,Object> entry: map.entrySet()) {
            for (Question q: (List<Question>) entry.getValue()) {
                System.out.println(q);
                datalist.add(q);
            }
        }*/

    }

    @Override
    public void doExam(HttpServletRequest request) {
        String answer = "";
        String rightAnswer = "";
        int score = 0;
        HttpSession session = request.getSession(false);
        List<Question> dataDan = (List<Question>) session.getAttribute("dataDan");
        List<Question> dataDuo = (List<Question>) session.getAttribute("dataDuo");
        List<Question> dataPan = (List<Question>) session.getAttribute("dataPan");
        for (int i = 0; i < dataDan.size(); i++) {
            answer = request.getParameter("answer"+i);
            if (answer==null){
                continue;
            }
            rightAnswer = dataDan.get(i).getAnswer();
            if (rightAnswer.equals(answer)){
                score+=5;
            }
        }
        System.out.println("单选题的成绩为："+score);

        String [] s ={};
        for (int i = 0; i < dataDuo.size(); i++) {
            answer = "";
            s = request.getParameterValues("answer"+(dataDan.size()*2+i));
            if (s==null){
                continue;
            }
            for (String s2: s) {
                answer+= s2;
            }
            rightAnswer = dataDuo.get(i).getAnswer();
            if (answer.length() < rightAnswer.length()){
                for (int j = 0; j < answer.length(); j++) {
                    if (rightAnswer.indexOf(answer.charAt(j))==-1){
                        break;
                    }
                    if (j == answer.length()-1){
                        score+=2;
                    }

                }
            }else if (rightAnswer.equals(answer)){
                score+=5;
            }
        }
        System.out.println("单选+多选："+score);

//        判断题
        for (int i = 0; i < dataPan.size(); i++) {
            answer = request.getParameter("answer"+(dataDan.size()+i));
            if (answer==null){
                continue;
            }
            rightAnswer = dataPan.get(i).getAnswer();
            if (rightAnswer.equals(answer)){
                score+=5;
            }
        }
        System.out.println("总成绩为："+score);
        request.setAttribute("score",score);
    }
}
