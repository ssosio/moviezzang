<%@page import="data.dao.ReservationDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ReservationDAO dao = ReservationDAO.getInstance();
String userNum = request.getParameter("userNum");
String screeningId = request.getParameter("screeningId");
String seatIds = request.getParameter("seatIds");
String lastPay = request.getParameter("lastPay");
String total = request.getParameter("total"); //reserved_count

int reservationId = dao.insertReserve(screeningId, userNum, lastPay, total);

System.out.println("userNum = " + userNum);
System.out.println("screeningId = " + screeningId);
System.out.println("seatIds = " + seatIds);
System.out.println("reservationId = " + reservationId);
System.out.println("lastPay = " + lastPay);


	if(reservationId > 0){
		String seats [] = seatIds.split(",");
		for(String seatId : seats){
			dao.insertSeatReserve(reservationId, seatId);
		}
		out.print("{\"result\":\"success\"}");
	}else{
		 out.print("{\"result\":\"fail\", \"message\":\"예약실패\"}");
	}
%>