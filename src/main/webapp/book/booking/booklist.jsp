<%@page import="java.io.StringReader"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ScreeningDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String movieid =request.getParameter("movieid");
System.out.println("🔥 [JSP] movieid: " + movieid);
ScreeningDAO dao = ScreeningDAO.getInstance();

//HashMap을 담을 list 생성
List<HashMap<String,String>> list = dao.getScreeningDatas(movieid);
System.out.println("🔥 [JSP] list.size(): " + list.size());

JSONArray arr = new JSONArray();

for(HashMap<String,String>map: list){
	//연속된 값 담을 ob 생성 for문실행때마다 ob생성
	JSONObject ob = new JSONObject();
	ob.put("region", map.get("region"));
	ob.put("theater_name",map.get("theater_name"));
	ob.put("auditorium_name",map.get("auditorium_name"));
	ob.put("start_time",map.get("start_time"));
	ob.put("total_seat",map.get("total_seat"));
	ob.put("reserved_seats",map.get("reserved_seats"));

	arr.add(ob);
}
response.setCharacterEncoding("UTF-8");

%>
<%=arr.toString()%>