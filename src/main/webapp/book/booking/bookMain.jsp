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
border: 1px gray solid;
width: 800px;
height: 600px;
margin: 1px 100px;
display: flex;
}

div.movie{
width: 150px;
height: 100%;
border: 1px gray solid;
}
button.movielist{
width: 140px;
}
div.movie ul>li, div.theater ul>li{
list-style: none;
text-align: center;
}
div.movie ul, div.theater ul{
padding-left: 0px;
}
button.local{
width: 240px;
}
div.theater{
width: 250px;
height: 100%;
border: 1px gray solid;
}
</style>
</head>
<body>
	<div class="container">
		<div class="title">
			<h3>빠른예매</h3>
			<hr>
		</div>
		<div class="listbox">
			<div class="movie">
				<h4>&nbsp;&nbsp;&nbsp;영화</h4>
				<ul style="margin-top: 20px;">
					<li><button type="button" class="movielist btn-basiclist">영화1</button></li>
					<li><button type="button" class="movielist btn-basiclist">영화2</button></li>
					<li><button type="button" class="movielist btn-basiclist">영화3</button></li>
					<li><button type="button" class="movielist btn-basiclist">영화4</button></li>
					<li><button type="button" class="movielist btn-basiclist">영화5</button></li>
				</ul>
			</div>
			<div class="theater">
				<h4>&nbsp;&nbsp;&nbsp;극장</h4>
				<ul>
					<li><button class="local btn-basiclist">서울</button></li>
					<li><button class="local btn-basiclist">경기</button></li>
					<li><button class="local btn-basiclist">인천</button></li>
					<li><button class="local btn-basiclist">대전/충청/세종</button></li>
					<li><button class="local btn-basiclist">부산/대구/경산</button></li>
					<li><button class="local btn-basiclist">광주/전라</button></li>
					<li><button class="local btn-basiclist">강원</button></li>
					<li><button class="local btn-basiclist">제주</button></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>