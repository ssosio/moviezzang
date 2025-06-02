<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Loading Animation with Image</title>
  <style>
    /* 스타일 격리 */
    
    #loading-container {
       position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(255, 255, 255, 0.3); /* 흰색 30% 투명도 */
    /* 또는 검은색 배경: rgba(0, 0, 0, 0.5) */
    z-index: 9999;
    display: flex;
    justify-content: center;
    align-items: center;
    }

    .boxLoading {
      width: 60px;
      height: 50px;
      margin: auto;
      position: relative;
    }

    .boxLoading img {
      width: 60px;
      height: 50px;
      animation: rotateImage 1.5s linear infinite;
      border-radius: 3px;
    }

    .boxLoading:before {
      content: '';
      width: 50px;
      height: 5px;
      background: #000;
      opacity: 0.1;
      position: absolute;
      top: 59px;
      left: 0;
      border-radius: 50%;
      animation: shadow 0.5s linear infinite;
    }

    .boxLoading:after {
      content: '';
      width: 50px;
      height: 50px;
      background: #B889DE;
      animation: animate 0.5s linear infinite;
      position: absolute;
      top: 0;
      left: 0;
      border-radius: 3px;
    }

    @keyframes rotateImage {
      0% {
        transform: rotate(0deg);
      }
      100% {
        transform: rotate(360deg);
      }
    }

    @keyframes animate {
      17% {
        border-bottom-right-radius: 3px;
      }
      25% {
        transform: translateY(9px) rotate(22.5deg);
      }
      50% {
        transform: translateY(18px) scale(1, .9) rotate(45deg);
        border-bottom-right-radius: 40px;
      }
      75% {
        transform: translateY(9px) rotate(67.5deg);
      }
      100% {
        transform: translateY(0) rotate(90deg);
      }
    }

    @keyframes shadow {
      0%, 100% {
        transform: scale(1, 1);
      }
      50% {
        transform: scale(1.2, 1);
      }
    }

  </style>
</head>
<body>
  <div id="loading-container">
    <div class="boxLoading">

    </div>
  </div>
</body>
</html>
