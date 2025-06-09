<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="data.dto.AuditoriumDTO"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.AuditoriumDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String theaterId = request.getParameter("theaterId");
	AuditoriumDAO dao = AuditoriumDAO.getInstance();
	List<AuditoriumDTO> list = dao.getDatasByTheater(theaterId);
	
	JSONArray arr = new JSONArray();
	
	 for(AuditoriumDTO dto : list){
	 	JSONObject obj = new JSONObject();
	 	
	    obj.put("id", dto.getId());
	    obj.put("name", dto.getName());
	    
	    arr.add(obj);
	  }
	 
	 out.print(arr.toString());
%>