<%@page import="org.json.simple.JSONObject"%>
<%@page import="data.dao.UserDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%


	String userid=request.getParameter("id");

	UserDAO dao=UserDAO.getInstance();
	int idCheck=dao.idCheck(userid);
	
	JSONObject ob=new JSONObject();
	ob.put("idCheck", idCheck);

%>
<%=ob.toString() %>
