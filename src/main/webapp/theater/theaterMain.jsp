<%@page import="java.net.URLEncoder"%>
<%@page import="data.dto.TheaterDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.TheaterDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>theaterMain</title>
<link href="https://fonts.googleapis.com/css2?family=42dot+Sans:wght@300..800&family=Black+Han+Sans&family=Dongle&family=Jua&family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
	.theater-tab-box {
	    border: 2px solid #888;
	    border-radius: 12px;
	    padding: 0;
	    margin-top: 24px;
	    box-shadow: 0 2px 8px rgba(0,0,0,0.03);
	}
	.nav-tabs .nav-link.active {
	    background-color: #666;
	    color: #fff !important;
	    border-radius: 8px 8px 0 0;
	}
	.nav-tabs .nav-link {
	    color: #333;
	    font-weight: 500;
	    border: none;
	}
	.tab-content {
	    padding: 28px 24px 16px 24px;
	    min-height: 170px;
	}
	.theater-list {
	    columns: 3;
	    column-gap: 48px;
	    padding: 0;
	}
	.theater-list li {
	    list-style: none;
	    padding: 4px 0;
	    font-size: 1.08rem;
	    cursor: pointer;
	    transition: color 0.1s;
	}
	.theater-list li:hover {
	    color: #1976d2;
	    text-decoration: underline;
	}
	@media (max-width: 800px) {
	    .theater-list { columns: 2; }
	}
	@media (max-width: 480px) {
	    .theater-list { columns: 1; }
	}
</style>
</head>
<%
	TheaterDAO dao = TheaterDAO.getInstance();
	List<String> regionList = dao.getRegions();
	Map<String, List<TheaterDTO>> theaterMap = dao.getTheaterMapByRegion();
	
	int tabIdx = 0;
	int panelIdx = 0;
%>
<body>
	<div class="container" style="max-width:900px;">
	    <h2 class="mt-5 mb-3">전체극장</h2>
	    <div class="theater-tab-box">
	        <!-- 지역별 탭 -->
	        <ul class="nav nav-tabs w-100" id="theaterTab" role="tablist">
	        <%
	        	for(String regions : theaterMap.keySet())
	        	{
	        %>
	       	 	<li class="nav-item" role="presentation">
			        <button class="nav-link<%= (tabIdx == 0) ? " active" : "" %>" 
			                id="tab-<%= tabIdx %>" 
			                data-bs-toggle="tab" 
			                data-bs-target="#panel-<%= tabIdx %>" 
			                type="button" 
			                role="tab">
			            <%= regions %>
			        </button>
			    </li>
	        <%
	        		tabIdx++;
	        	}
	        %>
	           
	        </ul>
	        <!-- 극장 리스트 패널 -->
	        <div class="tab-content" id="theaterTabContent">
	            <%
					for (Map.Entry<String, List<TheaterDTO>> entry : theaterMap.entrySet()) 
					{
					    String region = entry.getKey();
					    List<TheaterDTO> theaterList = entry.getValue();
				%>
					<div class="tab-pane fade<%= (panelIdx == 0) ? " show active" : "" %>" 
				         id="panel-<%= panelIdx %>" 
				         role="tabpanel">
				        <ul class="theater-list">
				        <%
				            for (TheaterDTO theater : theaterList) 
				            {
				        %>
				            <li class="theater-item" data-region="<%=region%>" data-name="<%=theater.getName()%>" data-address="<%=theater.getAddress()%>"><%= theater.getName() %></li>
				        <%
				            }
				        %>
				        </ul>
				    </div>
				<%
						panelIdx++;
					}
				%>
	        </div>
	    </div>
	    <!-- 하단에 표시할 극장 정보 -->
	    <div id="theater-detail" class="mt-5" style="display:none;">
		    <h3 id="theater-title" style="font-size:2rem; font-weight:700"></h3>
		    <!-- 지도를 표시할 영역 -->
		    <div id="theater-map" style="height:360px; margin-top:24px;"></div>
		</div>
	</div>
</body>
<script>
	$(function(){
	    // 극장명 클릭 시 극장명(지역 이름점)과 지도 표시
	    $(".theater-item").on('click', function(){
	        let region = $(this).data('region');
	        let name = $(this).data('name');
	        let address = $(this).data('address');
	
	        // 제목 표시
	        $('#theater-title').text(region + ' ' + name);
	
	        // 지도 표시
	        // 구글맵 "embed"로 간단히 주소 지도 띄우기
	        let mapHtml = '<iframe width="100%" height="100%" style="border:0" loading="lazy" allowfullscreen referrerpolicy="no-referrer-when-downgrade"'
	            + ' src="https://www.google.com/maps?q=' + encodeURIComponent(address) + '&output=embed">'
	            + '</iframe>';
	        $('#theater-map').html(mapHtml);
	
	        // 상세 영역 표시
	        $('#theater-detail').show();

	    });
	    
	    // 상단 탭 클릭 시 탭 css 및 표시할 목록 변경
	    
	});
</script>
</html>