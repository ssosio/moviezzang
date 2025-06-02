<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>영화짱닷컴</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/domainIcon.png">
<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/domainIcon.png">
<%@ include file="component/menu/headerResources.jsp"%>
<%
String mainPage = "layout/main.jsp";

if (request.getParameter("main") != null) {
	mainPage = request.getParameter("main");

	
	
	
}
String root = request.getContextPath();
%>

<!-- 로딩 화면 스타일 -->
<style>
</style>
</head>
<body>
	<!-- 로딩 화면 -->
	<div id="loading">

		<jsp:include page="component/menu/loading.jsp"></jsp:include>
	</div>


	<div id="mainContent">


		<div id="layout header">
			<jsp:include page="component/menu/header.jsp" />
		</div>

		<div id="mainPage" class="">
			<jsp:include page="<%=mainPage%>" />
			
		</div>


		<div id="layout footer">
			<jsp:include page="component/menu/footer.jsp" />
		</div>
	</div>
	<script>
		// 페이지 로드 후 로딩 화면 숨기고 mainContent 보이기
		window.onload = function() {
			
			document.getElementById('mainContent').style.opacity = 1; // 메인 콘텐츠 보이기
			document.getElementById('loading').style.display = 'none'; // 로딩 화면 숨기기
		
		}; 
	</script>
</body>
</html>
