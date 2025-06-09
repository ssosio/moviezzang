<%@page import="java.io.StringReader"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashMap"%>
<%@page import="data.dao.UserDAO"%>
<%@page import="java.util.Map"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String changesStr = request.getParameter("changes");

	JSONParser parser = new JSONParser();
	JSONArray arr = (JSONArray)parser.parse(new StringReader(changesStr));
	
	// id별로 변경 컬럼을 모아줌
	Map<String, Map<String, String>> updateMap = new HashMap<>();
	
	for(Object obj : arr) 
	{
		JSONObject change = (JSONObject)obj;
	    String id = (String)change.get("id");
	    String column = (String)change.get("column");
	    String value = (String)change.get("value");
	
	    // 보안상 컬럼명 화이트리스트 체크 필요
	    // 허용된 컬럼명이 아니면 update문을 실행하지 않고 continue 하겠다는 의미
	    if(!Arrays.asList("userid", "password", "name", "gender", "age", "phone", "address", "mileage", "user_type", "email", "birth").contains(column))
	    {	
	    	continue;
	    }
	
	    updateMap.computeIfAbsent(id, k->new HashMap<>()).put(column, value);
	 }
	
	 UserDAO dao = UserDAO.getInstance();
	 
	 for(Map.Entry<String, Map<String, String>> entry : updateMap.entrySet()) 
	 {
	 	int id = Integer.parseInt(entry.getKey());
	    Map<String, String> colMap = entry.getValue();
	    dao.updateMemberByColumns(id, colMap); // 여러 컬럼 동시 업데이트 메소드
	 }
%>
<%=arr.toString()%>