<%@page import="data.dao.UserDAO"%>
<%@page import="data.dto.UserDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="data.api.YouTube"%>
<%@page import="data.dto.MovieDTO"%>
<%@page import="data.dao.MovieDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>영화짱닷컴 - 영화 상세정보</title>
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
<%
YouTube fetcher = new YouTube();

String id = request.getParameter("id");
String name = request.getParameter("name");
String trailerName = fetcher.getTrailerVideoId(name);

String userid = (String) session.getAttribute("userid");
UserDAO userDao = UserDAO.getInstance();
String numId = userDao.getId(userid);


if (id == null || id.trim().isEmpty()) {
%>
<p>❌ 영화 ID가 지정되지 않았습니다.</p>
<%
return;
}

MovieDAO dao = MovieDAO.getInstance();
MovieDTO dto = dao.getMovieById(id);

if (dto == null) {
%>
<p>❌ 해당 ID에 해당하는 영화가 존재하지 않습니다.</p>
<%
return;
}
%>
<%
String posterUrl = "https://image.tmdb.org/t/p/w500";
/* MovieDAO dao = MovieDAO.getInstance(); */
/* String id = request.getParameter("id");
MovieDTO dto = dao.getMovieById(id); */
%>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
<style>
:where([class^="ri-"])::before {
	content: "\f3c2";
}

body {
	font-family: "Noto Sans KR", sans-serif;
}

.custom-switch {
	position: relative;
	display: inline-block;
	width: 44px;
	height: 24px;
}

.custom-switch input {
	opacity: 0;
	width: 0;
	height: 0;
}

.switch-slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #e5e7eb;
	transition: 0.4s;
	border-radius: 34px;
}

.switch-slider:before {
	position: absolute;
	content: "";
	height: 18px;
	width: 18px;
	left: 3px;
	bottom: 3px;
	background-color: white;
	transition: 0.4s;
	border-radius: 50%;
}

input:checked+.switch-slider {
	background-color: #352461;
}

input:checked+.switch-slider:before {
	transform: translateX(20px);
}

.tab-content {
	display: none;
}

.tab-content.active {
	display: block;
}

.review-stars i {
	cursor: pointer;
}

.review-stars i.active {
	color: #fbbf24;
}

.trailer-overlay {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, 0.8);
	display: flex;
	align-items: center;
	justify-content: center;
	z-index: 50;
	opacity: 0;
	visibility: hidden;
	transition: opacity 0.3s ease, visibility 0.3s ease;
}

.trailer-overlay.active {
	opacity: 1;
	visibility: visible;
}

.trailer-container {
	position: relative;
	width: 80%;
	max-width: 900px;
}

.trailer-close {
	position: absolute;
	top: -40px;
	right: 0;
	color: white;
	font-size: 24px;
	cursor: pointer;
}

.custom-radio {
	position: relative;
	display: inline-block;
	width: 20px;
	height: 20px;
	border: 2px solid #d1d5db;
	border-radius: 50%;
	cursor: pointer;
}

.custom-radio.checked {
	border-color: #352461;
}

.custom-radio.checked::after {
	content: "";
	position: absolute;
	left: 4px;
	top: 4px;
	width: 8px;
	height: 8px;
	background-color: #352461;
	border-radius: 50%;
}
</style>

</head>

