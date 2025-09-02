# 🎬 MOVIEZZANG

![header](https://capsule-render.vercel.app/api?type=venom&color=0:8871e5,100:b678c4&height=300&section=header&text=MOVIEZZANG&fontSize=90)

AJAX 기반 **영화 예매 웹앱(JSP Model-1)** — 페이지 이동 없이 **날짜 → 지역 → 영화 → 극장 → 상영관 → 시간**을 필터링하고, **연속좌석·짝수 기준·호버 미리보기**를 포함한 좌석 선택 UX를 제공합니다.

## 요약
- 페이지 이동 없는 **AJAX 예매 플로우**
- **좌석 선택 UX**: 2인 이상 연속 좌석, 기준좌석 짝수 정렬, 홀수 인원 처리, 호버 미리보기
- **리뷰/평점(댓글)**: 등록·수정·삭제, 영화 상세에서 노출
- **영화 추천**: 선택 영화와 **장르 겹침** 기준 상위 5편 추천(평점 순)
- **Admin 모듈**: 영화/극장/상영 편성/회원 관리
- **스택**: JSP/JSTL + jQuery, Java/JDBC, MySQL 8.x, Tomcat 9+  
  <sub>(※ Spring/Spring Boot **미사용**)</sub>

---

## 프로젝트 개요
한 페이지에서 필터를 바꾸면 즉시 상영 정보가 갱신되고, 좌석 선택은 연속성/가독성을 보장하는 규칙을 적용합니다. 관리자 화면에서 영화·극장·상영 편성·회원 관리를 수행하고, TMDB 연동으로 영화 데이터를 불러옵니다.

## 스크린샷/GIF
> `documents/screenshots/`에 캡처나 `flow.gif`를 추가해 아래에 삽입하세요.  
> 예) ![예매 흐름 데모](documents/screenshots/flow.gif)

---

## ✨ 주요 기능
- **멀티-스텝 예매 플로우 (AJAX)**  
  날짜/지역/영화/극장/상영관 선택 → 시간표 로딩 → 좌석 선택 → 예매 확정
- **좌석 선택 UX**  
  - 2인 이상은 **연속 좌석** 2자리 단위 배정  
  - **기준 좌석 짝수 정렬**(예: 2 클릭 → 1·2 / 5 클릭 → 5·6)  
  - **홀수 인원**은 2인씩 우선 배정 후 남는 1석 처리  
  - **Hover 미리보기**로 실제 선택 범위 표시
- **리뷰/평점(댓글)**  
  - `ReviewDAO`/`ReviewDTO`, `movie/insertReview.jsp`, `updateReview.jsp`, `deleteReview.jsp`  
  - rating + content 등록/수정/삭제, `movieDetail.jsp`에서 노출
- **영화 추천**  
  - `MovieDAO.getRecommends(id)` — 현재 영화의 **장르**를 `,`로 분해 → 유사 장르 영화 **상위 5편**을 **평점(score)** 내림차순으로 추천  
  - `movie/movieDetail.jsp` 하단에 포스터/제목으로 표시
- **관리자(Admin)**  
  - `adminMain.jsp` 중심, `adminMember.jsp`, `adminTheater.jsp`, `adminScreening.jsp` 등 CRUD 화면

---

## 🧱 기술 스택
- **Front**: JSP, JSTL, CSS, JavaScript(jQuery/AJAX)  
- **Back**: Java(서블릿/JSP), JDBC, DAO/DTO  
- **DB**: MySQL 8.x (`com.mysql.cj.jdbc.Driver`)  
- **Server**: Apache Tomcat 9+ (Eclipse Dynamic Web Project)  
- **Framework**: 없음 (Spring/Spring Boot 미사용)

---

## 📁 폴더 구조 (요약)
src/
├─ main/
│ ├─ java/
│ │ ├─ data/api/ # TMDB 연동
│ │ ├─ data/dao/ # AuditoriumDAO, MovieDAO, ReservationDAO, ReviewDAO, ScreeningDAO, SeatDAO, TheaterDAO, UserDAO
│ │ ├─ data/dto/ # AuditoriumDTO, MovieDTO, ReservationDTO, ReviewDTO, ScreeningDTO, SeatDTO, TheaterDTO, UserDTO
│ │ └─ mysql/db/ # DBConnect.java (설정 파일로 주입 권장)
│ └─ webapp/
│ ├─ admin/ # 관리자 화면
│ ├─ book/ # booking/ seat/ payment/ 하위 예매·결제
│ ├─ layout/ # 공통 레이아웃
│ ├─ member/ # 마이페이지 등
│ └─ movie/ # 목록/검색/상세/리뷰

