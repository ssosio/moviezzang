<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
<style>
    body {
      background-color: #f7f7f7;
      
    }
    
    .sidebar {
      background-color: #333;
      color: white;
      height: 400px;
      width: 200px;
      border-radius: 15px;
      
    }
    .sidebar a {
      display: block;
      color: white;
      padding: 12px;
      text-decoration: none;
      border-bottom: 1px solid #444;
      
    }
    .sidebar a:hover {
      background-color: #555;
    }
    .mypage-header {
      background: linear-gradient(to right, #1a1a3c, #181847);
      color: white;
      padding: 20px;
      width: 740px;
      height: 150px;
      border-radius: 15px;
    }
    .card-box {
      background-color: white;
      border-radius: 10px;
      padding: 20px;
      margin-top: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
   
    
 
    .step-line {
      display: flex;
      justify-content: space-between;
      margin-top: 10px;
    }
    .step-line span {
      color: gray;
    }
    .active-step {
      color: #00d2ff;
    }
  </style>
</head>
<body class="d-flex justify-content-center align-items-center min-vh-100">
  <div class="container-fluid" style="margin-left: 450px;">
    <div class="row">
      <div class="col-md-3 sidebar p-0">
        <div class="p-3">
          <h5>My MZ Page</h5>
          <a href="bookMovieList.jsp">예매내역</a>
          <a href="myMovieStory.jsp">나의 무비스토리</a>
          <a href="myInfo.jsp">회원정보 수정</a>
        </div>
      </div>

      <div class="col-md-9">
        <div class="mypage-header">
          <h3>안녕하세요! ***님</h3>
          <p style="float: right; font-size: 15pt; margin-top: 40px;">보유 마일리지 (0P)</p>
          <div class="step-line">
            <span>Welcome!</span>
          </div>
        </div>

        <div class="row">
          <div class="col-md-4" style="margin-top: 20px;">
           <h4>마일리지 이용내역</h4>
            <div class="card-box">
              <p>적립예정: 0P<br />당월소멸예정: 0P</p>
            </div>
          </div>
          <div class="col-md-4" style="margin-top: 20px;">
          <h4>영화 예매 내역</h4>
            <div class="card-box">
              <p>영화관람권: 0매</p>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-md-6" style="margin-top: 20px;">
          <h4>나의 무비스토리</h4>
           <button type="button" onclick="location.href='#'" style="border-radius: 10px; float: right;"
           		 class="btn btn-outline-dark">본 영화 등록</button>
            <div class="card-box">
              <p>본 영화: 0</p>         
          </div>
        
        </div>

        
      </div>
    </div>
  </div>
</body>
</html>