<body class="bg-white pt-[72px]">
	<!-- 영화 상세 정보 섹션 -->
	<section class="py-8 bg-gray-50">
		<div class="container mx-auto px-4">
			<div class="bg-white rounded-lg shadow-md overflow-hidden">
				<!-- 영화 기본 정보 -->
				<div class="p-8 flex flex-col md:flex-row gap-8">
					<div class="w-full md:w-1/3 lg:w-1/4">
						<img
							src="<%=dto.getPoster_url().startsWith("https") ? "" : posterUrl%><%=dto.getPoster_url()%>"
							alt="" class="w-full rounded-lg shadow-lg" />
						<div class="mt-4 flex space-x-2">
							<button
								class="bg-primary text-white px-4 py-3 !rounded-button whitespace-nowrap flex-1 flex items-center justify-center hover:bg-opacity-90 transition-colors">
								<div class="w-5 h-5 flex items-center justify-center mr-2">
									<i class="ri-ticket-line"></i>
								</div>
								<span>예매하기</span>
							</button>

							<!-- 좋아요 버튼 -->
							<!-- <button
                  class="border border-gray-300 px-4 py-3 !rounded-button whitespace-nowrap flex items-center justify-center hover:bg-gray-50 transition-colors"
                >
                  <div class="w-5 h-5 flex items-center justify-center">
                    <i class="ri-heart-line text-red-500"></i>
                  </div>
                </button> -->

							<!-- 공유하기 버튼 -->
							<button onclick="copyCurrentUrl()"
								class="border border-gray-300 px-4 py-3 !rounded-button whitespace-nowrap flex items-center justify-center hover:bg-gray-50 transition-colors">
								<div class="w-5 h-5 flex items-center justify-center">
									<i class="ri-share-line"></i>
								</div>
							</button>
					
						</div>
					</div>

					<!-- 영화 정보 -->
					<div class="flex-1">
						<div class="flex items-center mb-2">
							<!-- 영화 상영 상태 -->
							<span
								class="bg-primary text-white text-xs px-2 py-1 rounded mr-2">현재상영중</span>

							<!-- 영화 등급 -->
							<span class="bg-gray-200 text-gray-700 text-xs px-2 py-1 rounded">
								<%=dto.getCertification()%></span>
						</div>

						<!-- 영화 제목 -->




						<!-- 영화 정보 -->
						<p class="text-gray-500 mb-6"><%=dto.getTitle()%></p>

						<!-- 영화 평점 -->
						<div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
							<div>
								<div class="flex items-center mb-4">
									<div
										class="w-6 h-6 flex items-center justify-center text-yellow-500 mr-2">
										<i class="ri-star-fill ri-lg"></i>
									</div>
									<div>
										<span class="text-2xl font-bold"><%=dto.getScore()%></span> <span
											class="text-gray-500 text-sm">/10</span>
									</div>
								</div>

								<div class="space-y-2">
									<div class="flex">
										<span class="text-gray-600 w-20">개봉</span> <span><%=dto.getRelease_date()%></span>
									</div>
									<div class="flex">
										<span class="text-gray-600 w-20">장르</span><%=dto.getGenre()%>
										 <%=userid %>
										<span></span>
									</div>
									<div class="flex"></div>
									<div class="flex">
										<span class="text-gray-600 w-20">러닝타임</span> <span><%=dto.getRuntime()%>분</span>
									</div>

								</div>
							</div>
							<div>
								<div class="flex items-center mb-4">
									<div
										class="w-6 h-6 flex items-center justify-center text-primary mr-2">
										<i class="ri-ticket-2-line ri-lg"></i>
									</div>
									<div>
										<span class="text-2xl font-bold">정보</span>
										<!-- 	<span
											class="text-gray-500 text-sm">정보</span> -->
									</div>
								</div>
								<div class="space-y-2">


									<div class="flex">
										<span class="text-gray-600 w-20">제작사</span><%=dto.getStudio()%>
										<span></span>
									</div>
									<div class="flex">
										<div class="flex">
											<span class="text-gray-600 w-20">배급사</span> <span><%=dto.getDistributor()%>
											</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="border-t border-gray-200 pt-6">
							<h3 class="font-bold mb-2">시놉시스</h3>
							<p class="text-gray-700 leading-relaxed"><%=dto.getSynopsis()%></p>
						</div>
					</div>
				</div>
				<!-- 트레일러 및 스틸컷 -->
				<div class="border-t border-gray-200">
					<div class="p-8">

						<h2 class="text-2xl font-bold mb-6"><%=name%>
							메인 트레일러
						</h2>
						<div class="grid grip-cols-3 gap-4">
							<!-- iframe -->
							<div
								class="relative aspect-video rounded overflow-hidden shadow-lg group">

								<iframe class="absolute inset-0 w-full h-full z-0"
									src="https://www.youtube.com/embed/<%=trailerName%>?autoplay=0&mute=0"
									frameborder="0" allowfullscreen></iframe>
							</div>


							<%-- 	<div
								class="relative aspect-video rounded overflow-hidden shadow-lg">
								<img src="https://img.youtube.com/vi/<%=trailerName%>/1.jpg"
									class="absolute inset-0 w-full h-full object-cover" />
							</div> --%>
						</div>


					</div>
				</div>
			</div>

		</div>

		<!-- 평점 및 관람평 -->
		<div class="border-t border-gray-200">
			<div class="p-8">
				<div class="flex justify-between items-center mb-6">
					<h2 class="text-2xl font-bold">평점 및 관람평</h2>
					<button
						class="bg-primary text-white px-4 py-2 !rounded-button whitespace-nowrap text-sm hover:bg-opacity-90 transition-colors"
						id="writeReviewBtn">관람평 작성</button>
				</div>
				<div class="bg-gray-50 p-6 rounded-lg mb-8">
					<div class="flex flex-col md:flex-row items-center justify-between">
						<div class="flex items-center mb-4 md:mb-0">
							<div
								class="w-16 h-16 bg-primary rounded-full flex items-center justify-center text-white text-3xl font-bold mr-4">
								9.2</div>
							<div>
								<div class="flex text-yellow-400 mb-1">
									<i class="ri-star-fill"></i> <i class="ri-star-fill"></i> <i
										class="ri-star-fill"></i> <i class="ri-star-fill"></i> <i
										class="ri-star-half-fill"></i>
								</div>
								<p class="text-sm text-gray-600">5,432명 참여</p>
							</div>
						</div>
						<div class="w-full md:w-1/2">
							<div class="flex items-center mb-2">
								<span class="text-sm w-12">5점</span>
								<div class="flex-1 bg-gray-200 h-2 rounded-full mx-2">
									<div class="bg-primary h-2 rounded-full" style="width: 75%"></div>
								</div>
								<span class="text-sm w-12 text-right">75%</span>
							</div>
							<div class="flex items-center mb-2">
								<span class="text-sm w-12">4점</span>
								<div class="flex-1 bg-gray-200 h-2 rounded-full mx-2">
									<div class="bg-primary h-2 rounded-full" style="width: 18%"></div>
								</div>
								<span class="text-sm w-12 text-right">18%</span>
							</div>
							<div class="flex items-center mb-2">
								<span class="text-sm w-12">3점</span>
								<div class="flex-1 bg-gray-200 h-2 rounded-full mx-2">
									<div class="bg-primary h-2 rounded-full" style="width: 5%"></div>
								</div>
								<span class="text-sm w-12 text-right">5%</span>
							</div>
							<div class="flex items-center mb-2">
								<span class="text-sm w-12">2점</span>
								<div class="flex-1 bg-gray-200 h-2 rounded-full mx-2">
									<div class="bg-primary h-2 rounded-full" style="width: 1%"></div>
								</div>
								<span class="text-sm w-12 text-right">1%</span>
							</div>
							<div class="flex items-center">
								<span class="text-sm w-12">1점</span>
								<div class="flex-1 bg-gray-200 h-2 rounded-full mx-2">
									<div class="bg-primary h-2 rounded-full" style="width: 1%"></div>
								</div>
								<span class="text-sm w-12 text-right">1%</span>
							</div>
						</div>
					</div>
				</div>
				<!-- 관람평 탭 -->
				<div class="border-b border-gray-300 mb-6">
					<div class="flex space-x-8">
						<button
							class="review-tab-btn active py-3 px-2 font-medium text-primary border-b-2 border-primary"
							data-tab="all">전체</button>
					</div>
				</div>
				<!-- 관람평 목록 -->
				<div id="all" class="review-tab-content active">
					<div class="space-y-6">
						<!-- 관람평 1 -->
						<div class="border-b border-gray-200 pb-6">
							<div class="flex justify-between items-start mb-2">
								<div class="flex items-center">
									<div
										class="w-10 h-10 bg-gray-200 rounded-full flex items-center justify-center mr-3">
										<div
											class="w-5 h-5 flex items-center justify-center text-gray-500">
											<i class="ri-user-line"></i>
										</div>
									</div>
									<div>
										<p class="font-medium">김현우</p>
										<div class="flex items-center text-sm text-gray-500">
											<div class="flex text-yellow-400 mr-2">
												<i class="ri-star-fill"></i> <i class="ri-star-fill"></i> <i
													class="ri-star-fill"></i> <i class="ri-star-fill"></i> <i
													class="ri-star-fill"></i>
											</div>
											<span>2025.05.29</span>
										</div>
									</div>
								</div>
								<div class="flex space-x-2">
									<button
										class="flex items-center text-gray-500 hover:text-primary">
										<div class="w-5 h-5 flex items-center justify-center mr-1">
											<i class="ri-thumb-up-line"></i>
										</div>
										<span>128</span>
									</button>
									<button
										class="flex items-center text-gray-500 hover:text-primary">
										<div class="w-5 h-5 flex items-center justify-center mr-1">
											<i class="ri-thumb-down-line"></i>
										</div>
										<span>12</span>
									</button>
								</div>
							</div>
							<p class="text-gray-700">마동석의 액션은 언제 봐도 시원하다! 범죄도시 시리즈 중에서도
								이번 편이 가장 스케일이 크고 액션 장면도 더 업그레이드된 느낌. 특히 베트남 현지 촬영 장면들이 영화의 분위기를
								한층 더 살려줬다. 마석도와 장이수 콤비의 케미도 여전히 최고!</p>
						</div>


						<!-- 페이지네이션 -->
						<div class="flex justify-center mt-8">
							<div class="inline-flex items-center">
								<a href="#"
									class="w-10 h-10 flex items-center justify-center border border-gray-300 rounded-l-md hover:bg-gray-50">
									<div class="w-5 h-5 flex items-center justify-center">
										<i class="ri-arrow-left-s-line"></i>
									</div>
								</a> <a href="#"
									class="w-10 h-10 flex items-center justify-center border-t border-b border-gray-300 bg-primary text-white">1</a>
								<a href="#"
									class="w-10 h-10 flex items-center justify-center border-t border-b border-gray-300 hover:bg-gray-50">2</a>
								<a href="#"
									class="w-10 h-10 flex items-center justify-center border-t border-b border-gray-300 hover:bg-gray-50">3</a>
								<a href="#"
									class="w-10 h-10 flex items-center justify-center border border-gray-300 rounded-r-md hover:bg-gray-50">
									<div class="w-5 h-5 flex items-center justify-center">
										<i class="ri-arrow-right-s-line"></i>
									</div>
								</a>
							</div>
						</div>
					</div>
					
						
						</div>
					</div>
				</div>
			


			<!-- 여기서부터 영화 추천기능입니다 ~~~~~~ 장르에따라서 같은장르 평점높은순으로 평점 5점이상 영화들만 추천합니다.-->
			<%
			List<MovieDTO> recommends = dao.getRecommends(request.getParameter("id"));
			if (recommends != null && !recommends.isEmpty()) {
			%>
			<div class="border-t border-gray-200">

				<div class="p-8">


					<h2 class="text-2xl font-bold mb-6">이런 영화를 좋아하실것 같아요 !</h2>


					<div
						class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-6">
						<!-- 추천 영화  -->
						<%
						for (MovieDTO rec : recommends) {
							String encodedTitle = URLEncoder.encode(rec.getTitle(), "UTF-8");
						%>
						<div>
							<div class="relative">
								<%=rec.getId()%>
								<img
									onclick="location.href='?main=movie/movieDetail.jsp?id=<%=rec.getId()%>&name=<%=rec.getTitle()%>'"
									src="<%=rec.getPoster_url().startsWith("https") ? "" : posterUrl%><%=rec.getPoster_url()%>"
									alt="<%=rec.getTitle()%>"
									class="w-full h-60 object-cover object-top rounded" />
							</div>
							<div class="mt-2">
								<p class="font-medium"><%=rec.getTitle()%></p>
								<div class="flex items-center text-sm text-gray-600">
									<div class="flex items-center">
										<span><%=rec.getGenre()%></span>
										<div
											class="w-4 h-4 flex items-center justify-center text-yellow-500 mr-1">
											<i class="ri-star-fill"></i>
										</div>
										<span><%=rec.getScore()%></span>

									</div>

								</div>
							</div>
						</div>
						<%
						}
						%>
					</div>


				</div>

			</div>
			<%
			} else {
			%>
			<p>같은 장르의 추천 영화가 없습니다 😢</p>
			<%
			}
			%>
			<!-- 	영화추천 끝~~~~ -->
		</div>
		</div>
	</section>

	<!-- 트레일러 오버레이 -->
	<div class="trailer-overlay" id="trailerOverlay">
		<div class="trailer-container">
			<div class="trailer-close" id="trailerClose">
				<div class="w-8 h-8 flex items-center justify-center">
					<i class="ri-close-line ri-2x"></i>
				</div>
			</div>
			<div class="aspect-w-16 aspect-h-9">
				<iframe width="100%" height="100%" src="about:blank" frameborder="0"
					allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
					allowfullscreen></iframe>
			</div>
		</div>
	</div>
	<!-- 관람평 작성 모달 -->
	<div
	class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden"
	id="reviewModal">
	<div class="bg-white rounded-lg w-full max-w-lg p-6">
		<form action="insertReview.jsp" method="post" id="reviewForm">
			<div class="flex justify-between items-center mb-4">
				<!-- <h3 class="text-xl font-bold">관람평 작성</h3> -->
				<button id="closeReviewModal"
					class="text-gray-500 hover:text-gray-700" type="button">
					<div class="w-6 h-6 flex items-center justify-center">
						<i class="ri-close-line"></i>
					</div>
				</button>
			</div>

			<div class="mb-4">
				<p class="font-medium mb-2">영화 평점</p>
				<div class="flex review-stars text-2xl text-gray-300 mb-2">
					<i class="ri-star-fill" data-value="1"></i>
					<i class="ri-star-fill" data-value="2"></i>
					<i class="ri-star-fill" data-value="3"></i>
					<i class="ri-star-fill" data-value="4"></i>
					<i class="ri-star-fill" data-value="5"></i>
				
					
				</div>

				<%= userid %> <%= numId %>

				<p class="text-sm text-gray-500" id="ratingText">평점을 선택해주세요</p>

				<!-- 추가: 별점 값 -->
			<input type="hidden" id="rating" name="rating" />
		  <p id="selectedRatingText" class="text-sm text-blue-600 font-semibold mt-2"></p>
			</div>

			<div class="mb-4">
				<p class="font-medium mb-2">관람평</p>
				<textarea name="content" required minlength="10"
					class="w-full border border-gray-300 rounded p-3 h-32 focus:outline-none focus:ring-2 focus:ring-primary"
					placeholder="영화에 대한 감상을 자유롭게 작성해주세요. (최소 10자 이상)"></textarea>
			</div>

			<!-- 추가: 유저 ID, 영화 ID 전달 -->
			<input type="hidden" name="user_id" value="<%= numId %>">
			<input type="hidden" name="movie_id" value="<%= request.getParameter("id") %>">

			<div class="flex space-x-3">
			<p id="selectedRatingText" class="text-sm text-blue-600 font-semibold mt-2"></p>
				<button
					class="border border-gray-300 px-4 py-2 !rounded-button whitespace-nowrap flex-1 hover:bg-gray-50 transition-colors"
					id="cancelReview" type="button">취소</button>
				<button
					class="bg-primary text-white px-4 py-2 !rounded-button whitespace-nowrap flex-1 hover:bg-opacity-90 transition-colors"
					type="submit">등록</button>
			</div>
		</form>
	</div>
