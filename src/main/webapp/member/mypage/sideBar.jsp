<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<title>Insert title here</title>
<style type="text/css">

  .mypage-sidebar {
      width: 200px;
      background-color: #333;
      color: white;
      border-radius: 10px;
      padding: 20px;
      box-sizing: border-box;
    }

    .mypage-sidebar h3 {
      margin-bottom: 15px;
      font-size: 18px;
    }

    .mypage-sidebar a {
      display: block;
      color: white;
      text-decoration: none;
      padding: 10px 0;
      border-bottom: 1px solid #555;
    }

    .mypage-sidebar a:hover {
      background-color: #555;
    }
    
    h3.mmp{
    	cursor: pointer;
    	
    }
    </style>
</head>
<body>

   <!-- mypageSidebar.jsp -->
<div class="mypage-sidebar">
  <h3 class="mmp" onclick="location.href='mypageMain.jsp'">My MZ Page</h3>
  <a href="bookMovieList.jsp">예매내역</a>
  <a href="myMovieStory.jsp">나의 무비스토리</a>
  <a href="updatemyInfo.jsp">회원정보 수정</a>
</div>
     
</body>
</html>