pgsql
코드 복사

---

## 🚀 빠른 실행
**요구사항**: JDK 11+, Tomcat 9+, MySQL 8.x, Eclipse(또는 호환 IDE)

```bash
# 1) DB 생성
CREATE DATABASE moviezzang DEFAULT CHARACTER SET utf8mb4;

# 2) (선택) 개발용 사용자
CREATE USER 'movie'@'%' IDENTIFIED BY 'moviepw';
GRANT ALL PRIVILEGES ON moviezzang.* TO 'movie'@'%';
FLUSH PRIVILEGES;

# 3) 설정 샘플 복사 후 값 채우기
cp src/main/resources/db.properties.sample src/main/resources/db.properties
# (TMDB 키를 쓰는 경우) 환경변수 TMDB_API_KEY 또는 tmdb.properties 사용

# 4) Tomcat 9+에 배치 후 Run on Server
스키마 SQL이 별도로 없다면 DAO 코드의 컬럼을 참고해 테이블 DDL을 구성하세요.

⚙️ 설정 (개발자용 참고)
DB 연결: src/main/resources/db.properties (샘플: db.properties.sample)
실제 비밀번호가 담긴 파일은 버전관리 대상이 아닙니다(.gitignore 권장).

TMDB API 키: 환경변수 TMDB_API_KEY 또는 src/main/resources/tmdb.properties로 주입

설치/키 관리 상세 안내가 필요하면 docs/SETUP.md, SECURITY.md로 분리해 관리할 수 있습니다.

🔀 예매 흐름 (AJAX 예시)
프런트는 JSP 내 jQuery로 단계별 요청을 보내고, 서버 JSP가 JSON/HTML 조각을 응답합니다.

javascript
코드 복사
// 상영 목록(지역별 극장 카운트)
$.ajax({
  type: "get",
  url: "<%=request.getContextPath()%>/book/booking/bookList.jsp",
  dataType: "json",
  data: { movie_id: currentMovie_id, screening_date: selectedDate }
});

// 지역별 극장 목록
$.ajax({
  type: "get",
  url: "<%=request.getContextPath()%>/book/booking/theaterList.jsp",
  dataType: "json",
  data: { movie_id: currentMovie_id, region: region, screening_date: selectedDate }
});

// 상영 시간표
$.ajax({
  type: "get",
  url: "<%=request.getContextPath()%>/book/booking/showTimes.jsp",
  dataType: "json",
  data: { movie_id: currentMovie_id, region: region, screening_date: selectedDate }
});

// 좌석 확정 + 결제
$.ajax({
  type: "post",
  url: "<%=request.getContextPath()%>/book/payment/payReservationAction.jsp",
  data: { screening_id, seatIds: seatIds.join(","), total: totalInwon }
});
🪑 좌석 선택 규칙
인원수 ≥ 2 → 연속 좌석 2자리 단위 배정

짝수 기준 좌석(2→1·2 / 5→5·6)

홀수 인원은 2인씩 우선 배정 후 남는 1석 처리

호버 시 실제 선택 범위 미리보기

행 경계/점유 좌석, 동시성(중복 예약 방지)은 서버-사이드 검증과 함께 처리

🎯 영화 추천 로직
DAO: data/dao/MovieDAO.java → getRecommends(String id)

원리: 현재 영화의 장르를 ,로 분해 → 해당 장르를 포함하는 다른 영화를 검색 → 평점(score) 내림차순 상위 5편

표시 위치: movie/movieDetail.jsp 하단 추천 섹션(포스터/제목)

SQL 요약: m1(선택 영화) & m2(다른 영화) 조인 → m2.genre LIKE 조건으로 장르 겹침 → ORDER BY m2.score DESC LIMIT 5

로드맵
(선택) 즐겨찾기/찜: favorite(user_id, movie_id) 테이블 + 토글 엔드포인트

좌석 임시 홀드(타임아웃) 및 동시성 제어

상영 시간표 캐싱/쿼리 최적화 + 인덱스 설계

관리자 UI 개선(접근 권한/감사 로그)

테스트 보강(JUnit/통합 테스트), 예외/에러 핸들링 정교화
