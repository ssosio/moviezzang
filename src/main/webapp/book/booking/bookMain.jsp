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
width: 900px;
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
padding-bottom: 10px;
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
overflow-y: auto;
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
  left:0px;
  width: 30px;
}
.btn-content span {
  width: 100%;
  text-align: center;
  line-height: 1.4;
  word-break: keep-all;
  padding-left: 40px;
}
div.movielist-section{
margin-top: 50px;
}
</style>
<script type="text/javascript">
$(function() {
	let currentMovie_id = null;

	//영화 클릭하면.
	$("button.movielist").click(function() {
		const movie_id = $(this).attr("movie_id");
		currentMovie_id = movie_id;
		//alert(movieid);

		$.ajax({
			type:"get",
			url:"<%=request.getContextPath()%>/book/booking/bookList.jsp",
			dataType:"json",
			data:{movie_id:currentMovie_id},
			success:function(res){
				//alert("성공");
				console.log(res);

			    $("button.btnlocal").each(function() {
			          let originalText = $(this).text().split("(")[0].trim(); // "서울 (3)" -> "서울" 기존 텍스트 초기화
			          $(this).text(originalText);
			        });
				$.each(res,function(i,item){

					$("button.btnlocal").each(function(){

						let regionName = $(this).text().trim();
						if(regionName == item.region){
							$(this).text(item.region + "(" +item.theater_count +")");
						}
					});

				});
			}
		})
	});

		//지역선택하면 상영극장 출력
	$(document).on("click","button.btnlocal",function(){
		const region =  $(this).text().split("(")[0].trim();

		if(!currentMovie_id){
		alert("먼저 영화를 선택해주세요");
		return;
		}
		$.ajax({

			type:"get",
			dataType:"json",
			data:{movie_id : currentMovie_id,
					region : region
			},
			url : "<%=request.getContextPath()%>/book/booking/theaterList.jsp",
			success:function(res){
				let h = "";
				$.each(res,function(i,item){
					h+= "<li><button class='btntheater btn-basiclist'>"+item.theater_name+"</button></li>";
				});
				console.log(h);
				$("#theater").html(h);
			},
		    error: function(xhr, status, error) {
		      console.log("지역별 극장 요청 실패:", error);
		    }
		});
	});

	//상영관 클릭시 정보
	$(document).on("click",".btntheater",function(){

		const theaterName = $(this).text();
		//alert(theater);
		//alert(currentMovie_id);
		$.ajax({

			type:"get",
			data:{theaterName : theaterName,
					movie_id : currentMovie_id
			},
			dataType:"json",
			url:"<%=request.getContextPath()%>/book/booking/showTimes.jsp",
			success:function(res){
				console.log(res);
				let show = "";
				$.each(res,function(i,item){

				let start = new Date(item.start_time); // 시작시간  Date객체변환
				let runtime = parseInt(item.runtime); //런타임 형변환
				let end = new Date(start.getTime() + runtime * 60000); //끝나는 시간 계산 1분= 60000ms

				//format과정
				let startStr = start.getHours().toString().padStart(2,"0") + ":" +
									start.getMinutes().toString().padStart(2,"0");
				let endStr = end.getHours().toString().padStart(2,"0") + ":" +
								  end.getMinutes().toString().padStart(2,"0");


				show+= "<li>"+
							"<form action='<%=request.getContextPath()%>/book/seat/seatForm.jsp' method='post'>"+
							"<input type='hidden' name='screening_id' value='" + item.screening_id + "'>" +
							"<input type='hidden' name='poster' value='"+ item.poster + "'>" +
							"<button class='btntime btn-basiclist' type='submit'>"+
						    "<div class='timebox'>"+
						    "<span class='starttime'><b style='font-size: 1.2em'>"+startStr+"</b>~<br>&nbsp;&nbsp;&nbsp;"+endStr +"</span>"+
						    "<span class='movietitle'>"+item.title+"</span>"+
						    "<span class='screeninfo'>"+item.theater_name+"<br>"+item.auditorium_name+"<br>"+item.remaining_seat+"/"+item.total_seat+"</span>"+
						    "</div>"+
						    "</button>"+
						    "</form>"+
						    "</li>";

				});
				$(".showtimes").html(show);
			}
		});

	});


	//btn 토글클래스
	$(document).on("click",".movielist",function(){
		$(".movielist").removeClass("btn-active");
		$(this).addClass("btn-active");
	});
	$(document).on("click",".btnlocal",function(){
		$(".btnlocal").removeClass("btn-active");
		$(this).addClass("btn-active");
	});
	$(document).on("click",".btntheater",function(){
		$(".btntheater").removeClass("btn-active");
		$(this).addClass("btn-active");
	});
})
</script>
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
		<div></div>
		<div class="listbox">
			<div class="movie">
				<h4>&nbsp;&nbsp;&nbsp;영화</h4>
				<div class="movielist-section">
				<ul>
					<%
					for(int i=0;i<list.size();i++){
					MovieDTO dto = list.get(i);
					String certification = dto.getCertification().contains("전체")?"전체":
										dto.getCertification().contains("12")?"12세":
										dto.getCertification().contains("15")?"15세":"19세";
					%>
						<li>
						<button type="button" class="movielist btn-basiclist" movie_id="<%=dto.getId() %>">
						<div class="btn-content">
						<img src="../../resources/ratingimg/<%=certification %>.png" width="30px;" style="margin-right: 10px;">
						<span><%=dto.getTitle() %></span>
						</div>
						</button></li>
					<%}
					%>
				</ul>
				</div>
			</div>
			<div class="theater-local">
				<div class="local">
					<h4>&nbsp;&nbsp;&nbsp;극장</h4>
					<ul id="locals">
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
						<ul id="theater">
						</ul>
					</div>
			</div>
			<div class="time">
			<h4>&nbsp; &nbsp; &nbsp;시간</h4>
				<ul class="showtimes">
				</ul>
			</div>
		</div>
	</div>
</body>
</html>