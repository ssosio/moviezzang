<%@page import="data.dto.MovieDTO"%>
<%@page import="data.dao.MovieDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="data.dto.UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="../../component/menu/headerResources.jsp" %>
<!DOCTYPE html>
<html>
<%
	String root=request.getContextPath();

	String id=request.getParameter("id");
	String userid=(String)session.getAttribute("userid");
    // 로그인 체크
   // 로그인한 사용자의 시퀀스 번호
    UserDAO dao=UserDAO.getInstance();
    String uid=dao.getId(userid);
     // 주소창에서 전달된 id

    if (userid == null || id == null || !id.equals(uid)) {
    	    
        // 로그인 안 된 사용자        
        %>
        <script type="text/javascript">
        
			//history.back();
			location.href="<%=root%>/component/error/notFound.jsp"
        </script>
        <%
    }
%>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<title>Insert title here</title>
<%
/* response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0); */
%>
<script type="text/javascript">

$(function () {
	  const select = document.getElementById("monthSelect");
	  const today = new Date();

	  if (!select) {
	    console.error("select 못 찾음");
	    return;
	  }

	  for (let i = 0; i < 6; i++) {
	    const date = new Date(today.getFullYear(), today.getMonth() - i, 1);
	    const year = date.getFullYear();
	    const month = date.getMonth() + 1;

	    const option = document.createElement("option");
	    option.value = `\${year}-\${month.toString().padStart(2, '0')}`;
	    option.text = `\${year}년 \${month}월`;
	    select.appendChild(option);
	  };
	  
		// 초기 상태에서 예매내역이 없으면 메시지 보여주기
	  if ($("#reserveTable tr[data-reserved]").length === 0) {
	    $("#reservedinfo").text('예매한 영화가 없습니다.').show();
	  } else {
	    $("#reservedinfo").hide();
	  }

	  // 초기 상태에서 취소내역이 없으면 메시지 보여주기
	  if ($("#canceltable tr[data-reserved]").length === 0) {
	    $("#cancelinfo").text('취소한 영화가 없습니다.').show();
	  } else {
	    $("#cancelinfo").hide();
	  }
	  
	  // 필터링 이벤트
	  $("#monthSelect").on("change", function () {
	    const selectedMonth = $(this).val(); // "YYYY-MM"
	    let visibleCount = 0;
	    let visibleCount2 = 0;
	    
	    $("#reserveTable tr[data-reserved]").each(function () {
	      const reservedDate = $(this).data("reserved");
	      if (selectedMonth === "all" || reservedDate === selectedMonth) {
	        $(this).show();
	        visibleCount++;
	      } else {
	        $(this).hide();
	      	
	      };

	    });
	    
	    if (visibleCount === 0) {
	        $("#reservedinfo").text('예매한 영화가 없습니다.').show();
	      } else {
	        $("#reservedinfo").hide();
	      }
	    
	    $("#canceltable tr[data-reserved]").each(function () {
		      const reservedDate = $(this).data("reserved");
		      if (selectedMonth === "all" || reservedDate === selectedMonth) {
		        $(this).show();
		        visibleCount2++;
		      } else {
		        $(this).hide();
		      	
		      };

		    });
		    
		    if (visibleCount2 === 0) {
		        $("#cancelinfo").text('취소한 영화가 없습니다.').show();
		      } else {
		        $("#cancelinfo").hide();
		      }
	  });
	  
	  
	  $("#reserveTable tr[data-reserved]").each(function () {
		    const startTimeText = $(this).find("td").eq(3).text().trim(); 
		    const [datePart, timePart] = startTimeText.split(" ");
		    const [year, month, day] = datePart.split("-");
		    const [hour, minute] = timePart.split(":");
		    const showTime = new Date(year, month - 1, day, hour, minute); // JS의 month는 0부터 시작

		    const now = new Date();

		    
		    if (showTime <= now) {
		      $(this).find("i.bi-x-circle").hide();
		      $(this).find(".goreview").show();
		    }else{
		    	$(this).find(".goreview").hide();
		    }
		    
		    
		  });
	 
	});

</script>
<style type="text/css"> 
    body {
      margin: 0;
      padding: 0;
      background-color: white;
      
    }

    .booklist-wrapper {
      display: flex;
      max-width: 1380px;
      margin: 100px auto 50px auto;
      padding: 20px;
      gap: 30px;
    }

    .booklist-content {
      flex: 1;
    }

    /* .booklist-header {
      background: linear-gradient(to right, #1a1a3c, #181847);
      color: white;
      padding: 20px;
      border-radius: 15px;
    } */

    .booklist-header h3 {
      margin: 0;
      font-size: 20px;
    }
   
    .booklist-box {
      background-color: white;
      border-radius: 10px;
      padding: 20px;
      margin-top: -50px;
      /* box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); */
      width: 200px;
      background-color: whitesmoke;
      margin-left: 920px;
    }

    .booklist-section h4 {
      margin-top: 30px;
      margin-bottom: 10px;
    }

  	.booklist-list {
  	  border-bottom: 0px solid lightgray;
      text-align: center;         
      display: flex;              
      justify-content: center;    
      align-items: center;         
      margin-top: 15px;
}
  
  </style>
  <%
	
	
	/* System.out.println("userid="+userid); */
  	
	
  	
  	List<HashMap<String, String>> list=dao.getReserveList(userid);
  	List<HashMap<String, String>> clist=dao.getCancelList(userid);
  	NumberFormat nf=NumberFormat.getCurrencyInstance();
  	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
  %>
</head>
<body>
<div class="booklist-wrapper">
  
  <!-- sideBar -->
