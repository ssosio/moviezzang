<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
  <title>마이페이지</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #f7f7f7;
      
    }

    .mypage-wrapper {
      display: flex;
      max-width: 1200px;
      margin: 100px auto 50px auto;
      padding: 20px;
      gap: 30px;
    }

    .mypage-content {
      flex: 1;
    }

    .mypage-header {
      background: linear-gradient(to right, #1a1a3c, #181847);
      color: white;
      padding: 20px;
      border-radius: 15px;
    }

    .mypage-header h3 {
      margin: 0;
      font-size: 20px;
    }

    .mypage-header .mileage {
      font-size: 20px;
      text-align: right;
      margin-top: 10px;
    }

    .mypage-box {
      background-color: white;
      border-radius: 10px;
      padding: 20px;
      margin-top: 20px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .mypage-section h4 {
      margin-top: 30px;
      margin-bottom: 10px;
    }

    .movie-btn {
      float: right;
      margin-top: -30px;
      margin-bottom: 10px;
      background-color: white;
      border: 1px solid #333;
      border-radius: 10px;
      padding: 5px 10px;
      cursor: pointer;
    }

  
  </style>
</head>
<body>

<div class="mypage-wrapper">
  
  <!-- Sidebar -->
<jsp:include page="sideBar.jsp"></jsp:include>

<!-- header -->
 

  <!-- Main content -->
  <div class="mypage-content">
    <div class="mypage-header">
      <h2>안녕하세요! ***님</h2>
      <h6 style="color: gray;">Welcome!</h6>
      <div class="mileage">보유 마일리지 (0P)</div>
    </div>

    <div class="mypage-section">
      <h4>마일리지 이용내역</h4>
      <div class="mypage-box">
        <p>적립예정: 0P<br />당월소멸예정: 0P</p>
      </div>
    </div>

    <div class="mypage-section">
      <h4>영화 예매 내역</h4>
      <div class="mypage-box">
        <p>영화관람권: 0매</p>
      </div>
    </div>

    <div class="mypage-section">
      <h4>나의 무비스토리</h4>
      <div class="mypage-box">
        <p>본 영화: 0</p>
      </div>
    </div>
  </div>
</div>

</body>
</html>
