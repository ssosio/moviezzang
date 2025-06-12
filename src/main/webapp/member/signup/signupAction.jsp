<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.UserDTO"%>
<%@page import="data.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
</head>
<%
	String root = request.getContextPath();
	UserDAO dao=UserDAO.getInstance();

	request.setCharacterEncoding("utf-8");

	String userid=request.getParameter("userid");
	String password=request.getParameter("password");
	String name=request.getParameter("name");
	String gender=request.getParameter("gender");
	String phone=request.getParameter("hp1")+"-"+request.getParameter("hp2")+"-"+request.getParameter("hp3");
	String address=request.getParameter("zipCode") + "/" + request.getParameter("streetAdr") + "/" +  request.getParameter("detailAdr");
	String email=request.getParameter("email1")+"@"+request.getParameter("email2");
	
	 String birth = request.getParameter("birth");
	 int age=0;   
	 
	 
	    if (birth != null && !birth.isEmpty()) {
	        // 생년월일 문자열을 LocalDate로 변환
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        LocalDate birthDate = LocalDate.parse(birth, formatter);

	        // 오늘 날짜
	        LocalDate today = LocalDate.now();

	        // 나이 계산
	        age = Period.between(birthDate, today).getYears();

	        out.println("나이: " + age);
	    } else {
	        out.println("생년월일이 제공되지 않았습니다.");
	    }
	
	
	
	UserDTO dto=new UserDTO();
	
	dto.setUserid(userid);
	dto.setPassword(password);
	dto.setName(name);
	dto.setGender(gender);
	dto.setBirth(birth);
	dto.setPhone(phone);
	dto.setAddress(address);
	dto.setEmail(email);
	dto.setAge(age);
	dao.insertMember(dto);
	
	
	String adminChk = request.getParameter("adminChk");
	System.out.println(adminChk);
	
	if(adminChk.equals("checked"))
	{		
		response.sendRedirect(root + "/index.jsp?main=indexAdmin.jsp");
	}
	else
	{
		response.sendRedirect(root + "/index.jsp?main=layout/main.jsp");
	}
	
%>


<body>

</body>
</html>