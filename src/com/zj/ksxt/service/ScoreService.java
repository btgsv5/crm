package com.zj.ksxt.service;

import com.zj.domain.Score;
import com.zj.vo.PaginationVO;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface ScoreService {
    boolean save(Score score);

    int[] getScoreList(Integer id);


    PaginationVO<Score> getRankList(Map<String,Object> map );

    Map<String, Object> getPerc();

    List<Score> examinee(HttpServletRequest request,Integer id);

}
