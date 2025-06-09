<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container-fluid px-0">
	<h2 class="mb-4 table-title">상영스케줄 등록</h2>
	<div class="main-content shadow-sm rounded-4 p-4"
		style="background: #fff;">
		<form id="scheduleForm">
			<!-- 1행: 영화/극장/상영관 -->
			<div class="row align-items-start gy-3">
				<div class="col-md-4">
					<label class="form-label fw-bold">영화 선택</label> <select
						id="movieSelect" class="form-select">
						<option value="">영화를 선택하세요</option>
					</select>
				</div>
				<div class="col-md-4">
					<label class="form-label fw-bold">극장</label> <select
						id="theaterSelect" class="form-select">
						<option value="">극장을 선택하세요</option>
					</select>
				</div>
				<div class="col-md-4">
					<label class="form-label fw-bold">상영관</label> <select
						id="auditoriumSelect" class="form-select">
						<option value="">상영관을 선택하세요</option>
					</select>
				</div>
			</div>
			<!-- 2행: 시간/가격/등록버튼 -->
			<div class="row align-items-start gy-3 mt-2">
				<div class="col-md-4">
					<label class="form-label fw-bold">상영 시작 시간</label> <input
						type="datetime-local" id="startTimeInput" class="form-control">
				</div>
				<div class="col-md-4">
					<label class="form-label fw-bold">가격(원)</label> <input
						type="number" id="priceInput" class="form-control" min="0"
						placeholder="예: 15000">
				</div>
				<div class="col-md-4 d-flex align-items-end justify-content-end">
					<button id="btnScheduleAdd" type="button"
						class="btn btn-primary px-4 py-2 rounded-3 shadow-sm">등록</button>
				</div>
			</div>
		</form>
	</div>
</div>