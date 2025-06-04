<%@page import="data.dto.UserDTO"%>
<%@page import="data.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../component/menu/headerResources.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

  <title>마이페이지</title>
  <style type="text/css"> 
    body {
      margin: 0;
      padding: 0;
      background-color: white;
      
    }

    .mypage-wrapper {
      display: flex;
      max-width: 1000px;
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
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }

    .mypage-section h4 {
      margin-top: 30px;
      margin-bottom: 10px;
    }

    

  
  </style>
</head>
<%
String id=request.getParameter("id");

UserDAO dao=UserDAO.getInstance();
UserDTO dto=dao.getData(id);

%>
<body>

<div class="mypage-wrapper">
  
  <!-- sideBar -->
<jsp:include page="sideBar.jsp"></jsp:include>



  <!-- Main content -->
  <div class="mypage-content">
    <div class="mypage-header">
      <h1 class="text-2xl font-bold">안녕하세요! <%=dto.getName() %>(<%=dto.getUserid() %>)님</h1>
      <h6 style="color: gray;">Welcome!</h6>
      <div class="mileage">보유 마일리지 (<%=dto.getMileage() %>P)</div>
    </div>

    <div class="mypage-section">
      <h4 class="text-2xl font-bold" style="color: #000080">마일리지 이용내역</h4>
      <div class="mypage-box">
        <p>적립예정: 0P<br />당월소멸예정: 0P</p>
      </div>
    </div>

    <div class="mypage-section">
      <h4 class="text-2xl font-bold" style="color: #000080">영화 예매 내역</h4>
      <div class="mypage-box">
        <p>영화관람권: 0매</p>
      </div>
    </div>

    <div class="mypage-section">
      <h4 class="text-2xl font-bold" style="color: #000080">나의 무비스토리</h4>
      <div class="mypage-box">
        <p>본 영화: 0</p>
      </div>
    </div>
  </div>
</div>

</body>

</html>
