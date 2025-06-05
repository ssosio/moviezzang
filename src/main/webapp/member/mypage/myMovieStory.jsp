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

    .mystory-wrapper {
      display: flex;
      max-width: 1000px;
      margin: 100px auto 50px auto;
      padding: 20px;
      gap: 30px;
    }

    .mystory-content {
      flex: 1;
    }

    .mystory-header {
      background: linear-gradient(to right, #1a1a3c, #181847);
      color: white;
      padding: 20px;
      border-radius: 15px;
    }

    .mystory-header h3 {
      margin: 0;
      font-size: 20px;
    }

    .mystory-header .mileage {
      font-size: 20px;
      text-align: right;
      margin-top: 10px;
    }

    .mystory-box {
      background-color: white;
      border-radius: 10px;
      padding: 20px;
      margin-top: 20px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }

    .mystory-section h4 {
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

<div class="mystory-wrapper">
  
  <!-- sideBar -->
<jsp:include page="sideBar.jsp"></jsp:include>



  <!-- Main content -->
  <div class="mystory-content">
    <div class="mystory-header">
        <h4 class="text-2xl font-bold">나의 무비스토리</h4>
    </div>

    <div class="mystory-section">
      
      <div class="mystory-box">
        <table class="table">
        	<tr>
        		<th>영화정보</th>
        		<th>한줄평</th>
        		<th>평점</th>
        	</tr>
        	<<tr></tr>
        </table>
      </div>
    </div>

    
  </div>
</div>

</body>

</html>
