<%@ page import="data.dao.ReviewDAO, data.dto.ReviewDTO" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<%
request.setCharacterEncoding("UTF-8");

String userId = request.getParameter("user_id");
String movieId = request.getParameter("movie_id");
String movieName = request.getParameter("name");
String content = request.getParameter("content");
int rating = Integer.parseInt(request.getParameter("rating"));

ReviewDTO dto = new ReviewDTO();
dto.setUserId(userId);
dto.setMovieId(movieId);
dto.setContent(content);
dto.setRating(rating);

int result = ReviewDAO.getInstance().updateReview(dto);
if (result > 0) {%>
	
	  <script>
	 alert("리뷰 수정에 성공했습니다.");
     location.href = "<%=request.getContextPath()%>/index.jsp?main=movie/movieDetail.jsp&id=<%=movieId%>&name=<%=movieName%>";
     	</script>
} else {
%>
  <script>
    alert("리뷰 수정 실패!");
    history.back();
  </script>
<%
}
%>
