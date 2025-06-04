<%@page import="java.util.HashMap"%>
<%@page import="data.dto.UserDTO"%>
<%@page import="java.util.List"%>
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
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<title>Insert title here</title>
<script type="text/javascript">

$(function () {
	  const select = document.getElementById("monthSelect");
	  const today = new Date();

	  if (!select) {
	    console.error("select 못 찾음");
	    return;
	  }

	  for (let i = 0; i < 6; i++) {
	    const date = new Date(today.getFullYear(), today.getMonth() - i, 1);
	    const year = date.getFullYear();
	    const month = date.getMonth() + 1;

	    const option = document.createElement("option");
	    option.value = `\${year}-\${month.toString().padStart(2, '0')}`;
	    option.text = `\${year}년 \${month}월`;
	    select.appendChild(option);
	  }
	});

</script>
<style type="text/css"> 
    body {
      margin: 0;
      padding: 0;
      background-color: white;
      
    }

    .booklist-wrapper {
      display: flex;
      max-width: 1000px;
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

  	.booklist-list {
  	  border-bottom: 1px solid lightgray;
      text-align: center;         
      height: 80px;
      display: flex;              
      justify-content: center;    
      align-items: center;         
      height: 100px;
}
  
  </style>
  <%
  String userid=(String)session.getAttribute("userid");
  	UserDAO dao=UserDAO.getInstance();
  	
  	List<HashMap<String, String>> list=dao.getReserveList(userid);
  	
  %>
</head>
<body>
<div class="booklist-wrapper">
  
  <!-- sideBar -->
<jsp:include page="sideBar.jsp"></jsp:include>


  <!-- Main content -->
  <div class="booklist-content">
    <div class="booklist-header">
     <h2 class="text-2xl font-bold" style="color: #000080">예매 내역</h2>
    </div>

    <div class="booklist-section">
      <div class="booklist-box">
        <p>예매날짜</p>
        <select id="monthSelect" class="w-40 p-2 border border-gray-300 rounded-md">
  			
		</select>
      </div>
      <br>
      	<div class="booklist-list">
      		<%
      			
      		%>
      	</div>
    </div>
    <br>
     <div class="booklist-header">
     <h2 class="text-2xl font-bold" style="color: #000080">예매취소내역</h2>
    </div>
    <br>
    	<div class="booklist-list">
      		<table class="table">
      		  <tr>
      			<th style="background-color: whitesmoke">취소일시</th>
      			<th style="background-color: whitesmoke">영화명</th>
      			<th style="background-color: whitesmoke">극장</th>
      			<th style="background-color: whitesmoke">상영일시</th>
      			<th style="background-color: whitesmoke">취소금액</th>
      	     </tr>
      	     <tr>
				     	     
      	     </tr>
      	     
      		</table>
      	</div>
    
  </div>
</div>
</body>


</html>