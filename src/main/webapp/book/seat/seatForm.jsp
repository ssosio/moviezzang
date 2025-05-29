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
</head>
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
				<p>스파이더맨</p>
			</div>
			<hr>
			<div class="pay-info">
				<div class="pay-infosrting">
				<p class="theater">강원</p>
				<p class="auditorium">6관</p>
				<p class="date">2025.05.29(목)</p>
				</div>
				<img alt="" src="data:image/jpeg;base64,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">
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