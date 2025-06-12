<%@page import="mysql.db.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="data.api.YouTube"%>
<%@ page import="data.dao.MovieDAO, data.dto.MovieDTO"%>
<%
YouTube fetcher = new YouTube();
String trailerId = fetcher.getTrailerVideoId("진격의거인 파이널4");

MovieDAO dao = MovieDAO.getInstance();


%>
<!DOCTYPE html>

<html lang="ko">
<head>

<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/domainIcon.png">
<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/domainIcon.png">
<title>영화짱닷컴</title>
<script src="https://cdn.tailwindcss.com/3.4.16"></script>

<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" />

<style>
:where([class^="ri-"])::before {
	content: "\f3c2";
}

body {
	font-family: "Noto Sans KR", sans-serif;
}

.poster:hover .hover-info {
	opacity: 1;
}

.poster .hover-info {
	opacity: 0;
	transition: opacity 0.3s ease;
}

.dot {
	width: 12px;
	height: 12px;
	border-radius: 50%;
	background-color: rgba(255, 255, 255, 0.5);
	cursor: pointer;
	transition: all 0.3s ease;
}

.dot.active {
	background-color: #fff;
	transform: scale(1.2);
}

.dot:hover {
	background-color: rgba(255, 255, 255, 0.8);
}

.quick-menu {
	position: fixed;
	right: 20px;
	bottom: 20px;
	z-index: 100;
}

.hall-slider {
	scroll-behavior: smooth;
	scroll-snap-type: x mandatory;
}

.hall-item {
	flex: 0 0 100%;
	scroll-snap-align: start;
}
</style>
</head>

