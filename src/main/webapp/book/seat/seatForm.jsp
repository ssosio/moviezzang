<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.SeatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Hi+Melody&family=Nanum+Myeongjo&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/book/buttonStyle.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
<style type="text/css">
.container {
  position: absolute;
  display: flex;
  flex-wrap: wrap;
}
.mainbox{
display: flex;
}
.title {
  margin: 100px 0 0 100px;
  width: 600px;
}
.seatbox {
  width: 600px;
  height: 700px;
  margin-top: 1px;
  margin-left: 100px;
  border: 1px solid #ccc;
}
.subject {
  display: flex;
  justify-content: space-between;
  width: 600px;
  align-items: center;
  margin-left: 100px;

}
.seatcount {
  background: #ddd;
  display: flex;
  align-items: center;
  padding: 10px;
  margin-top: 5px;
}
.seatcount > div {
  display: flex;
  align-items: center;
}
.seatcount span:first-child {
  margin-right: 10px;
  margin-left: 10px;
}
.btn-down,
.btn-up,
.inwoncount {
  height: 30px;
  font-size: 16px;
  padding: 0 10px;
  border: 1px solid #ccc;
  background: white;
  line-height: 30px;
}

.btn-down {
  border-right: none;
  border-top-right-radius: 0;
  border-bottom-right-radius: 0;
  border-right: 1px solid #888;
}
.inwoncount {
  border-left: none;
  border-right: none;
  align-items: center;
}

.btn-up {
  border-left: none;
  border-top-left-radius: 0;
  border-bottom-left-radius: 0;
  border-left: 1px solid #888;
}
div.teenagerseat{
	margin-left: 50px;
}
div.screen{
background: #ddd;
text-align: center;
margin-top: 5px;

}
div.seat{
border-top: none;
height: 600px;
text-align: center;
margin-top: 40px;
}
button.selseat{
margin-top: 5px;
}
div.paybox{
border: 1px #333 solid;
background: #434343;
border-radius: 15px;
color: #ccc;
width: 350px;
height: 600px;
margin-left: 40px;
margin-top: 40px;
padding: 25px;
}
div.pay-info{
 display: flex;
 justify-content: space-between;
 align-items: flex-end;
}
div.pay-infoString p{
margin-bottom: 0px;
}
div.pay-info>img{
width: 90px;
height: 120px;
}
p.auditorium{
margin-bottom: 0px;
}
p.theater{
margin-bottom: 0px;
}
div.seat-choice-info{
border: 1px gray solid;
border-radius: 5px;
height: 250px;
display: flex;
width: 100%;
}
div.legend{
border-right: 1px gray solid;
height: 100%;
width: 50%;
}
div.myseat{
width: 50%;
}
div.myseat>span{
margin: 25%;
margin-top: 15px;
}
div.pay{
display: flex;
justify-content: space-between;
}
div.pay>span:first-child {
	color: white;
	font-weight: bold;
}
div.pay>span:last-child {
	color: orange;
}
</style>
<%
String screening_id = request.getParameter("screening_id");
System.out.println(">>> screening_idzz: " + screening_id);
SeatDAO dao = SeatDAO.getInstance();
List<HashMap<String,String>> list = dao.getSeatInfo(screening_id);
if(list == null || list.isEmpty()) {
    out.println("<h3>좌석 정보를 불러오지 못했습니다. 상영 정보가 없거나 DB 오류입니다.</h3>");
    return;
}
HashMap<String,String> map = list.get(0);
String title = map.get("movie_title");
String poster = map.get("poster");
String auditorium_name = map.get("auditorium_name");
String theater_name = map.get("theater_name");
String start_time = map.get("start_time");
String price = map.get("price");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
</head>
<script type="text/javascript">
$(function() {
	//screening id와 posterurl 가져오기
	const screening_id = "<%=screening_id%>";
	//console.log(poster);
	$(".selseat").on("click",function(){
		$(this).toggleClass("select");
	});

})
</script>
<body>
	<div class="container">
		<div class="title">
			<h3><b>빠른예매</b></h3>
			<hr>
		</div>
		<div class="subject">
				 	<h5>좌석예매</h5>
				 	<button type="button" class="btn-mov">초기화</button>
				</div>
		<div class="mainbox">
			<div class="seatbox">
				<div class="seatcount">
					<div class="adultseat">
						<span>성인</span>
						<button class="btn-down">-</button>
						<span class="inwoncount">0</span>
						<button class="btn-up">+</button>
					</div>
					<div class="teenagerseat">
						<span>청소년</span>
						<button class="btn-down">-</button>
						<span class="inwoncount">0</span>
						<button class="btn-up">+</button>
					</div>
				</div>
				<div class="screen">
				 <span>screen</span>
				</div>
				<div class="seat">
				<%
				String[] seatrows ={"A","B","C","D","E","F","G","H","I","J","K","l","M","N"};
				for(int i=1;i<=14;i++){%>
					<div style="display: flex; align-items: center; height: 40px;">
						<span style="width: 20px; display: inline-block; text-align: center;"><%=seatrows[i-1] %></span>

					<%for(int j=1;j<=14;j++){
					String margin = (j==3 || j==13)?"20px":"";
					%>
						<button class="btn-seat selseat" type="button" style="margin-left: <%=margin%>">
						<%=j %></button>
					<%}%>
					</div>
				<%}
				%>
				</div>
		</div>
		</div>
		<div class="paybox">
			<div class="pay-title">
				<p><%=title %></p>
			</div>
			<hr>
			<div class="pay-info">
				<div class="pay-infosrting">
				<p class="theater"><%=theater_name %></p>
				<p class="auditorium"><%=auditorium_name %></p>
				<p class="date"><%=start_time %></p>
				</div>
				<img alt="" src="">
			</div>
			<hr>
			<div class="seat-choice-info">
				<div class="legend">
					d
				</div>

				<div class="myseat">
					<span>선택좌석</span>
				</div>
			</div>
			<br>
			<hr>
			<div class="pay">
			<span>최종결제금액</span>
			<span>24,000원</span>
			</div>
		</div>
	</div>
</body>
</html>