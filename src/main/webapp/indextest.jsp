<%@page import="data.dao.MovieDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="data.api.TMDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	TMDB tmdb = new TMDB();

	JSONArray list = tmdb.getMovieDatas();
	int size = list.size();	
	
	//MovieDAO.getInstance().insertData(list);
%>
<title>Insert title here</title>
</head>
<body>
	<%=size%>
	<%
		for(int i = 0; i < list.size(); i++)
		{
			out.print(list.get(i).toString());
	%>
	<br>
	<%
		}
	
		for(Object obj : list)
		{
			JSONObject jobj = (JSONObject)obj;
			String img = (String)jobj.get("poster");
	%>
		<img src="https://image.tmdb.org/t/p/w185<%=img%>" alt="포스터">
	<%
		}
	%>
	<!-- <img src="https://image.tmdb.org/t/p/w500/k5aQ2TqKcQFwPoXHkpAGoKNVDLZ.jpg" alt="포스터"> -->
</body>
</html>