<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<title>회원가입</title>
<script type="text/javascript">
	$(function () {
		
		//아이디 중복체크
		$("#idCheck").click(function () {
			
			var userid=$("#id").val();
			//alert(userid);
			
			$.ajax({
				
				type:"get",
				url:"idCheck.jsp",
				dataType:"json",
				data:{"userid":userid},
				success:function(res){
					//console.log(res.idCheck);
					
					if(res.idCheck==1){
						alert("이미가입된 아이디입니다");
					}else{
						alert("가입가능한 아이디입니다");
					} 
				}
				
				
			});
			
		});
		
		//이메일선택이벤트
		$("#selecEmail").change(function () {
			
			if($(this).val()=='-')
				$("#email2").val('');
			else
				$("#email2").val($(this).val());
		});
		
	});
		
	
	 function goFocus(hp){
		 if(hp.value.length==4)
			 frm.hp3.focus();
	 }
	 
	 
	
	function check(f) {
			
		if(f.password.value!=f.password2.value){
			alert("비밀번호가 서로 다릅니다");
				f.password.value="";
				f.password2.value="";
				return false;
			}
			
		}	
	

	
</script>

<style type="text/css">
.wrap {
	
	width: 800px;
	margin: 0 auto;
	margin-top: 150px;
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

.wrap>form .email {
	height: 40px;
}
.wrap>form .email>input.email2 {
	width: 140px;
	margin-right: 10px;
}

.wrap>form .email>span {
	line-height: 40px; 
	font-weight: bold; 
	margin: 0 5px;
}
.wrap>form .email>input {
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

.wrap>form button.regis {
	margin: 0 auto;
	width: 180px; 
	margin-bottom: 50px;
}

.wrap>form .gender {
	height:	20px; 
}

.wrap>form .gender input {
	width: 30px;
	height:	20px;
}

.wrap>form .addr input {
	margin-bottom: 10px;

}

.wrap>form .phone input {
	width: 130px;

}

.wrap>form button{
	border: 1px solid #503396;
}
.wrap>form button:hover {
	background-color: #351f67;
	color: white;
}
i.dash {
	color: rgba(0, 0, 0, 1);
	line-height: 40px;
	margin: 0 10px;
}
.wrap>form button.check {
	margin-left: 5px;
}

</style>
</head>
<body>

<div class="wrap">

<form action="signupAction.jsp" method="post" onsubmit="return check(this)" name="frm">
	
	<div class="boxs">
	<label for="id">아이디</label>
		<input type="text" name="id" id="id" class="form-control" required="required" placeholder="아이디를 입력해주세요">
	<button type="button" class="btn check" id="idCheck">중복확인</button>
	</div>
	
	<div class="boxs">
	<label for="password">비밀번호</label>
		<input type="password" name="password" id="password" class="form-control" required="required" placeholder="비밀번호를 입력해주세요">
	</div>
	
	<div class="boxs">
	<label for="password2">비밀번호확인</label>
		<input type="password" name="password2" id="password2" class="form-control" required="required" placeholder="비밀번호를 한번더 입력해주세요">
	</div>
	
	<div class="boxs">
	<label for="name">이름</label>
		<input type="text" name="name" id="name" class="form-control" required="required" placeholder="이름을 입력해주세요">
	</div>
	
	<div class="boxs">
	<label for="birth">생년월일</label>
	<input type="date" name="birth" id="birth" class="form-control" value="1990-01-01" required="required">
	<input type="hidden" name="age" id="age">
	</div>
	
	<div class="boxs gender">
	<label for="">성별</label>
		<input type="radio" name="gender" id="gender1" value="M">남
		<input type="radio" name="gender" id="gender2" value="F">여
	</div> 
	
	<div class="boxs addr">
	<label for="zipCode">주소</label>
    	<div class="col-sm-6 mb-3 mb-sm-0">
    		<input type="text" class="form-control form-control-user" id="zipCode" name="zipCode" placeholder="우편번호" readonly onclick="sample4_execDaumPostcode()">
    		<input type="text" class="form-control form-control-user" id="streetAdr" name="streetAdr" placeholder="도로명 주소" readonly>
    		<input type="text" class="form-control form-control-user" id="detailAdr" name="detailAdr" placeholder="상세 주소" onclick="addrCheck()">
    	</div>
    </div>
           
	<div class="boxs phone">
	<label for="hp2">휴대폰</label>		
	<select name="hp1" class="form-control">
		<option>02</option>
		<option>011</option>
		<option>010</option>
	</select>
		<i class="bi bi-dash-lg dash"></i>
		<input type="text" name="hp2" id="hp2" required="required" class="form-control" onkeyup="goFocus(this)">
		<i class="bi bi-dash-lg dash"></i>
		<input type="text" name="hp3" id="hp3" required="required" class="form-control">
	</div>
	
	<div class="boxs email">
	<label for="email1">이메일</label>
		<input type="text" name="email1" id="email1" class="form-control" required="required" placeholder="이메일을 입력해주세요">
		<span>@</span>
		<input type="text" name="email2" id="email2" class="form-control email2" required="required">
		<select id="selecEmail" class="form-control">
			<option value="-">직접입력</option>
			<option value="naver.com">naver.com</option>	
			<option value="gmail.com">gmail.com</option>	
			<option value="hanmail.net">hanmail.net</option>					
		</select>
	</div>
	
		<button type="submit" class="btn regis" id="register">가입하기</button>
		
</form>
</div>
<script>
    function sample4_execDaumPostcode(){
        new daum.Postcode({
            oncomplete: function(data) {
            	// 우편번호
                $("#zipCode").val(data.zonecode);
                // 도로명 및 지번주소
                $("#streetAdr").val(data.roadAddress);
            }
        }).open();
    }
</script>
<script type="text/javascript">
    function addrCheck() {
        if($("#zipCode").val() == '' && $("#streetAdr").val() == ''){
            alert("우편번호를 클릭하여 주소를 검색해주세요.");
            $("#zipCode").focus();
        }
    }
</script>



</body>
</html>