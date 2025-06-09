<%@ page import="data.dto.ReviewDTO, data.dao.ReviewDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
request.setCharacterEncoding("UTF-8");

String movieName = request.getParameter("movieName");
String userId = request.getParameter("user_id");
String movieId = request.getParameter("movie_id");
String content = request.getParameter("content");
String ratingStr = request.getParameter("rating");
String encodedName = java.net.URLEncoder.encode(movieName, "UTF-8");

int rating = 0;
boolean valid = true;

if (userId == null || movieId == null || content == null || ratingStr == null || ratingStr.trim().equals("")) {
    valid = false;
} else {
    try {
        rating = Integer.parseInt(ratingStr);
    } catch (NumberFormatException e) {
        valid = false;
    }
}

if (valid) {
    ReviewDTO dto = new ReviewDTO();
    dto.setUserId(userId);
    dto.setMovieId(movieId);
    dto.setContent(content);
    dto.setRating(rating);

    ReviewDAO reviewDao = ReviewDAO.getInstance();
    int result = reviewDao.insertReview(dto);

     if (result > 0) { %>
    <script>
        alert("리뷰 등록에 성공했습니다.");
        location.href = "<%=request.getContextPath()%>/index.jsp?main=movie/movieDetail.jsp&id=<%=movieId%>&name=<%=movieName%>";
    </script>
 <% }%>


<%
    
} else {
%>

<script>
alert("리뷰 등록에 실패했습니다.");
  history.back();
</script>
<%
}
%>
