package com.zj.ksxt.service;

import com.zj.domain.QuestionRemark;
import com.zj.vo.PaginationVO;
import com.zj.domain.Question;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface QuestionService {
    boolean save(Question q);

    PaginationVO<Question> pageList(Map<String, Object> map);

    boolean delete(String[] ids);

    Map<String, Object> getUserListAndQuestion(String id);

    boolean update(Question q);

    Question detail(String id);

    List<Question> getRemarkListByAid(String questionId);

    boolean deleteRemark(String id);

    boolean saveRemark(QuestionRemark ar);

    boolean updateRemark(QuestionRemark ar);

    Map<String, Object> getCharts();

    void getExam(HttpSession session);

    void doExam(HttpServletRequest request);
}
