# 	:clapper: moviezzang😁



![header](https://capsule-render.vercel.app/api?type=venom&color=0:8871e5,100:b678c4&height=300&section=header&text=MOVIEZZANG&fontSize=90)


📽️MOVIEZZANG📽️   

# MOVIEZZANG 🎬  
AJAX 기반 **영화 예매 웹앱(JSP Model-1)** — 페이지 이동 없이 날짜→지역→영화→극장→상영관→시간을 필터링하고, **연속좌석·짝수 기준·호버 미리보기**로 실수 없는 좌석 선택 UX를 제공합니다.

**TL;DR**
- 한 페이지 **AJAX 예매 플로우** (체감 빠른 조회/선택)
- **좌석 선택 알고리즘**: 2인 이상 연속 좌석, 기준좌석 짝수 정렬, 홀수 인원 처리, 호버 미리보기
- **Admin 모듈**: 영화/극장/상영 편성/회원 관리
- **TMDb 연동**(키 외부화), **MySQL + Tomcat 9+**, **JSP/JSTL + jQuery**

**스크린샷/GIF**
> `documents/screenshots/`에 `flow.gif`와 주요 화면 캡처를 추가하고 아래에 삽입하세요.  
> 예) ![예매 흐름 데모](documents/screenshots/flow.gif)

**빠른 실행**
```bash
# MySQL
CREATE DATABASE moviezzang DEFAULT CHARACTER SET utf8mb4;

# 앱 설정 (샘플 복사 후 값 채우기)
cp src/main/resources/db.properties.sample src/main/resources/db.properties
# Tomcat 9+에 배포 후 Run on Server

   
