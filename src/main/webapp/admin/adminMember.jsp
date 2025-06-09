<%@page import="data.dto.UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.mAdminId {
		width: 60px;
	}
	
	.mAdminAge{
		width: 90px;
	}
	
	.mAdminGender {
		width: 80px;
	}
	
	.mAdminMileage {
		width: 100px;
	}
</style>
<%
	UserDAO dao = UserDAO.getInstance();
	List<UserDTO> list = dao.getAllMembers();
%>
<div class="container-fluid px-0">
    <h2 class="mb-4 table-title">회원 목록</h2>
    <div class="table-responsive rounded-4 shadow-sm">
        <table id="tableContainer" class="table align-middle mb-0 table-hover text-center" style="background:#fff;">
            <thead class="table-light" style="background:#eaf0fa;">
                <tr>
                    <th>번호</th>
                    <th>아이디</th>
                    <th>비밀번호</th>
                    <th>이름</th>
                    <th>성별</th>
                    <th>나이</th>
                    <th>연락처</th>
                    <th>주소</th>
                    <th>마일리지</th>
                    <th>구분</th>
                    <th>가입일</th>
                    <th>이메일</th>
                    <th>생년월일</th>
                </tr>
            </thead>
            <tbody>
            <%
            	for(UserDTO dto : list)
            	{
            %>
            	<tr>
                    <td class="mAdminId"><span class="mAdminIdValue"><%=dto.getId()%></span></td>
                    <td class="mAdminUserid"><input type="text" class="form-control form-control-sm" value="<%=dto.getUserid()%>" data-old="<%=dto.getUserid()%>" name="userid"></td>
                    <td class="mAdminPassword"><input type="password" class="form-control form-control-sm" value="<%=dto.getPassword()%>" data-old="<%=dto.getPassword()%>" name="password"></td>
                    <td class="mAdminName"><input type="text" class="form-control form-control-sm" value="<%=dto.getName()%>" data-old="<%=dto.getName()%>" name="name"></td>
                    <td class="mAdminGender">
                        <%
                        	String gender = dto.getGender();
                        %>
                        <select class="form-select form-select-sm" data-old="<%=gender%>" name="gender">
                            <option value="F" <%=gender.equals("F") ? "selected" : ""%>>F</option>
                            <option value="M" <%=gender.equals("M") ? "selected" : ""%>>M</option>
                        </select>
                    </td>              
                    <td class="mAdminAge"><input type="number" class="form-control form-control-sm" value="<%=dto.getAge()%>" data-old="<%=dto.getAge()%>" name="age"></td>
                    <td class="mAdminPhone"><input type="text" class="form-control form-control-sm" value="<%=dto.getPhone()%>" data-old="<%=dto.getPhone()%>" name="phone"></td>
                    <td class="mAdminAddress"><input type="text" class="form-control form-control-sm" value="<%=dto.getAddress()%>" data-old="<%=dto.getAddress()%>" name="address"></td>
                    <td class="mAdminMileage"><input type="number" class="form-control form-control-sm" value="<%=dto.getMileage()%>" data-old="<%=dto.getMileage()%>" name="mileage" min="0"></td>
                    <td class="mAdminUsertype">
                        <%
                        	String usertype = dto.getUser_type();
                        %>
                        <select class="form-select form-select-sm" data-old="<%=dto.getUser_type()%>" name="user_type">
                            <option value="USER" <%=usertype.equals("USER") ? "selected" : ""%>>USER</option>
                            <option value="ADMIN" <%=usertype.equals("ADMIN") ? "selected" : ""%>>ADMIN</option>
                        </select>
                    </td>
                    <td class="mAdminRegdate"><input type="text" class="form-control form-control-sm" value="<%=dto.getSignup_at()%>" readonly></td>
                    <td class="mAdminEmail"><input type="email" class="form-control form-control-sm" value="<%=dto.getEmail()%>" data-old="<%=dto.getEmail()%>" name="email"></td>
                    <td class="mAdminBirth"><input type="date" class="form-control form-control-sm" value="<%=dto.getBirth()%>" data-old="<%=dto.getBirth()%>" name="birth"></td>
                </tr>      
            <%
            	}
            %>                    
            </tbody>
        </table>
    </div>
    <div class="text-end mt-3">
        <button id="btnUpdate" type="button" class="btn btn-primary px-4 py-2 rounded-3 shadow-sm">수정</button>
    </div>
</div>

<!-- 스크립트 처리 -->
<script>
	// 데이터가 하나만 바뀌더라도 테이블의 모든 컬럼을 업데이트 하는 것을 방지하기 위함
	// 서버 과부하를 줄이자

	let changedCells = [];

	$("#tableContainer").on("change", "input, select", function(){
		// $변수는 jquery를 사용한 변수다라는 컨벤션	// $없이 cell 이렇게 써도 상관은 없다
		const $cell = $(this);
	    const $td = $cell.closest('td');
	    const row = $cell.closest('tr');
	    const id = row.find('.mAdminIdValue').text().trim();
	    const column = $cell.attr('name');
	    const oldVal = $cell.data('old');
	    const newVal = $cell.val();
	    
	 	// changedCells에 같은 id, 같은 column에 변경사항이 있는지 확인	// 찾은게 없으면 -1을 반환함
	    const idx = changedCells.findIndex(obj => obj.id == id && obj.column == column);
	 	
	 	// column에 변경이 있다면?
	    if(oldVal != newVal) {
	        if(idx > -1) {
	            // 이미 변경한 적이 있다면 값만 갱신하고 배열에 추가하지 않음
	            changedCells[idx].value = newVal;
	        } else {
	            // 없다면 추가
	            changedCells.push({
	                id: id,
	                column: column,
	                value: newVal
	            });
	        }
	    } else {
	        // 만약 값이 다시 원래대로 돌아왔다면, 배열에서 제거
	        if(idx > -1) {
	            changedCells.splice(idx, 1);
	        }
	    }
	 	
	 	console.log(changedCells);
	});
	
	// 수정 버튼 클릭 시
	$("#btnUpdate").click(function() {
	    if(changedCells.length == 0){
	        alert("수정된 내용이 없습니다");
	        return;
	    }
	    
	    $.ajax({
	        url: "./admin/updateUser.jsp",
	        method: "POST",
	        data: { changes: JSON.stringify(changedCells) },
	        success: function(response){
	            alert("수정하였습니다");
	            changedCells = []; // 성공 시 변경 목록 초기화
	        },
	        error: function(){
	            alert("수정 버튼 클릭 오류 발생");
	        }
	    });
	});
</script>