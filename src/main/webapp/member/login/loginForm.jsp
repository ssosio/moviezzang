<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<title>로그인</title>
<%
	String userid=(String)session.getAttribute("userid");
	String saveid=(String)session.getAttribute("chkidok");
	
	boolean save=true;
	
	if(saveid==null){
		
		userid="";
		save=false;
	  }
	
	
%>
<style type="text/css">
</style>
</head>
<body>

	<div id="shadow-login-host"></div>
	<script>
  // 1. Shadow Root 생성
  const host = document.getElementById('shadow-login-host');
  const shadow = host.attachShadow({ mode: 'open' });


  // 2. Shadow DOM 내부에 모달 삽입
  shadow.innerHTML = `
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    
    <style>
    .form-control {
        display: block;
        width: 100%;
        padding: .375rem .75rem;
        font-size: 1rem;
        font-weight: 400;
        line-height: 1.5;
        color: darkgray;
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        background-color: var(--bs-body-bg)
    --bs-body-bg is not defined
    ;
        background-clip: padding-box;
        border: solid 1px;
        border-radius: 10px;
        border-color: darkgrey;
        transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
    }
    .model-content {
    	border-radius = 10px ;
    }
    .modal-body {
        background-color: white;
        position: relative;
        flex: 1 1 auto;
        padding: var(--bs-modal-padding);
    }
    .modal-footer {
        border-top: seashell;
        background-color: white;
        display: flex
    ;
        flex-shrink: 0;
        flex-wrap: wrap;
        align-items: center;
        justify-content: flex-end;
        padding: calc(var(--bs-modal-padding) - var(--bs-modal-footer-gap) * .5);
        border-top: 10px;
        border-bottom-right-radius: 10px;
        border-bottom-left-radius: 10px;
    }

    .loginbtn {
        border-radius: 10px;
        width: 300px;
        background: #503396;
        color: #fff;
        margin: 0 auto;
    }
      .modal { display: none; position: fixed; z-index: 1050; left: 0; top: 0; width: 100vw; height: 100vh; background: rgba(0,0,0,0.5); }
      .modal.show { display: block; }
      .modal-header {
    	    border-radius: 10px 10px 0 0;
    	    background: #503396;
    	    color: #fff;
    	    height: 50px;
    	}
      input.id { margin-bottom: 30px; }
      input.pass { margin-bottom: 30px; }
      .loginbtn { width: 300px; background: #503396; color: #fff; margin: 0 auto; }
      .loginbtn:hover { background: #351f67; }
      .close i { color: white; margin-left: 330px; }
    </style>
    
    <div class="modal" id="myModal" tabindex="-1" aria-modal="true" role="dialog">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">로그인</h4>
            <button type="button" class="btn close" id="closeBtn"><i class="bi bi-x-lg"></i></button>
          </div>
          <div class="modal-body">
          
          <input type="text" name="userid" id="userid" class="form-control id" placeholder="아이디" value="${userid}">
          <input type="password" id="password" name="password" class="form-control pass" placeholder="비밀번호" required="required" value="${password}">
          <input type="checkbox" name="chkid" id="chkid" ${save ? "checked" : ""}>아이디 저장
          
          </div>
          <div class="modal-footer">
            <button type="button" class="btn loginbtn" id="loginBtn" onclick="">로그인</button>
          </div>
        </div>
      </div>

    </div>
  `;

  // 3. 외부 버튼 클릭 시 모달 show
  window.openShadowLoginModal = function() {
    shadow.getElementById('myModal').classList.add('show');
    document.body.style.overflow = "hidden";
  };
  

  // 4. 모달 닫기
  shadow.getElementById('closeBtn').onclick = () => {
    shadow.getElementById('myModal').classList.remove('show');
  };
  
  shadow.getElementById('loginBtn').onclick = () => {
	  location.href='member/login/loginAction.jsp?userid=' + shadow.getElementById('userid').value + '&password=' + shadow.getElementById('password').value;
  }
  

</script>

</body>
</html>