<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="data.dao.ReviewDAO, data.dao.MovieDAO" %>
<%@ page import="java.net.URLEncoder" %>
<%
request.setCharacterEncoding("UTF-8");

String userId = request.getParameter("user_id");
String movieId = request.getParameter("movie_id");
String movieName = request.getParameter("name");

ReviewDAO reviewDao = ReviewDAO.getInstance();
MovieDAO movieDao = MovieDAO.getInstance();

int result = reviewDao.deleteReview(userId, movieId);

String encodedMovieName = "";
try {
    encodedMovieName = URLEncoder.encode(movieName, "UTF-8");
} catch (Exception e) {
    encodedMovieName = movieName; // fallback
}

if (result > 0) {
    movieDao.updateLocalScore(movieId);
%>
<script>
  alert("리뷰 삭제에 성공했습니다.");
  location.href = "<%=request.getContextPath()%>/index.jsp?main=movie/movieDetail.jsp&id=<%=movieId%>&name=<%=encodedMovieName%>";
</script>
<%
} else {
%>
<script>
  alert("리뷰 삭제 실패!");
  history.back();
</script>
<%
}
%>
