<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="data.dao.ScreeningDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.TheaterDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String movie_id = request.getParameter("movie_id");
    String theaterName = request.getParameter("theaterName");
    String screening_date = request.getParameter("screening_date"); // yyyy-MM-dd
	System.out.print("movie_id: "+movie_id);
	System.out.print("theaterName: "+theaterName);

	ScreeningDAO dao = ScreeningDAO.getInstance();

	List<HashMap<String,String>> list = dao.getTheaterScreeningInfo(movie_id, theaterName, screening_date);
	JSONArray arr = new JSONArray();

	for(HashMap<String,String>map: list){
		JSONObject ob = new JSONObject();

		ob.put("start_time", map.get("start_time"));
		ob.put("screening_id", map.get("screening_id"));
		ob.put("poster", map.get("poster"));
		ob.put("title", map.get("title"));
		ob.put("auditorium_name", map.get("auditorium_name"));
		ob.put("runtime", map.get("runtime"));
		ob.put("theater_name", map.get("theater_name"));
		ob.put("total_seat", map.get("total_seat"));
		ob.put("reserved_seatcount", map.get("reserved_seatcount"));
		ob.put("remaining_seat", map.get("remaining_seat"));

		arr.add(ob);
	}
    %>
    <%=arr.toString()%>
