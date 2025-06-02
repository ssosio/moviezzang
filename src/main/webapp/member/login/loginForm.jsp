<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<title>로그인</title>

<style type="text/css">
.modal-header {
	background: #503396;
	color: #fff;
	height: 50px;
}

input.id {
	margin-bottom: 30px;
}

input.pass {
	margin-bottom: 30px;
}

.loginbtn {
	width: 300px;
	background: #503396;
	color: #fff;
	margin: 0 auto;
}

.loginbtn:hover {
	background: #351f67; 
}

.close i{
	color: white;
	margin-left: 330px;
}
</style>
</head>
<body>


<div class="container mt-3">
  <img alt="" src="">
  <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal"  style="margin: 100px;">
    Login
  </button>
</div>

<!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">로그인</h4>
        <button type="button" class="btn close" data-bs-dismiss="modal"><i class="bi bi-x-lg"></i></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <input type="text" name="id" class="form-control id" placeholder="아이디" required="required">
        <input type="password" name="password" class="form-control pass" placeholder="비밀번호" required="required">
        <input type="checkbox">아이디 저장
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn loginbtn" data-bs-dismiss="modal">로그인</button>
      </div>

    </div>
  </div>
</div>

</body>
</html>