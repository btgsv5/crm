package com.zj.ksxt.service.impl;

import com.zj.domain.Score;
import com.zj.domain.User;
import com.zj.ksxt.dao.ScoreDao;
import com.zj.ksxt.service.ScoreService;
import com.zj.settings.dao.UserDao;
import com.zj.utils.SqlSessionUtil;
import com.zj.vo.PaginationVO;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ScoreServiceImpl implements ScoreService {
    private ScoreDao scoreDao =  SqlSessionUtil.getSqlSession().getMapper(ScoreDao.class);
    @Override
    public boolean save(Score score) {
        //添加成绩记录
        int success  =scoreDao.save(score);
        //得到当前用户的id
        int uId = score.getuId();
            //得到当前用户有多少条成绩记录
        Integer count = scoreDao.getCount(uId);
        if (count>7){
            //得到当前用户最后一条记录的id
            int sId = scoreDao.getScoreLast(uId);
            int count2 = scoreDao.deleteLast(sId);
            if (count2==1 && success == 1){
                return true;
            }
                return false;
        }
        if (success!=1){
            return false;
        }
        return true;
    }

    @Override
    public int[] getScoreList(Integer id) {
        return scoreDao.getScoreList(id);
    }

    @Override
    public PaginationVO<Score> getRankList(Map<String,Object> map ) {
        List<Score> datalist = scoreDao.getRankList(map);
        int total = scoreDao.getTotal();
        PaginationVO<Score> pv = new PaginationVO<>();
        pv.setDataList(datalist);
        pv.setTotal(total);
        return pv;
    }

    @Override
    public Map<String, Object> getPerc() {
        Map<String,Object> map = new HashMap<>();
        List<Map<String,Object>> datalist = new ArrayList<>();
        datalist.add(scoreDao.getPerc("一般",0,59));
        datalist.add(scoreDao.getPerc("优秀",60,100));
         map.put("datalist",datalist);
        return map;
    }

    @Override
    public List<Score> examinee(HttpServletRequest request, Integer id) {
        return scoreDao.getExamineeList(id);
    }
}
