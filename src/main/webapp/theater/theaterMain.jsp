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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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
%>
<body>
	<div class="container" style="max-width:900px;">
	    <h2 class="mt-5 mb-3">전체극장</h2>
	    <div class="theater-tab-box">
	        <!-- 지역별 탭 -->
	        <ul class="nav nav-tabs" id="theaterTab" role="tablist">
	        <%
	        	for(String regions : regionList)
	        	{
	        %>
	       	 	<li class="nav-item" role="presentation">
	                <button class="nav-link " id="tab-panel" data-bs-toggle="tab" type="button" role="tab"><%=regions%></button>
	            </li>
	        <%
	        	}
	        %>
	           
	        </ul>
	        <!-- 극장 리스트 패널 -->
	        <div class="tab-content" id="theaterTabContent">
	            <div class="tab-pane fade show active" id="panel-seoul" role="tabpanel">
	                <ul class="theater-list">
	                    <li>강남</li>
	                    <li>더 부티크 목동현대백화점</li>
	                    <li>상봉</li>
	                    <li>송파파크하비오</li>
	                    <li>코엑스</li>
	                    <li>강동</li>
	                    <li>동대문</li>
	                    <li>상암월드컵경기장</li>
	                    <li>신촌</li>
	                    <li>홍대</li>
	                    <li>구의 이스트폴 <span style="color:#1976d2;">N</span></li>
	                    <li>마곡</li>
	                    <li>성수</li>
	                    <li>이수</li>
	                    <li>화곡</li>
	                    <li>군자</li>
	                    <li>목동</li>
	                    <li>센트럴</li>
	                    <li>창동</li>
	                    <li>ARTNINE</li>
	                </ul>
	            </div>
	            <div class="tab-pane fade" id="panel-gg" role="tabpanel">
	                <ul class="theater-list">
	                    <li>수원</li>
	                    <li>고양스타필드</li>
	                    <li>부천</li>
	                    <li>안양</li>
	                    <li>의정부</li>
	                </ul>
	            </div>
	            <div class="tab-pane fade" id="panel-incheon" role="tabpanel">
	                <ul class="theater-list">
	                    <li>인천연수</li>
	                    <li>부평</li>
	                </ul>
	            </div>
	            <div class="tab-pane fade" id="panel-daejeon" role="tabpanel">
	                <ul class="theater-list">
	                    <li>대전둔산</li>
	                    <li>천안아산</li>
	                </ul>
	            </div>
	            <div class="tab-pane fade" id="panel-busan" role="tabpanel">
	                <ul class="theater-list">
	                    <li>서면</li>
	                    <li>해운대</li>
	                    <li>대구동성로</li>
	                </ul>
	            </div>
	            <div class="tab-pane fade" id="panel-gwangju" role="tabpanel">
	                <ul class="theater-list">
	                    <li>광주상무</li>
	                    <li>전주</li>
	                </ul>
	            </div>
	            <div class="tab-pane fade" id="panel-gangwon" role="tabpanel">
	                <ul class="theater-list">
	                    <li>원주</li>
	                </ul>
	            </div>
	            <div class="tab-pane fade" id="panel-jeju" role="tabpanel">
	                <ul class="theater-list">
	                    <li>제주</li>
	                </ul>
	            </div>
	        </div>
	    </div>
	</div>
</body>
</html>