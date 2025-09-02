# 🎬 MOVIEZZANG

![header](https://capsule-render.vercel.app/api?type=venom&color=0:8871e5,100:b678c4&height=300&section=header&text=MOVIEZZANG&fontSize=90)

AJAX 기반 **영화 예매 웹앱(JSP Model-1)** — 페이지 이동 없이 **날짜 → 지역 → 영화 → 극장 → 상영관 → 시간**을 필터링하고,
**연속좌석·짝수 기준·호버 미리보기**로 실수 없는 좌석 선택 UX를 제공합니다.

## 요약
- 한 페이지 **AJAX 예매 플로우** (체감 빠른 조회/선택)
- **좌석 선택 알고리즘**: 2인 이상 연속 좌석, 기준좌석 짝수 정렬, 홀수 인원 처리, 호버 미리보기
- **리뷰/평점(댓글)**: 등록·수정·삭제, 영화 상세에서 노출
- **Admin 모듈**: 영화/극장/상영 편성/회원 관리
- **TMDb 연동**(키 외부화), **MySQL 8.x + Tomcat 9+**, **JSP/JSTL + jQuery**


## 스크린샷/GIF
> `documents/screenshots/`에 `flow.gif`와 주요 화면 캡처를 추가하고 아래에 삽입하세요.  
> 예) ![예매 흐름 데모](documents/screenshots/flow.gif)

## 빠른 실행

```bash
# MySQL
CREATE DATABASE moviezzang DEFAULT CHARACTER SET utf8mb4;

# 앱 설정 (샘플 복사 후 값 채우기)
cp src/main/resources/db.properties.sample src/main/resources/db.properties

# Tomcat 9+에 배포 후 Run on Server




# MOVIEZZANG 🎬

**영화 예매 웹 애플리케이션 (JSP Model‑1)**
한 페이지 내에서 **날짜 → 지역 → 영화 → 극장 → 상영관 → 시간** 순으로 AJAX 비동기 필터링을 수행하고, 사용자 실수를 줄이기 위한 **좌석 선택 UX**(연속 좌석 보장, 짝수 기준, 호버 미리보기)를 제공합니다.
또한 **관리자(Admin)** 모듈에서 영화/극장/상영 편성/회원 관리 기능을 제공합니다.

> 이 README는 실제 저장소(zip) 구조를 스캔해 구성했습니다. (JSP 48개, Java 20개, DAO 8, DTO 8, 이미지 12)

---

## ✨ 주요 기능

* **멀티‑스텝 예매 플로우 (AJAX)**: 날짜/지역/영화/극장/상영관 선택 → 상영시간표 로딩 → 좌석 선택 → 예매 확정
* **좌석 선택 UX**

  * 2인 이상은 **연속 좌석**이 되도록 2자리 단위 배정
  * **기준 좌석은 짝수 번호**(예: 2 클릭 → 1,2 / 5 클릭 → 5,6)로 정렬
  * **홀수 인원**이면 2인씩 우선 배정 후 남는 1석 처리
  * **Hover 미리보기**로 실제 선택 범위 즉시 시각화
* **리뷰/평점(댓글)**

  * `ReviewDAO`/`ReviewDTO` + `movie/insertReview.jsp`, `updateReview.jsp`, `deleteReview.jsp` 구성
  * 평점(rating)과 내용(content) 등록/수정/삭제, 영화 상세(`movieDetail.jsp`)에서 노출
* **관리자(Admin)**: `adminMain.jsp`를 중심으로 회원/극장/상영 편성 CRUD 및 관련 보조 JSP (`adminMember.jsp`, `adminTheater.jsp`, `adminScreening.jsp` 등)
* **TMDB 연동**: `src/main/java/data/api/TMDB.java`에서 영화 데이터 API 호출(※ API Key는 코드 외부화 권장)

> 참고: 코드 베이스에서 **즐겨찾기(찜)** 관련 DAO/JSP는 확인되지 않았습니다. (원하면 스키마/DAO/JSP 추가 설계안 제공 가능)

## 🧱 기술 스택

* **Front**: JSP, JSTL, CSS, JavaScript(jQuery/AJAX)
* **Back**: Java, Servlet/JSP, JDBC, DAO/DTO
* **DB**: MySQL 8.x (JDBC 드라이버 `com.mysql.cj.jdbc.Driver`)
* **Server**: Apache Tomcat 9+ (Eclipse Dynamic Web Project 구조)

---

## 📁 폴더 구조(요약)

### `src/main/webapp/` (일부, 깊이 ≤ 3)

```
[src/main/webapp/ 트리 미리보기는 다운로드 파일 참조]
```

### `src/main/java/` (일부, 깊이 ≤ 3)

```
[src/main/java/ 트리 미리보기는 다운로드 파일 참조]
```

> DAO/DTO:
>
> * DAO: `data/dao/` (AuditoriumDAO, MovieDAO, ReservationDAO, ReviewDAO, ScreeningDAO, SeatDAO, TheaterDAO, UserDAO)
> * DTO: `data/dto/` (AuditoriumDTO, MovieDTO, ReservationDTO, ReviewDTO, ScreeningDTO, SeatDTO, TheaterDTO, UserDTO)
> * DB 연결: `mysql/db/DBConnect.java` (→ **환경 파일로 외부화 권장**)

---

## 🚀 빠른 시작

### 1) 요구사항

* JDK 11 이상
* Apache Tomcat 9 이상
* MySQL 8.x
* IDE: Eclipse (Dynamic Web Project) 권장

### 2) 데이터베이스

MySQL에서 스키마 생성 후 계정/권한을 부여합니다.

```sql
CREATE DATABASE moviezzang DEFAULT CHARACTER SET utf8mb4;
CREATE USER 'movie'@'%' IDENTIFIED BY 'moviepw';
GRANT ALL PRIVILEGES ON moviezzang.* TO 'movie'@'%';
FLUSH PRIVILEGES;
```

> **스키마/샘플 데이터**: 프로젝트에 SQL 파일이 포함되어 있지 않아, 실제 테이블 생성 DDL은 DAO 조회/삽입 컬럼을 참고해 구성하거나 별도 제공 SQL을 적용하세요.

### 3) DB 연결 설정 (보안 권장안)

현재는 `mysql/db/DBConnect.java`에서 JDBC URL/Driver를 직접 사용합니다.
운영/공개 시에는 **코드 하드코딩을 지양**하고 다음처럼 외부화하세요.

* `src/main/resources/db.properties.sample` (새로 추가 권장)

  ```properties
  db.driver=com.mysql.cj.jdbc.Driver
  db.url=jdbc:mysql://localhost:3306/moviezzang?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul
  db.username=movie
  db.password=moviepw
  ```
* `DBConnect.java`에서 위 파일을 읽어 `DriverManager.getConnection(..)`에 적용
* 실제 비밀번호가 담긴 `db.properties`는 **커밋 금지** (`.gitignore`)

### 4) TMDB API Key 외부화 (중요)

* `src/main/java/data/api/TMDB.java`에 **API Key 리터럴이 존재**합니다.
  → `tmdb.properties` 또는 환경변수로 분리하고, 코드에서는 `System.getenv` 또는 `Properties`로 읽어 사용하세요.
  → 이미 노출된 키는 **키 회전(Rotate)** 하는 것을 권장합니다.

### 5) 실행

1. Eclipse에서 **Import > Existing Projects into Workspace**
2. Project Facets에서 **Dynamic Web Module**, **Java 11+** 확인
3. MySQL JDBC 드라이버를 프로젝트/서버에 추가
4. Tomcat 9+에 배치 후 **Run on Server**

---

## 🔀 예매 플로우 & AJAX 인터페이스 (개요)

프론트는 JSP 내 jQuery로 단계별 AJAX 요청 → 서버 JSP가 JSON 또는 HTML 조각을 반환합니다.
프로젝트 내에는 `get*`, `insert*`, `update*`, `delete*` 등 다수의 AJAX 목적 JSP가 포함되어 있습니다.
예: `admin/getAuditorium.jsp`, `admin/insertTheater.jsp`, `movie/insertReview.jsp`, `movie/updateReview.jsp` 등.

```javascript
// 상영 목록(지역별 극장 카운트)
$.ajax({
  type: "get",
  url: "<%=request.getContextPath()%>/book/booking/bookList.jsp",
  dataType: "json",
  data: { movie_id: currentMovie_id, screening_date: selectedDate },
  success: function(res) {
    // 지역별 극장 수로 버튼 상태/배지 업데이트
  },
  error: function(err) { console.error("bookList 실패:", err); }
});

