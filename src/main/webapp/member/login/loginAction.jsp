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

String userid=request.getParameter("userid");
String save=request.getParameter("chkid");
String password=request.getParameter("password");

UserDAO dao=UserDAO.getInstance();
boolean chk=dao.userIdCheck(userid, password);



if(chk)
{
	
	session.setAttribute("loginok", "yes");
	session.setAttribute("userid", userid);
	session.setAttribute("chkidok", save);
	

	session.setMaxInactiveInterval(60*60*8);
	
	response.sendRedirect("../../index.jsp");
	
	
}else{
%>
	<script type="text/javascript">
			alert("아이디와 비밀번호가 맞지않습니다");
			history.back();
		</script>
<%}


%>

<body>

</body>
</html>