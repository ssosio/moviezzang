<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="data.dao.ReviewDAO" %>
<%
String userId = request.getParameter("user_id");
String movieId = request.getParameter("movie_id");
String movieName = request.getParameter("name");
int result = ReviewDAO.getInstance().deleteReview(userId, movieId);
if (result > 0) {%>
	  <script>
		 alert("리뷰 삭제에 성공했습니다.");
	     location.href = "<%=request.getContextPath()%>/index.jsp?main=movie/movieDetail.jsp&id=<%=movieId%>&name=<%=movieName%>";
	     	</script>
} else {
%>
  <script>
    alert("리뷰 삭제 실패!");
    history.back();
  </script>
<%
}
%>
