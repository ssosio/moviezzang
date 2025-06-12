<%@page import="data.dto.AuditoriumDTO"%>
<%@page import="data.dao.AuditoriumDAO"%>
<%@page import="data.dto.TheaterDTO"%>
<%@page import="data.dao.TheaterDAO"%>
<%@page import="data.dao.ScreeningDAO"%>
<%@page import="data.dto.MovieDTO"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.MovieDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	MovieDAO dao = MovieDAO.getInstance();
	ScreeningDAO sdao = ScreeningDAO.getInstance();
	TheaterDAO tdao = TheaterDAO.getInstance();
	AuditoriumDAO adao = AuditoriumDAO.getInstance();
	
	List<MovieDTO> list = dao.getAllDatas();
	List<TheaterDTO> tList = tdao.getAllDatas();
%>
<div class="container-fluid px-0">
	<h2 class="mb-4 table-title">상영스케줄 등록</h2>
	<div class="main-content shadow-sm rounded-4 p-4" style="background: #fff;">
		<form id="scheduleForm">
			<!-- 1행: 영화/극장/상영관 -->
			<div class="row align-items-start gy-3">
				<div class="col-md-4">
					<label class="form-label fw-bold">영화 선택</label> 
					<select id="movieSelect" class="form-select">
						<option value="">영화를 선택하세요</option>
						<%
							for(MovieDTO dto : list)
							{
						%>
						<option value="<%=dto.getId()%>" data-poster="<%=dto.getPoster_url()%>" data-runtime="<%=dto.getRuntime()%>"><%=dto.getTitle()%></option>
						<%
							}
						%>
					</select>
					<div class="text-center" style="min-height:140px;">
					    <img id="moviePoster" src="" alt="포스터" class="img-thumbnail rounded shadow-sm" style="max-width:120px; max-height:140px; display:none;">
					</div>
					<input type="hidden" id="mRuntime">
				</div>
				<div class="col-md-4">
					<label class="form-label fw-bold">극장</label> 
					<select id="theaterSelect" class="form-select">
						<option value="">극장을 선택하세요</option>
						<%
							for(TheaterDTO dto : tList)
							{
						%>
						<option value="<%=dto.getId()%>"><%=dto.getRegion()%> <%=dto.getName()%>점</option>
						<%
							}
						%>
					</select>
				</div>
				<div class="col-md-4">
					<label class="form-label fw-bold">상영관</label> 
					<select id="auditoriumSelect" class="form-select">
						<option value="">상영관을 선택하세요</option>
					</select>
				</div>
			</div>
			<!-- 2행: 시간/가격/등록버튼 -->
			<div class="row align-items-start gy-3 mt-2">
				<div class="col-md-4">
					<label class="form-label fw-bold">상영 시작 시간</label> <input type="datetime-local" id="startTimeInput" class="form-control">
				</div>
				<div class="col-md-4">
					<label class="form-label fw-bold">가격(원)</label> <input type="number" id="priceInput" class="form-control" min="0" placeholder="예: 15000">
				</div>
				<div class="col-md-4 d-flex align-items-end justify-content-end">
					<button id="btnScheduleAdd" type="button" class="btn btn-primary px-4 py-2 rounded-3 shadow-sm">등록</button>
				</div>
			</div>
		</form>
	</div>
</div>

<!-- 스크립트 처리 -->
<script>
	let now = new Date();
	let pad = n => String(n).padStart(2, "0");
	let minDateTime = now.getFullYear() + "-" +
	                  pad(now.getMonth() + 1) + "-" +
	                  pad(now.getDate()) + "T" +
	                  pad(now.getHours()) + ":" +
	                  pad(now.getMinutes());
	$("#startTimeInput").attr("min", minDateTime);

	$("#movieSelect").on("change", function(){
		  let posterUrl = $(this).find("option:selected").data("poster");
		  
		  if(posterUrl){
			posterUrl = (posterUrl.startsWith("https://") ? posterUrl : "https://image.tmdb.org/t/p/w500" + posterUrl);
			  
		  	$("#moviePoster").attr("src", posterUrl).show();
		  } else {
		  	$("#moviePoster").hide();
		  }
	});
	
	$("#theaterSelect").on("change", function(){		
		const theaterId = $(this).val();
		const $auditoriumSelect = $("#auditoriumSelect");
		$auditoriumSelect.empty().append('<option value="">상영관을 선택하세요</option>');
		
		if(theaterId) {
			$.ajax({
		    	url: "./admin/getAuditorium.jsp",
		      	method: "GET",
		      	data: { theaterId: theaterId },
		      	dataType: "json",
		      	success: function(res){
		        	res.forEach(function(data){
						//console.log(data);
						//console.log(data.id);
						//console.log(data.name);
		        		$auditoriumSelect.append('<option value="' + data.id + '">' + data.name + '</option>');
		        	});
		   		}
		    });
		}
	});
	
	$("#btnScheduleAdd").on("click", function(){		
		const movieId = $("#movieSelect").val();
		const runtime = $("#movieSelect").find("option:selected").data("runtime");
	    const auditoriumId = $("#auditoriumSelect").val();
	    const startTime = $("#startTimeInput").val().replace("T", " ");
	    const price = $("#priceInput").val();

	    // 유효성 체크 (비어있는 정보가 있는지 확인)
	    // 극장을 선택해야 상영관을 선택할 수 있으니 극장은 안해도 된다
	    if(!movieId) {
	        alert("영화를 선택하세요.");
	        $("#movieSelect").focus();
	        return;
	    }
	    if(!auditoriumId) {
	        alert("상영관을 선택하세요.");
	        $("#auditoriumSelect").focus();
	        return;
	    }
	    if(!startTime) {
	        alert("상영 시작 시간을 입력하세요.");
	        $("#startTimeInput").focus();
	        return;
	    }
	    if(!price) {
	        alert("가격을 입력하세요.");
	        $("#priceInput").focus();
	        return;
	    }
	    
	    $.ajax({
	    	url: "./admin/insertScreening.jsp",
	      	method: "POST",
	      	data: { 
	      		auditoriumId: auditoriumId, 
	      		movieId: movieId,
	            runtime: runtime,           	
	            startTime: startTime,
	            price: price
	      	},
	      	dataType: "json",
	      	success: function(res){
	      		if(res.success){
	                alert("상영스케줄이 등록되었습니다");
	                // 폼 초기화 or 테이블 갱신 필요
	            } else {
					// res에 msg 항목이 있으면 그거 출력하고, || 아니면 오른쪽 메세지
	                alert(res.msg || "등록에 실패했습니다");
	            }
	   		}
	    });
	});
</script>