<jsp:include page="sideBar.jsp"></jsp:include>


  <!-- Main content -->
  <div class="booklist-content">
    <div class="booklist-header">
     <h2 class="text-3xl font-bold" style="color: #000080">예매 내역</h2>
    </div>

    <div class="booklist-section">
      <div class="booklist-box">
        <div>예매날짜선택</div>
        <span><select id="monthSelect" class="w-40 p-2 border border-white-300 rounded-md">
  			<option value="all">전체보기</option>
		</select></span>
      </div>
      
      	<div class="booklist-list">
      		<table class="table" id="reserveTable">
      		<tr>
      			<th style="background-color: whitesmoke">예매일시</th>
      			<th style="background-color: whitesmoke">영화명</th>
      			<th style="background-color: whitesmoke">극장</th>
      			<th style="background-color: whitesmoke">상영일시</th>
      			<th style="background-color: whitesmoke">인원수</th>
      			<th style="background-color: whitesmoke">결제금액</th>
      			<th style="background-color: whitesmoke">리뷰작성</th>
      			<th style="background-color: whitesmoke">예매취소</th>
      		</tr>
      			<tr>
      			<td id="reservedinfo" colspan="8"></td>
      			</tr>
 				
 				
      		<%
      			for(int i=0;i<list.size();i++)
      			{
      				HashMap<String,String> map=list.get(i);
      				String movietitle=map.get("title");
      				
      				MovieDAO mdao=MovieDAO.getInstance();
 				   MovieDTO mdto=mdao.getMovieBytitle(movietitle);
      				
      				
      				int price = (map.get("lastpay") != null && !map.get("lastpay").trim().isEmpty())
      					    ? Integer.parseInt(map.get("lastpay"))
      					    : 0;
      				
      				SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      				SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

      				String startTimeStr = map.get("start_time"); 
      				String formattedTime = "";

      				try {
      				    java.util.Date date = inputFormat.parse(startTimeStr);  
      				    formattedTime = outputFormat.format(date);              
      				} catch (Exception e) {
      				    formattedTime = startTimeStr;
      				}
      				
      				
      			%>
      			
      			<tr data-id=<%=map.get("id") %> data-reserved="<%=map.get("reserved_at").substring(0,7)%>">
      				<td><%=map.get("reserved_at") %></td>
      				<td><%=map.get("title") %></td>
      				<td><%=map.get("name") %></td>
      				<td><%=formattedTime%></td>
      				<td><%=map.get("reserved_count")%></td>
      				<td><%=nf.format(price)%></td>
      				<td><a class="goreview" href="index.jsp?main=movie/movieDetail.jsp?id=<%=mdto.getId() %>&name=<%=mdto.getTitle()%>#reviewSection"><img src="resources/review.jpg" style="width: 28px; height: 28px;
      				margin-left: 27px;"></a></td>
      				<td class="starttd"><a class="cancel-btn" onclick="cancelReserve(this)"
      				><i class="bi bi-x-circle" style="color: red; cursor: pointer;"></i></a></td>
      			</tr>
      			
      			<%}%>
      			
      		
      		
      		</table>
      		
      	</div>
    </div>
    <br>
    <div style="margin-top: 80px;">
     <div class="booklist-header">
     <h2 class="text-2xl font-bold" style="color: #000080">예매취소내역</h2>
    </div>
    <br>
    	<div class="booklist-list2" style="text-align: center;">
      		<table class="table" id="canceltable">
      		  <tr>
      			<th style="background-color: whitesmoke">취소일시</th>
      			<th style="background-color: whitesmoke">영화명</th>
      			<th style="background-color: whitesmoke">극장</th>
      			<th style="background-color: whitesmoke">상영일시</th>
      			<th style="background-color: whitesmoke">인원수</th>
      			<th style="background-color: whitesmoke">취소금액</th>
      	     </tr>
      	     <tr>
      			<td id="cancelinfo" colspan="8"></td>
      			</tr>
      	     <%
      			for(int i=0;i<clist.size();i++)
      			{
      				HashMap<String,String> map=clist.get(i);
      				
      				
      				
      				int price = (map.get("lastpay") != null && !map.get("lastpay").trim().isEmpty())
      					    ? Integer.parseInt(map.get("lastpay"))
      					    : 0;
      				
      				SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      				SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

      				String startTimeStr = map.get("start_time"); 
      				String formattedTime = "";

      				try {
      				    java.util.Date date = inputFormat.parse(startTimeStr);  
      				    formattedTime = outputFormat.format(date);              
      				} catch (Exception e) {
      				    formattedTime = startTimeStr; // 실패 시 원본 출력
      				}
      				
      			%>
      			
      			<tr data-reserved="<%=map.get("reserved_at").substring(0,7)%>">
      				<td><%=map.get("reserved_at") %></td>
      				<td><%=map.get("title") %></td>
      				<td><%=map.get("name") %></td>
      				<td><%=formattedTime %></td>
      				<td><%=map.get("reserved_count") %></td>
      				<td><%=nf.format(price)%></td>
      				
      			</tr>
      			
      			<%}%>
      	     
      		</table>
      	</div>
    
  </div>
  
</div>
<script type="text/javascript">
function cancelReserve(element) {
	const reserveId = element.closest("tr").getAttribute("data-id");
    if (!confirm("이 예매를 취소하시겠습니까?")) return;

    $.ajax({
        url: "member/mypage/cancelReserve.jsp",
        type: "post",
        data: { id: reserveId },
        dataType: "json",
        success: function(res) {
            if (res.result === "success") {
               alert("취소되었습니다.");
               const row = element.closest("tr");
               row.remove(); // 예매 내역에서 제거
               
				location.reload();
            } else {
                alert("예매 취소에 실패했습니다.");
            }
        },
        error: function() {
            alert("서버 통신 오류가 발생했습니다.");
        }
    });
}


</script>
</body>


</html>