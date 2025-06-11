<%@page import="java.io.StringReader"%>
<%@page import="data.dao.UserDAO"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String idsJson = request.getParameter("ids");

	// json 형태로 전달받았기 때문에 파싱 해줘야함
    if(idsJson != null && !idsJson.isEmpty()) {
        JSONParser parser = new JSONParser();
        JSONArray arr = (JSONArray) parser.parse(new StringReader(idsJson));

        ArrayList<String> idList = new ArrayList<>();
        
        for(Object idObj : arr) 
        {
            idList.add((String)idObj);
        }

        UserDAO dao = UserDAO.getInstance();
        dao.deleteMembersByIds(idList);

        out.print("success");
    } else {
        response.setStatus(400);
    }
%>