<%@page import="java.text.NumberFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.SeatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/book/buttonStyle.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>Insert title here</title>
<style type="text/css">
	body {
		font-family: "Noto Sans KR";
	}
	.container {
		position: absolute;
		display: flex;
		flex-wrap: wrap;
	}
	.mainbox {
		display: flex;
	}
	.title {
		margin: 100px 0 0 100px;
		width: 600px;
	}
	.seatbox {
		width: 600px;
		height: 750px;
		margin-top: 1px;
		margin-left: 100px;
		border: 1px solid #ccc;
	}
	.subject {
		display: flex;
		justify-content: space-between;
		width: 600px;
		align-items: center;
		margin-left: 100px;
	}
	.seatcount {
		background: #ddd;
		display: flex;
		align-items: center;
		padding: 10px;
		margin-top: 5px;
	}
	.seatcount > div {
		display: flex;
		align-items: center;
	}
	.seatcount span:first-child {
		margin-right: 10px;
		margin-left: 10px;
	}
	.btn-down-a,
	.btn-down-t,
	.btn-up-a,
	.btn-up-t,
	.adult-inwoncount,
	.teenager-inwoncount {
		height: 30px;
		font-size: 16px;
		padding: 0 10px;
		border: 1px solid #ccc;
		background: white;
		line-height: 30px;
	}
	.btn-down-a,
	.btn-down-t {
		border-right: none;
		border-radius: 10px 0px 0px 10px;
		border-right: 1px solid #888;
	}
	.adult-inwoncount,
	.teenager-inwoncount {
		border-left: none;
		border-right: none;
		align-items: center;
	}
	.btn-up-a,
	.btn-up-t {
		border-left: none;
		border-radius: 0px 10px 10px 0px;
		border-left: 1px solid #888;
	}
	.teenagerseat {
		margin-left: 50px;
	}
	.screen {
		background: #ddd;
		text-align: center;
		margin-top: 5px;
	}
	.seat {
		border-top: none;
		height: 600px;
		text-align: center;
		margin-top: 40px;
	}
	.seat-row {
		margin-left: 20px;
	}
	button.selseat {
		margin-top: 5px;
	}
	.paybox {
		border: 1px #333 solid;
		background: #434343;
		border-radius: 15px;
		color: #ccc;
		width: 350px;
		height: 660px;
		margin-left: 40px;
		margin-top: 40px;
		padding: 25px;
	}
	.pay-info {
		display: flex;
		justify-content: space-between;
		align-items: flex-end;
	}
	.pay-infoString p {
		margin-bottom: 0px;
	}
	.pay-info > img {
		width: 90px;
		height: 120px;
	}
	p.auditorium,
	p.theater {
		margin-bottom: 0px;
	}
	.seat-choice-info {
		border: 1px gray solid;
		border-radius: 5px;
		height: 250px;
		display: flex;
		width: 100%;
	}
	.legend {
		border-right: 1px gray solid;
		height: 100%;
		width: 50%;
	}
	.myseat {
		width: 50%;
	}
	.myseat > span {
		text-align: center;
		display: block;
		font-weight: bold;
		margin: 15px auto 10px;
	}
	.myseat-show {
		display: grid;
		grid-template-columns: repeat(2, 40px);
		gap: 10px;
		justify-content: center;
		width: fit-content;
		margin: 0 auto;
	}
	.myseat-show > div {
		height: 40px;
		width: 40px;
		border: 1px solid gray;
		text-align: center;
		line-height: 40px;
		box-sizing: border-box;
	}
	.pay {
		position: relative;
		margin-top: 20px;
		margin-bottom: 20px;
		width: 100%;
	}
	.pay > span:first-child {
		color: orange;
		font-weight: bold;
		font-size: 16px;
	}
	.pay > span:last-child {
		color: white;
		font-size: 18px;
		font-weight: bold;
		position: absolute;
		right: 0;
		top: 50%;
		transform: translateY(-50%);
	}
	.pay-btn {
		text-align: center;
		margin-top: 20px;
	}
	.pay-btn .btn-pay {
		width: 240px;
		height: 40px;
		font-size: 16px;
		font-weight: bold;
	}
	.seat-overlay {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(200, 200, 200, 0.7);
		display: flex;
		justify-content: center;
		align-items: center;
		font-size: 20px;
		font-weight: bold;
		z-index: 10;
		display: none;
		pointer-events: none;
		text-align: center;
	}
	.seat-overlay > span {
		padding-top: 30px;
		display: block;
	}