<body class="bg-white">


	<!-- 메인 비주얼 영역 -->

	<jsp:include page="../component/movieContent/movieTrailer.jsp"></jsp:include>
	<!-- 박스오피스 섹션 -->
	<section class="py-16 bg-gray-50">
		<div class="container mx-auto px-4">
			<div class="flex justify-between items-center mb-8">
				<h2 class="text-2xl font-bold">박스오피스</h2>
				<a href="?main=movie/movieList.jsp"
					class="flex items-center text-gray-600 hover:text-primary transition-colors">
					<!-- 영화정보로이동 --> <span>더보기</span>
					<div class="w-5 h-5 flex items-center justify-center ml-1">
						<i class="ri-arrow-right-s-line"></i>
					</div>
				</a>
			</div>
			<div class="flex overflow-x-auto space-x-6 pb-4 -mx-4 px-4">
				<!-- 영화 포스터 1 -->
				<%
				for (int i = 1; i <= 5; i++) {
				 	String id = String.valueOf(i);
					String name = String.valueOf(i);
					MovieDTO dto = dao.getMovieById(id);
					String posterUrl = "https://image.tmdb.org/t/p/w500";
					System.out.print("");
					if (dto != null) {
				%>
				<div class="poster relative flex-shrink-0 w-64">
					<div class="relative">

						<img
							src="<%=dto.getPoster_url().startsWith("https") ? "" : posterUrl%><%=dto.getPoster_url()%>"
							alt="<%=dto.getTitle()%>"
							class="w-64 h-96 object-cover rounded" />
						<div
							class="hover-info absolute inset-0 bg-black bg-opacity-70 rounded flex flex-col justify-center items-center p-4">
							<div class="text-white text-center mb-4">
								<p class="font-bold mb-2">
									<%=dto.getTitle()%>
								</p>
								<p class="text-sm mb-1">
									평점<i class="ri-star-fill"></i>
									<%=dto.getScore()%></p>
								<p class="text-sm">
									개봉일&nbsp;<%=dto.getRelease_date()%></p>
							</div>
							<button
								class="bg-primary text-white px-4 py-2 !rounded-button whitespace-nowrap w-full mb-2"
								onclick="location.href='<%=request.getContextPath()%>/index.jsp?main=book/booking/bookMain.jsp?movie_id=<%=dto.getId() %>'"
								>
							예매하기</button>
							<button onclick="location.href='?main=movie/movieDetail.jsp?id=<%=id%>&name=<%=dto.getTitle()%>'"
								class="border border-white text-white px-4 py-2 !rounded-button whitespace-nowrap w-full">
								상세정보</button>
						</div>
					</div>


					<div class="mt-3">
						<p class="font-bold">
							<%=dto.getTitle()%></p>
						<div class="flex items-center text-sm text-gray-600 mt-1">
							<span> 평점<i class="ri-star-fill"></i> <%=dto.getScore()%>
							</span> <span class="mx-2">|</span> <span>개봉일&nbsp;<%=dto.getRelease_date()%>
							</span>
						</div>
					</div>
				</div>
				<%
				} else {
				%>
				<p>
					ID
					<%=i%>에 해당하는 영화가 없습니다.
				</p>
				<%
				}
				}
				%>
				<%-- <%
				for (int i = 1; i <= 5; i++) {
					String id = String.valueOf(i);
					MovieDTO dto = dao.getMovieById(id);

					if (dto != null) {
				%>
				<div class="movie-box">
					<h2><%=dto.getTitle()%></h2>
					<p>
						개봉일:
						<%=dto.getRelease_date()%></p>
					<p>
						평점:
						<%=dto.getScore()%></p>
					<img src="<%=dto.getPoster_url()%>" width="150" alt="포스터">
				</div>
				<%
				} else {
				%>
				<p>
					ID
					<%=i%>에 해당하는 영화가 없습니다.
				</p>
				<%
				}
				}
				%> --%>
			</div>
		</div>
	</section>
	<!-- 이벤트 섹션 -->
	<section class="py-16">
		<div class="container mx-auto px-4">
			<div class="flex justify-between items-center mb-8">
				<h2 class="text-2xl font-bold">이벤트</h2>
				<a href="#"
					class="flex items-center text-gray-600 hover:text-primary transition-colors">
					<span>더보기</span>
					<div class="w-5 h-5 flex items-center justify-center ml-1">
						<i class="ri-arrow-right-s-line"></i>
					</div>
				</a>
			</div>
			<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
				<!-- 이벤트 1 -->
				<div
					class="overflow-hidden rounded shadow-md hover:shadow-lg transition-shadow">
					<img
						src="https://readdy.ai/api/search-image?query=Movie%20theater%20promotional%20event%20with%20popcorn%20and%20tickets%2C%20vibrant%20colors%2C%20professional%20marketing%20image%2C%20high%20quality%2C%20promotional%20design&width=400&height=250&seq=7&orientation=landscape"
						alt="영화 티켓 할인 이벤트" class="w-full h-48 object-cover" />
					<div class="p-4">
						<h3 class="font-bold text-lg mb-2">영화 티켓 할인 이벤트</h3>
						<p class="text-gray-600 text-sm">2025.05.21 ~ 2025.06.30</p>
					</div>
				</div>
				<!-- 이벤트 2 -->
				<div
					class="overflow-hidden rounded shadow-md hover:shadow-lg transition-shadow">
					<img
						src="https://readdy.ai/api/search-image?query=Movie%20premiere%20event%20with%20red%20carpet%20and%20celebrities%2C%20elegant%20atmosphere%2C%20professional%20event%20photography%2C%20high%20quality%2C%20glamorous%20setting&width=400&height=250&seq=8&orientation=landscape"
						alt="범죄도시 4 시사회" class="w-full h-48 object-cover" />
					<div class="p-4">
						<h3 class="font-bold text-lg mb-2">범죄도시 4 VIP 시사회</h3>
						<p class="text-gray-600 text-sm">2025.05.27</p>
					</div>
				</div>
				<!-- 이벤트 3 -->
				<div
					class="overflow-hidden rounded shadow-md hover:shadow-lg transition-shadow">
					<img
						src="https://readdy.ai/api/search-image?query=Movie%20merchandise%20collection%20with%20figurines%20and%20collectibles%2C%20colorful%20display%2C%20professional%20product%20photography%2C%20high%20quality%2C%20retail%20promotion&width=400&height=250&seq=9&orientation=landscape"
						alt="영화 굿즈 이벤트" class="w-full h-48 object-cover" />
					<div class="p-4">
						<h3 class="font-bold text-lg mb-2">여름 영화 굿즈 특별전</h3>
						<p class="text-gray-600 text-sm">2025.06.01 ~ 2025.06.30</p>
					</div>
				</div>
				<!-- 이벤트 4 -->
				<div
					class="overflow-hidden rounded shadow-md hover:shadow-lg transition-shadow">
					<img
						src="https://readdy.ai/api/search-image?query=Movie%20theater%20membership%20card%20with%20benefits%20display%2C%20modern%20design%2C%20professional%20marketing%20image%2C%20high%20quality%2C%20loyalty%20program&width=400&height=250&seq=10&orientation=landscape"
						alt="멤버십 혜택" class="w-full h-48 object-cover" />
					<div class="p-4">
						<h3 class="font-bold text-lg mb-2">메가박스 멤버십 더블 포인트</h3>
						<p class="text-gray-600 text-sm">2025.05.21 ~ 2025.05.31</p>
					</div>
				</div>
				<!-- 이벤트 5 -->
				<div
					class="overflow-hidden rounded shadow-md hover:shadow-lg transition-shadow">
					<img
						src="https://readdy.ai/api/search-image?query=Movie%20theater%20snack%20combo%20with%20popcorn%20and%20drinks%2C%20appetizing%20display%2C%20professional%20food%20photography%2C%20high%20quality%2C%20concession%20promotion&width=400&height=250&seq=11&orientation=landscape"
						alt="스낵 콤보 할인" class="w-full h-48 object-cover" />
					<div class="p-4">
						<h3 class="font-bold text-lg mb-2">스낵 콤보 20% 할인</h3>
						<p class="text-gray-600 text-sm">2025.05.25 ~ 2025.06.10</p>
					</div>
				</div>
				<!-- 이벤트 6 -->
				<div
					class="overflow-hidden rounded shadow-md hover:shadow-lg transition-shadow">
					<img
						src="https://readdy.ai/api/search-image?query=Family%20movie%20day%20promotion%20with%20parents%20and%20children%2C%20friendly%20atmosphere%2C%20professional%20marketing%20image%2C%20high%20quality%2C%20family%20entertainment&width=400&height=250&seq=12&orientation=landscape"
						alt="가족 영화데이" class="w-full h-48 object-cover" />
					<div class="p-4">
						<h3 class="font-bold text-lg mb-2">가족 영화데이 특별 할인</h3>
						<p class="text-gray-600 text-sm">매주 수요일</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 특별관 섹션 -->
	<section class="py-16 bg-gray-50">
		<div class="container mx-auto px-4">
			<div class="flex justify-between items-center mb-8">
				<h2 class="text-2xl font-bold">특별관 (준비예정)</h2>
				<div class="flex space-x-2">
					<button id="prevSpecialHall"
						class="w-10 h-10 bg-white rounded-full shadow flex items-center justify-center hover:bg-gray-100 transition-colors">
						<div class="w-5 h-5 flex items-center justify-center">
							<i class="ri-arrow-left-s-line"></i>
						</div>
					</button>
					<button id="nextSpecialHall"
						class="w-10 h-10 bg-white rounded-full shadow flex items-center justify-center hover:bg-gray-100 transition-colors">
						<div class="w-5 h-5 flex items-center justify-center">
							<i class="ri-arrow-right-s-line"></i>
						</div>
					</button>
				</div>
			</div>
			<div class="relative overflow-hidden">
				<div id="hallSlider"
					class="hall-slider flex overflow-x-auto scrollbar-hide">
					<!-- MX 특별관 -->
					<div class="hall-item w-full">
						<div
							class="flex flex-col md:flex-row bg-white rounded-lg shadow-lg overflow-hidden">
							<div class="md:w-1/2">
								<img
									src="https://readdy.ai/api/search-image?query=Luxury%20movie%20theater%20with%20premium%20large%20format%20screen%2C%20plush%20reclining%20seats%2C%20state-of-the-art%20projection%2C%20high%20quality%20interior%20design%2C%20cinematic%20atmosphere%2C%20premium%20theater%20experience&width=600&height=400&seq=13&orientation=landscape"
									alt="MX 특별관" class="w-full h-full object-cover" />
							</div>
							<div class="md:w-1/2 p-8 flex flex-col justify-center">
								<h3 class="text-3xl font-bold mb-4 text-primary">MX</h3>
								<p class="text-gray-700 mb-6">진정한 영화 감상을 위한 최고의 프리미엄 상영관.
									압도적인 대형 스크린과 최첨단 사운드 시스템으로 영화의 감동을 극대화합니다.</p>
								<ul class="mb-6 space-y-2">
									<li class="flex items-center">
										<div
											class="w-5 h-5 flex items-center justify-center mr-2 text-primary">
											<i class="ri-check-line"></i>
										</div> <span>초대형 스크린 (최대 22미터)</span>
									</li>
									<li class="flex items-center">
										<div
											class="w-5 h-5 flex items-center justify-center mr-2 text-primary">
											<i class="ri-check-line"></i>
										</div> <span>돌비 애트모스 서라운드 사운드</span>
									</li>
									<li class="flex items-center">
										<div
											class="w-5 h-5 flex items-center justify-center mr-2 text-primary">
											<i class="ri-check-line"></i>
										</div> <span>4K 레이저 프로젝션</span>
									</li>
								</ul>
								<button
									class="bg-primary text-white px-6 py-3 !rounded-button whitespace-nowrap self-start hover:bg-opacity-90 transition-colors">
									상세보기</button>
							</div>
						</div>
					</div>
					<!-- 부티크 특별관 -->
					<div class="hall-item w-full">
						<div
							class="flex flex-col md:flex-row bg-white rounded-lg shadow-lg overflow-hidden">
							<div class="md:w-1/2">
								<img
									src="https://readdy.ai/api/search-image?query=Boutique%20cinema%20with%20intimate%20setting%2C%20luxury%20seating%2C%20elegant%20decor%2C%20high%20quality%20interior%20design%2C%20exclusive%20theater%20experience%2C%20premium%20small%20theater&width=600&height=400&seq=14&orientation=landscape"
									alt="부티크 특별관" class="w-full h-full object-cover" />
							</div>
							<div class="md:w-1/2 p-8 flex flex-col justify-center">
								<h3 class="text-3xl font-bold mb-4 text-primary">부티크</h3>
								<p class="text-gray-700 mb-6">소수의 관객을 위한 프라이빗한 영화 감상 공간.
									고급스러운 인테리어와 편안한 좌석으로 특별한 영화 경험을 선사합니다.</p>
								<ul class="mb-6 space-y-2">
									<li class="flex items-center">
										<div
											class="w-5 h-5 flex items-center justify-center mr-2 text-primary">
											<i class="ri-check-line"></i>
										</div> <span>40석 미만의 소규모 상영관</span>
									</li>
									<li class="flex items-center">
										<div
											class="w-5 h-5 flex items-center justify-center mr-2 text-primary">
											<i class="ri-check-line"></i>
										</div> <span>프리미엄 가죽 리클라이너 좌석</span>
									</li>
									<li class="flex items-center">
										<div
											class="w-5 h-5 flex items-center justify-center mr-2 text-primary">
											<i class="ri-check-line"></i>
										</div> <span>개인 테이블 서비스</span>
									</li>
								</ul>
								<button
									class="bg-primary text-white px-6 py-3 !rounded-button whitespace-nowrap self-start hover:bg-opacity-90 transition-colors">
									상세보기</button>
							</div>
						</div>
					</div>
					<!-- 돌비 특별관 -->
					<div class="hall-item w-full">
						<div
							class="flex flex-col md:flex-row bg-white rounded-lg shadow-lg overflow-hidden">
							<div class="md:w-1/2">
								<img
									src="https://readdy.ai/api/search-image?query=Dolby%20cinema%20with%20advanced%20sound%20system%2C%20premium%20theater%20with%20acoustic%20design%2C%20high%20quality%20audio%20visual%20experience%2C%20state-of-the-art%20theater%20technology&width=600&height=400&seq=15&orientation=landscape"
									alt="돌비 특별관" class="w-full h-full object-cover" />
							</div>
							<div class="md:w-1/2 p-8 flex flex-col justify-center">
								<h3 class="text-3xl font-bold mb-4 text-primary">돌비 시네마</h3>
								<p class="text-gray-700 mb-6">돌비 애트모스와 돌비 비전이 결합된 최고의 영화 경험.
									영화 속 모든 소리와 영상을 그대로 느낄 수 있는 몰입감을 제공합니다.</p>
								<ul class="mb-6 space-y-2">
									<li class="flex items-center">
										<div
											class="w-5 h-5 flex items-center justify-center mr-2 text-primary">
											<i class="ri-check-line"></i>
										</div> <span>64채널 돌비 애트모스 사운드</span>
									</li>
									<li class="flex items-center">
										<div
											class="w-5 h-5 flex items-center justify-center mr-2 text-primary">
											<i class="ri-check-line"></i>
										</div> <span>돌비 비전 HDR 영상 기술</span>
									</li>
									<li class="flex items-center">
										<div
											class="w-5 h-5 flex items-center justify-center mr-2 text-primary">
											<i class="ri-check-line"></i>
										</div> <span>특수 설계된 음향 시스템</span>
									</li>
								</ul>
								<button
									class="bg-primary text-white px-6 py-3 !rounded-button whitespace-nowrap self-start hover:bg-opacity-90 transition-colors">
									상세보기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script>

      document.addEventListener("DOMContentLoaded", function () {
        // 특별관 슬라이더
        const slider = document.getElementById("hallSlider");
        const prev = document.getElementById("prevSpecialHall");
        const next = document.getElementById("nextSpecialHall");
        const slides = document.querySelectorAll(".hall-item");
        let idx = 0;
        let timer;

        function moveTo(index) {
          if (index < 0) {
            index = slides.length - 1;
          } else if (index >= slides.length) {
            index = 0;
          }
          idx = index;
          slider.scrollTo({
            left: slides[idx].offsetLeft,
            behavior: "smooth",
          });
        }

        function startTimer() {
          timer = setInterval(() => {
            moveTo(idx + 1);
          }, 5000);
        }
        function stopTimer() {
          if (timer) {
            clearInterval(timer);
          }
        }
        function resetTimer() {
          stopTimer();
          startTimer();
        }
        prev.addEventListener("click", () => {
          moveTo(idx - 1);
          resetTimer();
        });
        next.addEventListener("click", () => {
          moveTo(idx + 1);
          resetTimer();
        });
        slider.addEventListener("mouseenter", stopTimer);
        slider.addEventListener("mouseleave", startTimer);
        startTimer();
      });

    </script>
</body>
</html>
