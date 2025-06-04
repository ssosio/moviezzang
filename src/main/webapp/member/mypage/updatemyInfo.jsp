<%@page import="java.util.StringTokenizer"%>
<%@page import="data.dto.UserDTO"%>
<%@page import="data.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../component/menu/headerResources.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>마이페이지</title>
  <script type="text/javascript">
  	$(function() {
  		
		$("#selemail").change(function () {
			
			if($(this).val()=='-')
				$("#email2").val('');
			else
				$("#email2").val($(this).val());
		});
	});
  	
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
    body {
      margin: 0;
      padding: 0;
      background-color: white;
      
    }

    .myinfo-wrapper {
      display: flex;
      max-width: 1100px;
      margin: 100px auto 50px auto;
      padding: 20px;
      gap: 30px;
    }

    .myinfo-content {
      flex: 1;
    }

    .myinfo-header {
      background: linear-gradient(to right, #1a1a3c, #181847);
      color: white;
      padding: 20px;
      border-radius: 15px;
      width: 800px;
    }

    .myinfo-header h3 {
      margin: 0;
      font-size: 20px;
    }

    .myinfo-header .mileage {
      font-size: 20px;
      text-align: right;
      margin-top: 10px;
    }

   /*  .mypage-box {
      background-color: white;
      border-radius: 10px;
      padding: 20px;
      margin-top: 20px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    } */

    .myinfo-section h4 {
      margin-top: 30px;
      margin-bottom: 10px;
    }
	th{
		align-content: center;
		width: 200px;
	}
    i.dash {
	color: rgba(0, 0, 0, 1);
	line-height: 40px;
	margin: 0 10px;
}

p{
	
}

  
  </style>
</head>
<%
	String id=request.getParameter("id");

	UserDAO dao=UserDAO.getInstance();
	UserDTO dto=dao.getData(id);
	
	//이메일
	StringTokenizer st=new StringTokenizer(dto.getEmail(),"@");
	String email1=st.nextToken();
	String email2=st.nextToken();
	
	//주소
	String fullAddr = dto.getAddress();
	String zipCode = "";
	

	if (fullAddr != null && fullAddr.length() > 5) {
    zipCode = fullAddr.substring(0, 5);   
	}
	
	//핸드폰
	String h1 = "";
	String h2 = "";
	String h3 = "";

	if (dto.getAddress() != null && dto.getPhone().contains("-")) {
    String[] addrParts = dto.getPhone().split("-");
    if (addrParts.length >= 3) {
    	h1 = addrParts[0];
    	h2 = addrParts[1];
    	h3 = addrParts[2];
    }
}
%>
<body>

<div class="myinfo-wrapper">
  
  <!-- sideBar -->
<jsp:include page="sideBar.jsp"></jsp:include>



  <!-- Main content -->
  <div class="myinfo-content">
    <div class="myinfo-header">
      <h1 class="text-2xl font-bold">개인정보 수정</h1>
      <h6 style="color: #D3D3D3;">회원님의 정보를 정확히 입력해주세요.</h6>
      <p style="font-size: 15pt;">ID ( <%=dto.getUserid() %> ) 님</p>
      <div class="mileage"><button type="button" class="btn btn-outline-info" style="color: white;"
      onclick="location.href='deleteAction.jsp?id=<%=dto.getId() %>&password=<%=dto.getPassword()%>'">회원탈퇴</button></div>
    </div>

    <div class="myinfo-section">
      <h4 class="text-2xl font-bold" style="color: #000080">기본정보</h4>
      <span style="color: red; margin-left: 640px;">*<b style="color: black;">는 필수</b></span>
      <form action="updateAction.jsp" method="post" onsubmit="return check(this)">
      <input type="hidden" name="id" value="<%=id%>">
        <table class="table" style="width: 700px;">
        	<tr>
        	<hr width="700">
        	<th style="background-color: whitesmoke;">이름<label style="color: red;">*</label></th>
        	<td>
        		<input type="text" class="form-control" style="width: 150px;" name="name" id="name" value="<%=dto.getName() %>"
        		required="required" placeholder="변경 할 이름">
        	</td>
        	</tr>
        	<tr>
        	<th style="background-color: whitesmoke;">비밀번호<label style="color: red;">*</label></th>
        	<td>
        		<input type="text" class="form-control"  name="password" id="password" style="width: 150px;" value="<%=dto.getPassword() %>"
        		required="required" placeholder="변경 할 비밀번호">
        		<input type="password" name="password2" id="password2" class="form-control" style="width: 150px;" required="required" placeholder="비밀번호 확인">
        	</td>
        	</tr>
        	<tr>
        	<th style="background-color: whitesmoke;">생년월일<label style="color: red;">*</label></th>
        	<td>
        		<input type="date" class="form-control" style="width: 150px;" name="birth" id="birth" value="<%=dto.getBirth()%>">
        	</td>
        	</tr>
        	<tr>
        	<th style="background-color: whitesmoke;">휴대폰<label style="color: red;">*</label></th>
        	<td class="input-group">
        	<select name="hp1" class="form-control">
						<option value="02" <%= "02".equals(h1) ? "selected" : "" %>>02</option>
						<option value="011" <%= "011".equals(h1) ? "selected" : "" %>>011</option>
						<option value="010" <%= "010".equals(h1) ? "selected" : "" %>>010</option>
					</select>
					<a><i class="bi bi-dash-lg dash"></i></a>
        		<input type="text" class="form-control"  name="hp2" style="width: 30px;" onkeyup="goFocus(this)"
        		value="<%=h2%>">
        			<i class="bi bi-dash-lg dash" style="color: black;"></i>
        		<input type="text" class="form-control"  name="hp3" style="width: 30px;"
        		value="<%=h3%>">
        	</td>
        	</tr>
        	<tr>
        	<th style="background-color: whitesmoke;">이메일<label style="color: red;">*</label></th>
        	<td class="input-group">
        		<input type="text" name="email1" id="email1" class="form-control" required="required" placeholder="이메일을 입력해주세요"
        		style="width: 100px;" value="<%=email1%>">
				<span>@</span>
				<input type="text" name="email2" id="email2" class="form-control" required="required"
				style="width: 100px;" value="<%=email2%>">
				<select id="selemail" class="form-control">
					<option value="-">직접입력</option>
					<option value="naver.com">naver.com</option>	
					<option value="gmail.com">gmail.com</option>	
					<option value="hanmail.net">hanmail.net</option>					
				</select>
        	</td>
        	</tr>
        	<tr>
        	<th style="background-color: whitesmoke;">주소</th>
        	<td>
        		<div class="col-sm-6 mb-3 mb-sm-0">
    		<input type="text" class="form-control form-control-user" id="zipCode" name="zipCode" placeholder="우편번호" readonly onclick="sample4_execDaumPostcode()"
    		value="<%=zipCode %>" style="width: 90px;">
    		<input type="text" id="streetAdr" name="streetAdr" placeholder="도로명 주소" readonly
    		value="">
    		<input type="text" id="detailAdr" name="detailAdr" placeholder="상세 주소" onclick="addrCheck()"
    		value="">
    			</div>
        	</td>
        	</tr>
        	<tr>
        		<th style="background-color: whitesmoke;">성별</th>
        		<td>
        			<input type="radio" name="gender" id="gender1" value="M"
        			 <%= "M".equals(dto.getGender())?"checked" : "" %>>남자
					<input type="radio" name="gender" id="gender2" value="F"
					 <%= "F".equals(dto.getGender())?"checked" : "" %>>여자
        		</td>
        	</tr>
        	<tr>
        		<td colspan="2" align="center">
        			<button type="button" class="btn btn-outline-dark btn-lg" onclick="location.href='mypageMain.jsp'">취소</button>&nbsp;&nbsp;
        			<button type="submit" class="btn btn-dark btn-lg">등록</button>
        		</td>
        	</tr>
        </table>
       </form>
    </div>
  </div>
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