</div>


	<script>
      document.addEventListener("DOMContentLoaded", function () {
        const header = document.querySelector("header");
        let lastScrollY = window.scrollY;
        window.addEventListener("scroll", () => {
          if (window.scrollY > lastScrollY) {
            header.style.transform = "translateY(-100%)";
            header.style.transition = "transform 0.3s ease-in-out";
          } else {
            header.style.transform = "translateY(0)";
            header.style.transition = "transform 0.3s ease-in-out";
          }
          lastScrollY = window.scrollY;
        });
        // 관람평 탭 전환 기능
        const reviewTabBtns = document.querySelectorAll(".review-tab-btn");
        const reviewTabContents = document.querySelectorAll(
          ".review-tab-content"
        );
        reviewTabBtns.forEach((btn) => {
          btn.addEventListener("click", function () {
            // 모든 탭 버튼에서 active 클래스 제거
            reviewTabBtns.forEach((b) => {
              b.classList.remove(
                "active",
                "text-primary",
                "border-b-2",
                "border-primary"
              );
              b.classList.add("text-gray-500");
            });
            // 클릭한 탭 버튼에 active 클래스 추가
            this.classList.add(
              "active",
              "text-primary",
              "border-b-2",
              "border-primary"
            );
            this.classList.remove("text-gray-500");
            // 모든 탭 콘텐츠 숨기기
            reviewTabContents.forEach((content) => {
              content.classList.remove("active");
              content.classList.add("hidden");
            });
            // 해당 탭 콘텐츠 표시
            const tabId = this.getAttribute("data-tab");
            const activeContent = document.getElementById(tabId);
            activeContent.classList.add("active");
            activeContent.classList.remove("hidden");
          });
        });
        // 트레일러 모달 기능
        const trailerTriggers = document.querySelectorAll(".trailer-trigger");
        const trailerOverlay = document.getElementById("trailerOverlay");
        const trailerClose = document.getElementById("trailerClose");
        const trailerIframe = trailerOverlay.querySelector("iframe");
        trailerTriggers.forEach((trigger) => {
          trigger.addEventListener("click", function () {
            // 실제 구현에서는 영화별 트레일러 URL을 설정해야 함
            trailerIframe.src =
              "https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=1";
            trailerOverlay.classList.add("active");
            document.body.style.overflow = "hidden";
          });
        });
        trailerClose.addEventListener("click", function () {
          trailerOverlay.classList.remove("active");
          trailerIframe.src = "about:blank";
          document.body.style.overflow = "";
        });
        // 관람평 작성 모달
        const writeReviewBtn = document.getElementById("writeReviewBtn");
        const reviewModal = document.getElementById("reviewModal");
        const closeReviewModal = document.getElementById("closeReviewModal");
        const cancelReview = document.getElementById("cancelReview");
        writeReviewBtn.addEventListener("click", function () {
          reviewModal.classList.remove("hidden");
          document.body.style.overflow = "hidden";
        });
        function closeModal() {
          reviewModal.classList.add("hidden");
          document.body.style.overflow = "";
        }
        closeReviewModal.addEventListener("click", closeModal);
        cancelReview.addEventListener("click", closeModal);
        // 별점 기능
        const stars = document.querySelectorAll(".review-stars i");
        const ratingText = document.getElementById("ratingText");
        const ratingTexts = [
          "평점을 선택해주세요",
          "별로예요",
          "기대보다 낮아요",
          "보통이에요",
          "기대보다 높아요",
          "최고예요!",
        ];
        stars.forEach((star) => {
          star.addEventListener("mouseover", function () {
            const value = this.getAttribute("data-value");
            highlightStars(value);
          });
          star.addEventListener("mouseout", function () {
            const activeStars = document.querySelectorAll(
              ".review-stars i.active"
            );
            if (activeStars.length === 0) {
              stars.forEach((s) => s.classList.remove("text-yellow-400"));
              stars.forEach((s) => s.classList.add("text-gray-300"));
              ratingText.textContent = ratingTexts[0];
            } else {
              const value =
                activeStars[activeStars.length - 1].getAttribute("data-value");
              highlightStars(value);
            }
          });
          stars.forEach((star) => {
        	  star.addEventListener("click", function () {
        	    const value = parseInt(this.getAttribute("data-value")); // 문자열 → 숫자
        	    const ratingValue = value * 2;

        	    // 별 채우기
        	    stars.forEach((s, i) => {
        	      s.classList.toggle("active", i < value);
        	    });
        	    highlightStars(value);

        	    // 실제 hidden input에 값 설정
        	    const ratingInput = document.getElementById("rating");
        	    if (ratingInput) {
        	      ratingInput.value = ratingValue;
        	      console.log("rating 설정됨:", ratingInput.value);
     /*    	      console.log("ratingDisplay 확인:", ratingDisplay);// 디버그 */
        	    } else {
        	      console.warn("rating input 못 찾음");
        	    }

        	    // 사용자에게 평점 표시
        	    const ratingDisplay = document.getElementById("selectedRatingText");
        	    if (ratingDisplay) {
        	    	ratingDisplay.textContent = `선택한 평점: ${ratingValue} 점`;
        	    }
        	  });
        	});
        });
        function highlightStars(count) {
          stars.forEach((s) => s.classList.remove("text-yellow-400"));
          stars.forEach((s) => s.classList.add("text-gray-300"));
          for (let i = 0; i < count; i++) {
            stars[i].classList.remove("text-gray-300");
            stars[i].classList.add("text-yellow-400");
          }
          ratingText.textContent = ratingTexts[count];
        }
        
      /*   공유 링크복사기 */

       
        });
	
		function copyCurrentUrl() {
		    const url = window.location.href;
		    navigator.clipboard.writeText(url)
		        .then(() => {
		            alert("<%=dto.getTitle()%> 링크가 복사되었습니다!");
		        })
		        .catch((err) => {
		            console.error("복사 실패: ", err);
		            alert("링크 복사에 실패했습니다.");
		        });
		}
	
    </script>
</body>
</html>
