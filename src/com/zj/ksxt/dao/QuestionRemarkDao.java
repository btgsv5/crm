package com.zj.ksxt.dao;

import com.zj.domain.Question;
import com.zj.domain.QuestionRemark;

import java.util.List;

public interface QuestionRemarkDao {
    int getCountByAids(String[] ids);

    int deleteByAids(String[] ids);

    List<Question> getRemarkListByAid(String questionId);

    int deleteRemark(String id);

    int saveRemark(QuestionRemark ar);

    int updateRemark(QuestionRemark ar);
}
