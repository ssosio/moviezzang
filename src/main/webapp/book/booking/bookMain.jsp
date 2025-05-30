<%@page import="data.dao.MovieDAO"%>
<%@page import="java.io.DataOutput"%>
<%@page import="data.dto.MovieDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
div.container{
position: absolute;

}
div.title{
margin-top: 100px;
margin-left: 100px;
}
div.listbox{
border: 1px #ccc solid;
width: 900px;
height: 600px;
margin: 1px 100px;
display: flex;
}
div.theater-local{
width: 300px;
height: 100%;
border-right: 1px #ccc solid;
display: flex;
}
div.movie{
width: 200px;
height: 100%;
border-right: 1px #ccc solid;
overflow-y: auto;
}
div.movie ul>li{
list-style: none;
text-align: center;
}
div.movie ul{
margin-top: 10px;
}
button.movielist{
display: flex;
width: 100%;
align-items: center;
justify-content: center;
}
div.local{
width: 50%;
}
div.local ul>li{
list-style: none;
}
div.local ul{
margin-top: 40px;
}
div.local ul>li{
list-style: none;
}
div.local ul{
margin-top: 40px;
}
div.movie ul, div.local ul{
padding-left: 0px;
}
button.btnlocal{
width: 100%;
}
div.theater{
width: 50%;
margin-top: 68px;
}
div.theater ul{
padding: 0px;
}
div.theater ul>li{
list-style: none;
}
button.btntheater{
width: 100%;
text-align: center;
}
div.time{
border: none;
width: 400px;
}
div.time ul>li{
list-style: none;
}
div.time ul{
padding: 0px;
}
button.btntime{
width: 100%;
}

/*time박스내용 정렬 */
.timebox {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  padding: 5px 10px;
  box-sizing: border-box;
}

.timebox span {
  display: inline-block;
  font-size: 14px;
}

.timebox .starttime {
  flex: 1;
  text-align: left;
}

.timebox .movietitle {
  flex: 1;
  text-align: center;
}

.timebox .screeninfo {
  flex: 1;
  text-align: right;
  font-size: 12px;
  line-height: 1.3;
}

.vertical-line {
  width: 1px;
  height: 75%;
  background-color: #ccc;
  margin: auto 10px; /* 상하 가운데 정렬 */
}
div.listbox h4{
margin-top: 30px;
}
.btn-content {
  display: flex;
  align-items: center;
  justify-content: center;   /* span 텍스트를 가로 중앙 */
  position: relative;
  width: 100%;
  box-sizing: border-box;
  position: relative;
}
.btn-content img {
  position: absolute;
  width: 30px;
}
.btn-content span {
  width: 100%;
  text-align: center;
  line-height: 1.4;
  word-break: keep-all;
  padding-left: 40px;
}
</style>
</head>
<%
MovieDAO dao = MovieDAO.getInstance();
//영화 리스트 구하기
List<MovieDTO> list = dao.getAllDatas();
//절대경로
String root = getServletContext().getRealPath("/");
%>
<body>
	<div class="container">
		<div class="title">
			<h3>빠른예매</h3>
			<hr>
		</div>
		<div class="listbox">
			<div class="movie">
				<h4>&nbsp;&nbsp;&nbsp;영화</h4>
				<%= "불러온 영화 수: " + list.size() %>
				<ul>
					<%
					for(int i=0;i<list.size();i++){
					MovieDTO dto = list.get(i);
					String certification = dto.getCertification().contains("전체")?"전체":
										dto.getCertification().contains("12")?"12세":
										dto.getCertification().contains("15")?"15세":"19세";
					%>
						<li>
						<button type="button" class="movielist btn-basiclist">
						<div class="btn-content">
						<img src="../../resources/ratingimg/<%=certification %>.png" width="30px;" style="margin-right: 10px;">
						<span><%=dto.getTitle() %></span>
						</div>
						</button></li>
					<%}
					%>
				</ul>
			</div>
			<div class="theater-local">
				<div class="local">
					<h4>&nbsp;&nbsp;&nbsp;극장</h4>
					<ul>
						<li><button class="btnlocal btn-basiclist">서울</button></li>
						<li><button class="btnlocal btn-basiclist">경기</button></li>
						<li><button class="btnlocal btn-basiclist">인천</button></li>
						<li><button class="btnlocal btn-basiclist">대전/충청/세종</button></li>
						<li><button class="btnlocal btn-basiclist">부산/대구/경산</button></li>
						<li><button class="btnlocal btn-basiclist">광주/전라</button></li>
						<li><button class="btnlocal btn-basiclist">강원</button></li>
						<li><button class="btnlocal btn-basiclist">제주</button></li>
					</ul>
				</div>
				<div class="vertical-line"></div>
					<div class="theater">
						<ul>
							<li><button class="btntheater btn-basiclist">1</button></li>
							<li><button class="btntheater btn-basiclist">2</button></li>
							<li><button class="btntheater btn-basiclist">3</button></li>
							<li><button class="btntheater btn-basiclist">4</button></li>
							<li><button class="btntheater btn-basiclist">5</button></li>
							<li><button class="btntheater btn-basiclist">6</button></li>
							<li><button class="btntheater btn-basiclist">7</button></li>
							<li><button class="btntheater btn-basiclist">8</button></li>
							<li><button class="btntheater btn-basiclist">9</button></li>
							<li><button class="btntheater btn-basiclist">10</button></li>
							<li><button class="btntheater btn-basiclist">11</button></li>
						</ul>
					</div>
			</div>
			<div class="time">
			<form action="../seat/seatForm.jsp">
			<h4>&nbsp; &nbsp; &nbsp;시간</h4>
			<%
			 Date today = new Date();
			SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
			String todate = sdf.format(today);
			%>
				<input type="date" class="form-control" style="max-width: 40%; margin:40px 100px;" value="<%=todate%>">
				<ul>
					<li>
						<button class="btntime btn-basiclist" type="submit">
							<div class="timebox">
								<span class="starttime"><b style="font-size: 1.2em">14:00</b>~16:22</span>
								<span class="movietitle">영화1이야</span>
								<span class="screeninfo">강원 <br>6관 <br>123/234</span>
							</div>
						</button>
					</li>
					<li>
						<button class="btntime btn-basiclist" type="submit">
							<div class="timebox">
								<span class="starttime"><b style="font-size: 1.2em">15:10</b>~17:32</span>
								<span class="movietitle">영화1이야</span>
								<span class="screeninfo">강원<br>4관 <br>26/114</span>
							</div>
						</button>
					</li>
					<li>
						<button class="btntime btn-basiclist" type="submit">
							<div class="timebox">
								<span class="starttime"><b style="font-size: 1.2em">15:40</b>~18:24</span>
								<span class="movietitle">영화1이야</span>
								<span class="screeninfo">강원 <br>1관 <br>78/144</span>
							</div>
						</button>
					</li>
					<li>
						<button class="btntime btn-basiclist" type="submit">
							<div class="timebox">
								<span class="starttime"><b style="font-size: 1.2em">16:20</b>~18:42</span>
								<span class="movietitle">영화1이야</span>
								<span class="screeninfo">강원 <br>5관 <br>111/132</span>
							</div>
						</button>
					</li>
				</ul>
				</form>
			</div>
		</div>
	</div>
</body>
</html>