<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../component/menu/headerResources.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>

<style type="text/css"> 
    body {
      margin: 0;
      padding: 0;
      background-color: #f7f7f7;
      
    }

    .booklist-wrapper {
      display: flex;
      max-width: 1200px;
      margin: 100px auto 50px auto;
      padding: 20px;
      gap: 30px;
    }

    .booklist-content {
      flex: 1;
    }

    /* .booklist-header {
      background: linear-gradient(to right, #1a1a3c, #181847);
      color: white;
      padding: 20px;
      border-radius: 15px;
    } */

    .booklist-header h3 {
      margin: 0;
      font-size: 20px;
    }

    .booklist-header .mileage {
      font-size: 20px;
      text-align: right;
      margin-top: 10px;
    }

    .booklist-box {
      background-color: white;
      border-radius: 10px;
      padding: 20px;
      margin-top: 20px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }

    .booklist-section h4 {
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
<div class="booklist-wrapper">
  
  <!-- sideBar -->
<jsp:include page="sideBar.jsp"></jsp:include>

<!-- header -->
<jsp:include page="../../component/menu/header.jsp"></jsp:include>

  <!-- Main content -->
  <div class="booklist-content">
    <div class="booklist-header">
     <h2 class="text-3xl font-bold" style="color: #000080">예매 내역</h2>
    </div>

    <div class="booklist-section">
      <div class="booklist-box">
        <p></p>
      </div>
    </div>

    <div class="booklist-section">
      <h4 class="text-2xl font-bold" style="color: #000080">영화 예매 내역</h4>
      <div class="booklist-box">
        <p>영화관람권: 0매</p>
      </div>
    </div>

    <div class="booklist-section">
      <h4 class="text-2xl font-bold" style="color: #000080">나의 무비스토리</h4>
      <div class="booklist-box">
        <p>본 영화: 0</p>
      </div>
    </div>
  </div>
</div>

</body>
<!-- footer -->
<jsp:include page="../../component/menu/footer.jsp"></jsp:include>
</html>
