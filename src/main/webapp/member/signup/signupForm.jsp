<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$(function () {
		
		
		//이메일선택이벤트
		$("#selemail").change(function () {
			
			if($(this).val()=='-')
				$("#email2").val('');
			else
				$("#email2").val($(this).val());
		});
	});

function check(f) {
	
	if(f.pass.value!=f.pass2.value){
		alert("비밀번호가 서로 다릅니다");
		f.pass.value="";
		f.pass2.value="";
		return false;
	}
	
}	
	
</script>

<style type="text/css">
.wrap {
	
	position: absolute;
	width: 800px;
	left: 300px;
	top: 200px;
}

.wrap>form {

	display: flex;
	flex-direction: column;
}

.wrap>form .boxs{
	display: flex;
	flex-direction: row;
	margin-bottom: 30px;
}

.wrap>form div:nth-child(7) {
	height: 40px;
}
.wrap>form div:nth-child(7) input {
	width: 200px;
}
.wrap>form label {
	margin-right: 20px; 
	display:inline-block;
	text-align:left;
	width: 120px;
}

.wrap>form input {
	width: 350px;
}

.wrap>form .boxs>select {
	width: 150px;
}

.wrap>form button.gaip {
	margin: 0 auto;
	width: 180px;
}
</style>
</head>
<body>
<div class="wrap">
<form action="" method="post" onsubmit="">
	
	<div class="boxs">
	<label for="id">아이디</label>
	<input type="text" name="id" id="id" class="form-control" maxlength="10" required="required" placeholder="아이디를 입력해주세요">
	<button type="button" class="btn btn-outline-success" id="btnCheck">중복확인</button>
	</div>
	
	<div class="boxs">
	<label for="password">비밀번호</label>
		<input type="password" name="pass" id="password" class="form-control" required="required" placeholder="비밀번호를 입력해주세요">
	</div>
	
	<div class="boxs">
	<label for="password">비밀번호확인</label>
		<input type="password" name="pass2" id="password" class="form-control" required="required" placeholder="비밀번호를 한번더 입력해주세요">
	</div>
	
	<div class="boxs">
	<label for="password">이름</label>
		<input type="text" name="name" id="name" class="form-control" required="required" placeholder="이름을 입력해주세요">
	</div>
	
	<div class="boxs">
	<label for="birth">생년월일</label>
		<input type="text" name="birth" id="birth" class="form-control" required="required" placeholder="생년월일을 입력해주세요">
	</div>
	
	<div class="boxs">
	<label for="phone">휴대폰</label>
		<input type="number" name="phone" id="phone" class="form-control" required="required" placeholder="연락처를 입력해주세요">
	</div>
	
	<div class="boxs">
	<label for="email1">이메일</label>
		<input type="text" name="email1" id="email1" class="form-control" required="required" placeholder="이메일을 입력해주세요">
		<span>@</span>
		<input type="text" name="email2" id="email2" class="form-control" required="required">
		<select id="selemail" class="form-control">
			<option value="-">직접입력</option>
			<option value="naver.com">네이버</option>	
			<option value="gmail.com">구글</option>	
			<option value="hanmail.net">다음</option>					
		</select>
		<button type="button" class="btn btn-outline-success" id="btnCheck">중복확인</button>
	</div>
	
		<button type="submit" class="btn btn-outline-info gaip">가입하기</button>
		
</form>
</div>

</body>
</html>