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
      height: 100vh;
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
    }
    .card-box {
      background-color: white;
      border-radius: 10px;
      padding: 20px;
      margin-top: 20px;
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
<body>
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-3 sidebar p-0">
        <div class="p-3">
          <h5>My MZ Page</h5>
          <a href="#">예매내역</a>
          <a href="#">나의 무비스토리</a>
          <a href="#">회원정보</a>
        </div>
      </div>

      <div class="col-md-9">
        <div class="mypage-header">
          <h3>안녕하세요! ***님</h3>
          <p>현재 마일리지 (0P)</p>
          <div class="step-line">
            <span>Welcome!</span>
          </div>
        </div>

        <div class="row">
          <div class="col-md-4">
            <div class="card-box">
              <h6>마일리지 이용내역</h6>
              <p>적립예정: 0P<br />당월소멸예정: 0P</p>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card-box">
              <h6>관람권/쿠폰</h6>
              <p>영화관람권: 0매<br />스토어교환권: 0매<br />할인쿠폰: 0매</p>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-md-6">
            <div class="card-box">
              <h6>나의 무비스토리</h6>
              <p>본 영화: 0</p>
            </div>
          </div>
        
        </div>

        <div class="text-end mt-3">
          <a href="#">더보기 &gt;</a>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
