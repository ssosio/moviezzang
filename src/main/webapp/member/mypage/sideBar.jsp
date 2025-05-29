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
<title>Insert title here</title>
<style type="text/css">
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
</style>
</head>
<body>

   <div class="col-md-3 sidebar p-0">
        <div class="p-3">
          <h5>My MZ Page</h5>
          <a href="bookMovieList.jsp">예매내역</a>
          <a href="myMovieStory.jsp">나의 무비스토리</a>
          <a href="myInfo.jsp">회원정보 수정</a>
        </div>
      </div>
     
</body>
</html>