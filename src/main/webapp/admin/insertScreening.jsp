<%@page import="data.dto.ScreeningDTO"%>
<%@page import="data.dao.ScreeningDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String auditoriumId = request.getParameter("auditoriumId");
	String movieId = request.getParameter("movieId");
	int runtime = Integer.parseInt(request.getParameter("runtime"));
	String startTime = request.getParameter("startTime");
	int price = Integer.parseInt(request.getParameter("price"));
	
							// 저장할 때 초 단위가 누락되어 있어서 추가
	Timestamp newStartTime = Timestamp.valueOf(startTime + ":00");
							
	// 시작시간과 런타임 합해서 끝나는 시간 계산
	long endMs = newStartTime.getTime() + runtime * 60 * 1000;
	Timestamp endTime = new Timestamp(endMs);
	
	ScreeningDAO dao = ScreeningDAO.getInstance();
	boolean isOverlap = dao.checkScheduleOverlap(auditoriumId, endTime, newStartTime);
	
	System.out.println(isOverlap);
	
	if(isOverlap) 
	{
		out.print("{\"success\":false, \"msg\":\"겹치는 상영스케줄이 있습니다.\"}");
	    return;
	}
	else
	{
		ScreeningDTO dto = new ScreeningDTO();
		dto.setMovie_id(movieId);
		dto.setAuditorium_id(auditoriumId);
		dto.setStart_time(newStartTime);
		dto.setPrice(price);
		
		dao.insertScreening(dto);
		
		out.print("{\"success\":true}");	
	}
%>