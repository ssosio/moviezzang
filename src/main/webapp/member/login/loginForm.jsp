<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> -->
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
<jsp:include page="../../component/menu/header.jsp"/>
<%@ include file="../../component/menu/headrResources.jsp" %>
<div class="container mt-3">
  <img alt="" src="../../resources/moviezzang_yellow.png">
    Login
</div>


<jsp:include page="../../component/menu/footer.jsp"/>
</body>
</html>