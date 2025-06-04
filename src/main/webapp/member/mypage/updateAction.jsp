<%@page import="data.dto.UserDTO"%>
<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="data.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	UserDAO dao=UserDAO.getInstance();
	
	String id=request.getParameter("id");
	String name=request.getParameter("name");
	String password=request.getParameter("password");
	String phone=request.getParameter("hp1")+"-"+request.getParameter("hp2")+"-"+request.getParameter("hp3");
	String address=request.getParameter("zipCode")+request.getParameter("streetAdr")+request.getParameter("detailAdr");
	String email=request.getParameter("email1")+"@"+request.getParameter("email2");
	String gender=request.getParameter("gender");
	
	 String birthStr = request.getParameter("birth"); 
	 int age=0;   
	 
	 
	    if (birthStr != null && !birthStr.isEmpty()) {
	        // 생년월일 문자열을 LocalDate로 변환
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        LocalDate birthDate = LocalDate.parse(birthStr, formatter);

	        // 오늘 날짜
	        LocalDate today = LocalDate.now();

	        // 나이 계산
	        age = Period.between(birthDate, today).getYears();

	        
	    } else {
	        out.println("생년월일이 제공되지 않았습니다.");
	    }
	    
	    UserDTO dto=new UserDTO();
	    
	    dto.setId(id);
	    dto.setPassword(password);
		dto.setName(name);
		dto.setGender(gender);
		dto.setBirth(birthStr);
		dto.setPhone(phone);
		dto.setAddress(address);
		dto.setEmail(email);
		dto.setAge(age);
		
		dao.updateMember(dto);
		
		response.sendRedirect("mypageMain.jsp?");
	
%>
