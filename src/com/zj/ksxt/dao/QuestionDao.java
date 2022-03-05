package com.zj.ksxt.dao;

import com.zj.domain.Question;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface QuestionDao {

    int save(Question q);

    int getTotalByCondition(Map<String, Object> map);

    List<Question> getQuestionListByCondition(Map<String, Object> map);

    int delete(String[]ids);

    Question getById(String id);

    int update(Question q);


    List<Map<String, Object>> getEchartsList();

    List<Question> getExam(@Param("type") String type, @Param("num") Integer num);

}
