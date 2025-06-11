
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style>
.mb-4 {
    margin-bottom: 1rem !important;
}
</style>
<body>
	<!-- 푸터 -->
	<footer class="bg-gray-900 text-white py-12">
		<div class="container mx-auto px-4">
			<div class="flex flex-col md:flex-row justify-between mb-8">
				<div class="mb-6 md:mb-0">
					<a href="#" class="flex items-center space-x-2 mb-4 inline-block">
						<img
						src="${pageContext.request.contextPath}/resources/moviezzang.png"
						alt="영화짱닷컴" class="h-10" />
					</a>
					<p class="text-gray-400 max-w-md">영화짱닷컴은 최고의 영화 경험을 제공하기 위해 항상
						노력하고 있습니다. 편안한 좌석과 최신 기술로 여러분의 영화 관람을 더욱 특별하게 만들어 드립니다.</p>
				</div>
				<div class="grid grid-cols-2 md:grid-cols-3 gap-8">
					<div>
						<h3 class="!text-lg !font-bold !mb-4">이용안내</h3>
						<ul class="!space-y-2 !pl-0">
							<li><a href="?main=movie/movieList.jsp"
								class="!text-gray-400 hover:!text-white !no-underline !transition-colors">영화</a>
							</li>
							<li><a href="#"
								class="!text-gray-400 hover:!text-white !no-underline !transition-colors">요금안내</a>
							</li>
							<li><a href="#"
								class="!text-gray-400 hover:!text-white !no-underline !transition-colors">우대혜택</a>
							</li>
							<li><a href="#"
								class="!text-gray-400 hover:!text-white !no-underline !transition-colors">관람등급</a>
							</li>
						</ul>
					</div>

					<div>
						<h3 class="text-lg font-bold mb-4">고객센터</h3>
						<ul class="space-y-2 !pl-0">
							<li><a href="#"
								class="!text-gray-400 hover:!text-white !no-underline !transition-colors">FAQ</a>
							</li>
							<li><a href="#"
								class="!text-gray-400 hover:!text-white !no-underline !transition-colors">1:1
									문의</a></li>
							<li><a href="#"
								class="!text-gray-400 hover:!text-white !no-underline !transition-colors">분실물
									문의</a></li>
							<li><a href="#"
								class="!text-gray-400 hover:!text-white !no-underline !transition-colors">단체관람</a>
							</li>
						</ul>
					</div>
					<div>
						<h3 class="text-lg font-bold mb-4">회사정보</h3>
						<ul class="space-y-2 !pl-0">
							<li><a href="#"
								class="!text-gray-400 hover:!text-white !no-underline !transition-colors">회사소개</a>
							</li>
							<li><a href="#"
								class="!text-gray-400 hover:!text-white !no-underline !transition-colors">인재채용</a>
							</li>
							<li><a href="#"
								class="!text-gray-400 hover:!text-white !no-underline !transition-colors">제휴/광고문의</a>
							</li>
							<li><a href="#"
								class="!text-gray-400 hover:!text-white !no-underline !transition-colors">윤리경영</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="border-t border-gray-800 pt-8">
				<div class="flex flex-col md:flex-row justify-between items-center">
					<div class="mb-4 md:mb-0">
						<p class="text-gray-400 text-sm">서울특별시 강남구 영화로 123 영화짱닷컴빌딩 10층
						</p>
						<p class="text-gray-400 text-sm">대표이사: 김영화 | 사업자등록번호:
							123-45-67890</p>
						<p class="text-gray-400 text-sm">통신판매업신고번호: 제2025-서울강남-0123호</p>
						<p class="text-gray-400 text-sm">고객센터: 1544-0000 (평일
							09:00~18:00)</p>
						<p class="text-gray-400 text-sm mt-2">&copy; 2025 영화짱닷컴. All
							Rights Reserved.</p>
					</div>
					<div class="!flex space-x-4 ">
						<a href="#"
							class="w-10 h-10 !bg-gray-800 !text-white !rounded-full !no-underline flex items-center justify-center hover:!bg-primary !transition-colors">
							<div class="w-5 h-5 flex items-center justify-center">
								<i class="ri-facebook-fill"></i>
							</div>
						</a> <a href="#"
							class="w-10 h-10 bg-gray-800 rounded-full flex items-center !text-white !no-underline justify-center hover:!bg-primary !transition-colors">
							<div class="w-5 h-5 flex items-center justify-center">
								<i class="ri-instagram-fill"></i>
							</div>
						</a> <a href="#"
							class="w-10 h-10 bg-gray-800 rounded-full flex items-center !text-white !no-underline justify-center hover:!bg-primary !transition-colors">
							<div class="w-5 h-5 flex items-center justify-center">
								<i class="ri-youtube-fill"></i>
							</div>
						</a> <a href="#"
							class="w-10 h-10 bg-gray-800 rounded-full flex items-center  !text-white !no-underline justify-center hover:!bg-primary !transition-colors">
							<div class="w-5 h-5 flex items-center justify-center">
								<i class="ri-twitter-fill"></i>
							</div>
						</a>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- 퀵 메뉴 -->
	<div class="fixed right-6 bottom-6 flex flex-col space-y-3 z-40 ">
		<button id="topBtn"
			class="w-12 h-12 bg-white rounded-full shadow-lg flex items-center justify-center hover:bg-gray-100 transition-colors">
			<div class="w-6 h-6 flex items-center justify-center">
				<i class="ri-arrow-up-line"></i>
			</div>
		</button>
		<!--    <button
        class="w-12 h-12 bg-primary text-white rounded-full shadow-lg flex items-center justify-center hover:bg-opacity-90 transition-colors"
      >
        <div class="w-6 h-6 flex items-center justify-center">
          <i class="ri-customer-service-2-line"></i>
        </div>
      </button> -->
	</div>
</body>
</html>