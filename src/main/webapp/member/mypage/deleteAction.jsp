<%@page import="data.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
  String id=request.getParameter("id");
  String password=request.getParameter("password");
  
  UserDAO dao=UserDAO.getInstance();
  
  boolean b=dao.EqualPass(id, password);
  
  if(b){
	  	dao.deleteMember(id);
		%>
		
		<script type="text/javascript">
			alert("탈퇴되었습니다.");
			location.href='../login/logoutAction.jsp';
		</script>	
	<%}else{%>
		<script type="text/javascript">
		alert("비밀번호가 맞지 않습니다");
		history.back();
		</script>
	<%}
		  
  
%>