// 지역 선택 시 해당 지역의 극장 목록
$.ajax({
  type: "get",
  url: "<%=request.getContextPath()%>/book/booking/theaterList.jsp",
  dataType: "json",
  data: { movie_id: currentMovie_id, region: region, screening_date: selectedDate },
  success: function(list) { /* 극장 목록 렌더링 */ },
  error: function(err) { console.error("theaterList 실패:", err); }
});

// 극장/상영관 선택 후 상영 시간표
$.ajax({
  type: "get",
  url: "<%=request.getContextPath()%>/book/booking/showTimes.jsp",
  dataType: "json",
  data: { movie_id: currentMovie_id, region: region, screening_date: selectedDate },
  success: function(times) { /* 시간표 렌더링 */ },
  error: function(err) { console.error("showTimes 실패:", err); }
});

// 좌석 확정 및 결제 액션
$.ajax({
  type: "post",
  url: "<%=request.getContextPath()%>/book/payment/payReservationAction.jsp",
  data: { screening_id, seatIds: seatIds.join(","), total: totalInwon },
  success: function(res) { /* 성공 처리 */ },
  error: function() { Swal.fire("오류", "예매 중 오류가 발생했습니다.", "error"); }
});
```

---

## 🪑 좌석 선택 알고리즘(요약)

* 인원수 ≥ 2 → **연속 좌석** 2자리 단위 배정
* **짝수 기준 좌석** 강제(2→1,2 / 5→5,6)
* **홀수 인원**은 2인씩 먼저 배정 후 1석 처리
* **Hover 미리보기**로 실제 선택 범위 시각화

> 행 경계/점유 좌석 체크, 동시성(중복 예약 방지) 등은 서버‑사이드 검증과 함께 구현해야 합니다.

---

## ✅ 체크리스트 (공개/운영 전)

* `DBConnect.java`의 JDBC URL/계정 **외부화** 및 **비밀 커밋 금지**
* `TMDB.java`의 API Key **외부화** 및 **노출 시 키 회전**
* `build/`, IDE 메타, 드라이버 JAR 등 **산출물/환경파일 정리**
* 크로스 브라우저 테스트: 좌석 호버/미리보기와 단계 필터 정상 확인

---

## 📌 향후 개선

* 좌석 임시 홀드(타임아웃) 및 동시성 제어 강화
* 상영 시간표 캐싱 및 쿼리 최적화
* 관리자 화면 UI/권한 분리(로그/감사 포함)
* Spring MVC/Boot 마이그레이션 + JUnit 단위/통합 테스트

---

## 🙌 기여

학습/포트폴리오 목적의 프로젝트입니다. 이슈/PR 환영합니다.
