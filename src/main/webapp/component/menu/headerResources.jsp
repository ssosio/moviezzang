
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!--테일윈드 css 기본설정/커스텀  -->
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<script>
  tailwind.config = {
    theme: {
      extend: {
        colors: { primary: "#352461", secondary: "#503396" },
        borderRadius: {
          button: "8px",
          full: "9999px"
        },
      },
    },
  };
</script>
  <!-- 글꼴 -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
  href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
  rel="stylesheet"
/>
<link
  href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
  rel="stylesheet"
/>

<!--icon -->

<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css"
/>
<!-- 차트와 그래프 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>

<script>

/*해더 자동숨기기 */
  document.addEventListener("DOMContentLoaded", function () {
    const header = document.querySelector("header");
    let lastScrollY = window.scrollY;

    if (header) {
      window.addEventListener("scroll", () => {
        if (window.scrollY > lastScrollY) {
          header.style.transform = "translateY(-100%)";
        } else {
          header.style.transform = "translateY(0)";
        }
        header.style.transition = "transform 0.3s ease-in-out";
        lastScrollY = window.scrollY;
      });
    }
/*최상단으로 올리는 버튼  */
    const topBtn = document.getElementById("topBtn");
    if (topBtn) {
      topBtn.addEventListener("click", function () {
        window.scrollTo({ top: 0, behavior: "smooth" });
      });
    }
  });
</script>