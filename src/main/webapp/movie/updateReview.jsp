<%@ page import="data.dao.ReviewDAO, data.dao.MovieDAO, data.dto.ReviewDTO" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweet-modal/dist/min/jquery.sweet-modal.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweet-modal/dist/min/jquery.sweet-modal.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

String userId = request.getParameter("user_id");
String movieId = request.getParameter("movie_id");
String movieName = request.getParameter("movieName");
String content = request.getParameter("content");
int rating = Integer.parseInt(request.getParameter("rating"));

ReviewDTO dto = new ReviewDTO();
dto.setUserId(userId);
dto.setMovieId(movieId);
dto.setContent(content);
dto.setRating(rating);

ReviewDAO reviewDao = ReviewDAO.getInstance();
MovieDAO movieDao = MovieDAO.getInstance();

int result = reviewDao.updateReview(dto);


String encodedMovieName = "";
try {
    encodedMovieName = URLEncoder.encode(movieName, "UTF-8");
} catch (Exception e) {
    encodedMovieName = movieName; // fallback
}

if (result > 0) {
    movieDao.updateLocalScore(movieId); // 평균 평점 갱신
%>
<script>
Swal.fire({
    title: "수정 완료!",
    text: "리뷰 수정에 성공했습니다.",
    icon: "success",
    showConfirmButton: false,
    timer: 1500
}).then(function(){
    location.href = "<%=request.getContextPath()%>/index.jsp?main=movie/movieDetail.jsp&id=<%=movieId%>&name=<%=encodedMovieName%>";
});
</script>
<%
} else {
%>
<script>
Swal.fire("리뷰 수정 실패!", "다시 시도해주세요.", "error");
</script>
<%
}
%>
</body>
</html>