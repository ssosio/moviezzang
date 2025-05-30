<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 
 
</head>
<body class="bg-white pt-[72px]">
 <header class="w-full bg-black text-white fixed top-0 left-0 right-0 z-50">
      <div class="container mx-auto px-4 py-3 bg-black">
        <div class="flex justify-between items-center">
          <nav
            class="hidden md:flex items-center space-x-12 justify-center mx-auto"
            style="padding-left: 13rem"
          >
            <a href="" class="text-primary transition-colors">영화</a>
            <a href="" class="hover:text-primary transition-colors">극장</a>
            <a href="" class="hover:text-primary transition-colors">예매</a>
            <a href="" class="flex items-center space-x-2">
              <img
                src="https://static.readdy.ai/image/12bfdaa4bfcf1b50ecec721ef7feb22b/430a084c59d6bf1f60f916f809d7bf0e.png"
                alt="영화짱닷컴"
                class="h-12 max-w-none"
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
            <a href="member/login/loginForm.jsp" class="text-sm hover:text-primary transition-colors"
              >로그인</a
            >
            <a href="member/signup/signupForm.jsp" class="text-sm hover:text-primary transition-colors"
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
<%-- <% for (int i = 0; i < 100; i++) { %>
    <br>
<% } %> --%>
</html>