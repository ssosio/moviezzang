<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>404 Not Found</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Signika:wght@700&family=DM+Sans&display=swap">
  <style>
    body {
      margin: 0;
      font-family: 'DM Sans', sans-serif;
      background: white;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      padding: 1rem;
    }

    .container {
      text-align: center;
      opacity: 0;
      transform: translateY(30px);
      animation: fadeInUp 0.7s ease forwards;
    }

    .number {
      font-size: 80px;
      font-weight: bold;
      opacity: 0.7;
      color: #222;
      font-family: 'Signika', sans-serif;
      user-select: none;
    }

    .number-wrapper {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 2rem;
      margin-bottom: 3rem;
    }

    .ghost {
      width: 80px;
      height: 80px;
      animation: float 2s ease-in-out infinite alternate;
    }

    @keyframes fadeInUp {
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @keyframes float {
      0% { transform: translateY(-5px); }
      100% { transform: translateY(5px); }
    }

    .title {
      font-size: 2rem;
      font-weight: bold;
      color: #222;
      margin-bottom: 1rem;
      opacity: 0.7;
    }

    .message {
      font-size: 1.125rem;
      color: #222;
      opacity: 0.5;
      margin-bottom: 2rem;
    }

    .btn {
      display: inline-block;
      background: #222;
      color: white;
      padding: 0.75rem 2rem;
      border-radius: 999px;
      text-decoration: none;
      font-weight: 500;
      transition: background 0.3s;
    }

    .btn:hover {
      background: #000;
    }

    .link {
      margin-top: 3rem;
      display: inline-block;
      color: #222;
      opacity: 0.5;
      text-decoration: underline;
      transition: opacity 0.3s;
    }

    .link:hover {
      opacity: 0.7;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="number-wrapper">
    <span class="number">4</span>
    <img src="${pageContext.request.contextPath}/resources/moviezzang.png" alt="Ghost" class="ghost" draggable="false" />
    <span class="number">4</span>
  </div>
  <h1 class="title">죄송합니다 페이지로드중 문제가 생겼습니다.</h1>
  <p class="message">Sorry, there was a problem loading the page !</p>
  <a onclick="location.href='<%=request.getContextPath()%>/'" class="btn">재시작</a>
  <div> 
    <a href="https://namu.wiki/w/404%20Not%20Found" class="link">404 오류가 무었인지 궁금하신분들께</a>
  </div>
</div>
</body>
</html>
