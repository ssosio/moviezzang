<%@page import="org.json.simple.JSONObject"%>
<%@page import="data.dao.UserDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	
	String id=request.getParameter("id");
	
	UserDAO dao=UserDAO.getInstance();
	
	JSONObject ob=new JSONObject();
	
	 try {
	        dao.updateBookN(id);
	        ob.put("result", "success");
	    } catch (Exception e) {
	        e.printStackTrace();
	        ob.put("result", "fail");
	    }
	 
	 out.print(ob.toString());
%>

