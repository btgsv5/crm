package com.zj.ksxt.dao;

import com.zj.domain.Score;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ScoreDao {
    int getCount(Integer uId);

    int deleteLast(Integer sId);

    int getScoreLast(Integer uId);

    int save(Score score);

    int[] getScoreList(Integer id);

    List<Score> getRankList(Map<String,Object> map );

    int getTotal();

    Map<String,Object> getPerc(@Param("name") String name,@Param("begin") Integer begin,@Param("over") Integer over);

    List<Score> getExamineeList(Integer id);
}
