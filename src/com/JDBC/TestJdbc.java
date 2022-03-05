package com.JDBC;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class TestJdbc {
    public static void main(String[] args) throws SQLException {
        HashMap map = new HashMap();
        map.put("123213",1);
        System.out.println(map.get("123213"));
    }



}

