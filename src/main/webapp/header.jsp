<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
      tailwind.config = {
        theme: {
          extend: {
            colors: { primary: "#352461", secondary: "#503396" },
            borderRadius: {
              none: "0px",
              sm: "4px",
              DEFAULT: "8px",
              md: "12px",
              lg: "16px",
              xl: "20px",
              "2xl": "24px",
              "3xl": "32px",
              full: "9999px",
              button: "8px",
            },
          },
        },
      };
    </script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css"
    />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
 
</head>
<body class="bg-white pt-[72px]">
 <header class="w-full bg-black text-white fixed top-0 left-0 right-0 z-50">
      <div class="container mx-auto px-4 py-3 bg-black">
        <div class="flex justify-between items-center">
          <nav
            class="hidden md:flex items-center space-x-12"
            style="padding-left: 25rem"
          >
            <a href="" class="text-primary transition-colors">영화</a>
            <a href="" class="hover:text-primary transition-colors">극장</a>
            <a href="" class="hover:text-primary transition-colors">예매</a>
            <a href="" class="flex items-center space-x-2">
              <img
                src="https://static.readdy.ai/image/12bfdaa4bfcf1b50ecec721ef7feb22b/430a084c59d6bf1f60f916f809d7bf0e.png"
                alt="영화짱닷컴"
                class="h-16"
              />
            </a>
            <a href="" class="hover:text-primary transition-colors">스토어</a>
            <a href="" class="hover:text-primary transition-colors">이벤트</a>
            <a href="" class="hover:text-primary transition-colors">혜택</a>
          </nav>
          <div class="flex items-center space-x-6">
            <div
              class="w-8 h-8 flex items-center justify-center hover:text-primary transition-colors cursor-pointer"
            >
              <i class="ri-search-line ri-lg"></i>
            </div>
            <a href="" class="text-sm hover:text-primary transition-colors"
              >로그인</a
            >
            <a href="" class="text-sm hover:text-primary transition-colors"
              >회원가입</a
            >
            <a
              href=""
              class="bg-primary text-white px-6 py-2 !rounded-button whitespace-nowrap text-sm hover:bg-opacity-90 transition-colors"
              >빠른예매</a
            >
          </div>
        </div>
      </div>
    </header>
</body>
</html>