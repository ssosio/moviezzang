<%@page import="org.json.simple.JSONArray"%>
<%@page import="data.api.TMDBtest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	TMDBtest tmdb = new TMDBtest();

	JSONArray list = tmdb.getMovieDatas();
	int size = list.size();	
%>
<title>Insert title here</title>
</head>
<body>
	<%=size%>개
	<%
		for(int i = 0; i < list.size(); i++)
		{
			out.print(list.get(i).toString());
			//System.out.println(list.get(i).toString().split("poster")[1]);
	%>
	<br>
	<%
		}
	%>
	<img src="https://image.tmdb.org/t/p/w500/k5aQ2TqKcQFwPoXHkpAGoKNVDLZ.jpg" alt="포스터">
</body>
</html>