</style>
<%
	String screening_id = request.getParameter("screening_id");
	System.out.println(">>> screening_idzz: " + screening_id);
	SeatDAO dao = SeatDAO.getInstance();
	List<HashMap<String,String>> list = dao.getSeatInfo(screening_id);

	if(list == null || list.isEmpty()) {
	    out.println("<h3>좌석 정보를 불러오지 못했습니다. 상영 정보가 없거나 DB 오류입니다.</h3>");
	    return;
	}

	HashMap<String,String> map = list.get(0);
	String title = map.get("movie_title");
	String poster = map.get("poster");
	String auditorium_name = map.get("auditorium_name");
	String theater_name = map.get("theater_name");
	String start_time = map.get("start_time");
	int price = Integer.parseInt(map.get("price"));

	NumberFormat nf2 = NumberFormat.getInstance();
	NumberFormat nf = NumberFormat.getCurrencyInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


%>
</head>
<script type="text/javascript">
$(function() {
	//screening id와 posterurl 가져오기
	const screening_id = "<%=screening_id%>";
	//console.log(poster);
	/*
	$(".selseat").on("click",function(){
		let adult = parseInt($(".adult-inwoncount").text());
		let teen = parseInt($(".teenager-inwoncount").text());
		let total = adult + teen;


		let selectCount = $(".selseat.select").length;


		if($(this).hasClass("select")){
			$(this).removeClass("select");
		}else{
			if(selectCount >=total){
			 alert("선택한 인원수를 초과하였습니다.");
			 return;
			}
			$(this).addClass("select");
		}
		updateShowSelSeat();
	});
	*/
	//좌석선택 로직(hover)

	$(".selseat").on("mouseover", function () {
	    const $this = $(this);

	    // 좌석이 비활성(disabled)이면 hover 효과 안줌
	    if ($this.prop("disabled")) return;
	    const col = parseInt($this.attr("col"));
	    const row = $this.attr("row");
	    const total = parseInt($(".adult-inwoncount").text()) + parseInt($(".teenager-inwoncount").text());
	    const selected = $(".selseat.select").length;
	    const remaining = total - selected;

	    // 인원수 0명이거나, NaN이면 hover 안줌
	    if (!total || isNaN(total) || total === 0) return;

	    if (remaining >= 2) {
	        // 항상 "짝수 번호 기준"으로 두 자리
	        // ex) col=2 -> 1,2 / col=5 -> 5,6
	        let startCol = (col % 2 === 0) ? col - 1 : col;
	        if(startCol<1) return;
	        const $seat1 = $(".selseat[row='" + row + "'][col='" + startCol + "']");
	        const $seat2 = $(".selseat[row='" + row + "'][col='" + (startCol + 1) + "']");

	        if (
	            $seat1.length === 0 || $seat2.length === 0 ||
	            $seat1.hasClass("reserved") || $seat2.hasClass("reserved") ||
	            $seat1.prop("disabled") || $seat2.prop("disabled")
	        ) return;

	        $seat1.addClass("hover");
	        $seat2.addClass("hover");
	    } else if (remaining === 1) {
	        if ($this.hasClass("reserved") || $this.prop("disabled")) return;
	        $this.addClass("hover");
	    }
	}).on("mouseleave", function () {
	    $(".selseat").removeClass("hover");
	});


	// 좌석선택(클릭)
	$(document).on("click", ".selseat", function(){
	//$(".selseat").on("click", function () {

	const $this = $(this);
	console.log("CLICK!", $this.attr("row"), $this.attr("col"));
    if ($this.prop("disabled") || $this.hasClass("reserved")) return;

    const col = parseInt($this.attr("col"));
    const row = $this.attr("row");
    const total = parseInt($(".adult-inwoncount").text()) + parseInt($(".teenager-inwoncount").text());
    const selectedCount = $(".selseat.select").length;
    console.log("클릭시점 selectedCount:", selectedCount, "total:", total, "$this.hasClass('select'):", $this.hasClass("select"));
    let $seat1 = null, $seat2 = null;

    /// 테스트코드
    if($(this).hasClass("select")){
		console.log("선택된 단일 좌석 클릭");
		$(this).removeClass("select");
    }

    ///

    // 2명 이상일 때 (짝 붙여서 선택)
    if (total - selectedCount >= 2) {

    	console.log("ss");

		let startCol = (col % 2 === 0) ? col - 1 : col;

        if (startCol < 1){
		return;

        }
        const $seat1 = $(".selseat[row='" + row + "'][col='" + startCol + "']");
        const $seat2 = $(".selseat[row='" + row + "'][col='" + (startCol + 1) + "']");

        // 이미 둘 다 선택되어 있으면 → 해제
        if ($seat1.hasClass("select") && $seat2.hasClass("select")) {
			console.log("선택된 좌석 클릭");

			$seat1.removeClass("select");
            $seat2.removeClass("select");
            updateShowSelSeat();
            updatePrice();
            return;
        }

        // 둘 다 선택안된경우만 선택
        if (!$seat1.hasClass("select") && !$seat2.hasClass("select")) {
            if (selectedCount + 2 > total) {
                alert("선택한 인원 수를 초과했습니다.");
                return;
            }
            $seat1.addClass("select");
            $seat2.addClass("select");
            updateShowSelSeat();
            updatePrice();
            return;
        }

        return;

    }
    //단일일 경우
    else if(total - selectedCount === 1) {
        if ($this.hasClass("select")) {
            $this.removeClass("select");
        } else {
            if (selectedCount + 1 > total) {
                alert("선택한 인원 수를 초과했습니다.");
                return;
            }
            $this.addClass("select");
        }

    updateShowSelSeat();
    updatePrice();
    }
});



	//버튼누르면 인원수 증가하게(성인)
	$(".btn-up-a").on("click",function(){
		const countSpan = $(this).siblings(".adult-inwoncount");
		let count = parseInt(countSpan.text());
		//청소년 인원수
		let teen = parseInt($(".teenager-inwoncount").text());
		let total = count + teen;
		//최대인원 8명
		if(total>=8){
		 alert("최대 예약인원은 8명입니다.");
		 return;
		}
		count ++;
		countSpan.text(count);
	});
	//버튼누르면 인원수 감소소하게(성인)
	$(".btn-down-a").on("click",function(){
		const countSpan = $(this).siblings(".adult-inwoncount");
		let count = parseInt(countSpan.text());
		//선택된 좌석의 총 크기
		let selectCount = $(".selseat.select").length;

		let teen = parseInt($(".teenager-inwoncount").text());
		let totalInwon = count + teen;

		if(count>0){
			if(selectCount>totalInwon - 1){
				alert("선택한 좌석이 인원보다 많습니다.");
				return;
			}
		count --;
		countSpan.text(count);
		}
	});

	//버튼누르면 인원수 증가하게(청소년)
	$(".btn-up-t").on("click",function(){
		const countSpan = $(this).siblings(".teenager-inwoncount");
		let count = parseInt(countSpan.text());
		//성인 인원수
		let adult = parseInt($(".adult-inwoncount").text());
		let total = count + adult;
		//최대인원 8명
		if(total>=8){
			alert("최대 예약인원은 8명입니다.");
			return;
		}

		count ++;
		countSpan.text(count);
	});
	//버튼누르면 인원수 감소하게(청소년)
	$(".btn-down-t").on("click",function(){
		const countSpan = $(this).siblings(".teenager-inwoncount");
		let count = parseInt(countSpan.text());
		let adult = parseInt($(".adult-inwoncount").text());

		//선택한 좌석 총 크기
		let selectCount = $(".selseat.select").length;
		let totalInwon = adult + count;

		if(count>0){
			if(selectCount >totalInwon - 1){
				alert("선택한 좌석이 인원수보다 많습니다.");
				return;
			}
		count --;
		countSpan.text(count);
		}
	});

	//인원수 증가 감소버튼눌렀을시 인원수 선택 layout실행
	$(".btn-up-a, .btn-down-a, .btn-up-t, .btn-down-t").on("click",function(){
		seatLock();
		updatePrice();
		reservationSeatRule();
	});

	//초기화 버튼 클릭 시 인원수 0 으로초기화
	$(".btn-reset").on("click",function(){

		$(".adult-inwoncount").text(0);
		$(".teenager-inwoncount").text(0);
		$(".selseat").removeClass("select");

		seatLock();
		updatePrice();
		updateShowSelSeat();
	});

	//인원수를 정해야 버튼 선택할 수 있게 사용자함수
	function seatLock(){

	let adult = parseInt($(".adult-inwoncount").text());
	let teen = parseInt($(".teenager-inwoncount").text());
	let total = "";
	total = adult+teen;
	//인원수가 0명이면 버튼 선택못하는 화면 나오게
	if(total==0){
		$(".seat-overlay").show();
		$(".selseat").prop("disabled",true).css("opacity","0.5");
	}else{
		$(".seat-overlay").hide();

		$(".selseat").each(function(){
		 	if(!$(this).hasClass("reserved")){

		 		$(this).prop("disabled",false).css("opacity","1");
		 	}
		});
	}
	};

	//가격계산
	function updatePrice(){
		//인원수
		const adult = parseInt($(".adult-inwoncount").text());
		const teen = parseInt($(".teenager-inwoncount").text());

		//가격
		const adultPrice = <%=price%>;
		const teenPrice = Math.floor(adultPrice * 0.8);
		const totalPay = adultPrice * adult + teenPrice * teen;
		//천단위 쉼표 포함 포맷
		const formatTotalPay = new Intl.NumberFormat('ko-KR').format(totalPay);

		$(".pay span:last-child").text(formatTotalPay+"원");
	}

	//좌석 선택하면 div박스에 선택한 좌석 보이게하기.
	function updateShowSelSeat(){
		const selectSeats = $(".selseat.select");
		const $showBox = $(".myseat-show");

		$showBox.empty();

		selectSeats.each(function(){
			const seatNo = $(this).attr("seat-no");
			$showBox.append("<div class='div-showSeat'>"+seatNo+"</div>");

		});
		//선택이 8개보다 작으면 빈 박스 채움
		const emptyBoxCount = 8 - selectSeats.length;
		for(let i=0;i<emptyBoxCount; i++){
		$showBox.append("<div>?</div>");
		}

	}

	//가장자리 제한 함수
	function reservationSeatRule(){

		const totalSeat = parseInt($(".adult-inwoncount").text())+ parseInt($(".teenager-inwoncount").text());

		$(".selseat").each(function(){
		const $btn =$(this);
		const col = parseInt($btn.attr("col"));

		//이미 예약된 좌석은 제외시킨다.
		if($btn.hasClass("reserved")) return;
		//가장자리 한칸 띄운자리 4, 11
		const isEdgeSide = (col === 4 || col === 11);

		if(totalSeat == 1 && isEdgeSide){
			$btn.prop("disabled",true).addClass("temp-reserved").html("<i class='ri-lock-fill' style='color:gray;'></i>");
		}else if(totalSeat > 1 && isEdgeSide){
			if($btn.hasClass("temp-reserved") && !$btn.hasClass("select")){
			$btn.prop("disabled",false).removeClass("temp-reserved").text(col);
			}
		}
		});
	}

	//화면로딩시 바로실행
	seatLock();
	updatePrice();
	reservationSeatRule();
})
</script>
<body>
	<div class="container">
		<div class="title">
			<h3><b>빠른예매</b></h3>
			<hr>
		</div>
		<div class="subject">
				 	<h5>좌석예매</h5>
				 	<button type="button" class="btn-mov btn-reset">초기화</button>
				</div>
		<div class="mainbox">
			<div class="seatbox">
				<div class="seatcount">
					<div class="adultseat">
						<span>성인</span>
							<button class="btn-down-a">-</button>
							<span class="adult-inwoncount">0</span>
							<button class="btn-up-a">+</button>
					</div>
					<div class="teenagerseat">
						<span>청소년</span>
						<button class="btn-down-t">-</button>
						<span class="teenager-inwoncount">0</span>
						<button class="btn-up-t">+</button>
					</div>
				</div>
				<div class="screen">
				 <span>screen</span>
				</div>
				<div class="seat-wrapper" style="position: relative;">
					<div class="seat">
					<%
					String[] seatrows ={"A","B","C","D","E","F","G","H","I","J","K","l","M","N"};
					for(int i=1;i<=14;i++){
						String row = seatrows[i-1];
					%>
						<div style="display: flex; align-items: center; height: 40px;" class="seat-row">
							<span style="width: 20px; display: inline-block; text-align: center; margin-right: 15px;"><%=seatrows[i-1] %></span>

						<%for(int j=1;j<=14;j++){
						//버튼에 seat의 열 값 넣어주기위한 col 생성
						String col = String.valueOf(j);
						String reserved = "";
						//버튼 3번이랑 13번부터 왼쪽 띄워주기 위한 마진
						String margin = (j==3 || j==13)?"20px":"";

						//DAO에서 조회한값으로 seat의 row와 col을 얻는다
						for(HashMap<String,String> m:list){
							String seat_row = m.get("seat_row");
							String seat_col = m.get("seat_col");

							//해당 screening의 seat테이블의 row와 col이 button 버튼의 row와 col 이 일치하고
							//is_reserved의 값이1이면(예약이 되어있으면) reserved -> 버튼을 disabled로 바꿈(버튼 선택불가)
							if(seat_row.equals(row) && seat_col.equals(col)){
								if("1".equals(m.get("is_reserved"))){
									reserved = "disabled reserved'";
								}
							}
						}
						%>
							<button class="btn-seat selseat <%=reserved.contains("reserved")?" reserved":"" %>" type="button" style="margin-left: <%=margin%>"
								row="<%=row%>" col="<%=col%>" seat-no="<%=seatrows[i-1]%><%=j%>"
								<%=reserved.contains("disabled")?"disabled":"" %>
								>
								<%if(reserved.contains("reserved")){%>
									<i class="ri-close-circle-fill" style="color: crimson;"></i>
								<% }else{%>
								<%=j %>
								<%} %>
								</button>
						<%}%>
						</div>
					<%}
					%>
					</div>
					<div class="seat-overlay">
					<span>인원수를 선택하세요</span>
					</div>
				</div>
		</div>
		</div>
		<div class="paybox">
			<div class="pay-title">
				<p><%=title %></p>
			</div>
			<hr>
			<div class="pay-info">
				<div class="pay-infosrting">
				<p class="theater"><%=theater_name %></p>
				<p class="auditorium"><%=auditorium_name %></p>
				<p class="date"><%=start_time %></p>
				</div>
				<%
				String posterUrl = "https://image.tmdb.org/t/p/w500";
				String photo = poster.startsWith("https:")?poster:posterUrl+poster;
				%>
				<img alt="" src="<%=photo%>">
			</div>
			<hr>
			<div class="seat-choice-info">
				<div class="legend">
					d
				</div>

				<div class="myseat">
					<span>선택좌석</span>
					<div class="myseat-show">
						<div>?</div>
						<div>?</div>
						<div>?</div>
						<div>?</div>
						<div>?</div>
						<div>?</div>
						<div>?</div>
						<div>?</div>
					</div>
				</div>
			</div>
			<br>
			<hr>
			<div class="pay">
			<span>최종결제금액</span>
			<span></span>
			</div>
			<div class="pay-btn" style="text-align: center; margin-top: 20px;">
				<button class="btn-pay">결제하기</button>
			</div>
		</div>
	</div>
</body>
</html>