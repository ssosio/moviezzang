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
        <table class="table align-middle mb-0 table-hover text-center" style="background:#fff;">
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
                    <td class="mAdminId"><%=dto.getId()%></td>
                    <td class="mAdminUserid"><input type="text" class="form-control form-control-sm" value="<%=dto.getUserid()%>"></td>
                    <td class="mAdminPassword"><input type="password" class="form-control form-control-sm" value="<%=dto.getPassword()%>"></td>
                    <td class="mAdminName"><input type="text" class="form-control form-control-sm" value="<%=dto.getName()%>"></td>
                    <td class="mAdminGender">
                        <select class="form-select form-select-sm">
                        <%
                        	String gender = dto.getGender();
                        %>
                            <option value="F" <%=gender.equals("F") ? "selected" : ""%>>F</option>
                            <option value="M" <%=gender.equals("M") ? "selected" : ""%>>M</option>
                        </select>
                    </td>
                    <td class="mAdminAge"><input type="number" class="form-control form-control-sm" value="<%=dto.getAge()%>"></td>
                    <td class="mAdminPhone"><input type="text" class="form-control form-control-sm" value="<%=dto.getPhone()%>"></td>
                    <td class="mAdminAddress"><input type="text" class="form-control form-control-sm" value="<%=dto.getAddress()%>"></td>
                    <td class="mAdminMileage"><input type="number" class="form-control form-control-sm" value="<%=dto.getMileage()%>" min="0"></td>
                    <td class="mAdminUsertype">
                        <select class="form-select form-select-sm">
                        <%
                        	String usertype = dto.getUser_type();
                        %>
                            <option value="USER" <%=usertype.equals("USER") ? "selected" : ""%>>USER</option>
                            <option value="ADMIN" <%=usertype.equals("ADMIN") ? "selected" : ""%>>ADMIN</option>
                        </select>
                    </td>
                    <td class="mAdminRegdate"><input type="text" class="form-control form-control-sm" value="<%=dto.getSignup_at()%>" readonly></td>
                    <td class="mAdminEmail"><input type="email" class="form-control form-control-sm" value="<%=dto.getEmail()%>"></td>
                    <td class="mAdminBirth"><input type="date" class="form-control form-control-sm" value="<%=dto.getBirth()%>"></td>
                </tr>      
            <%
            	}
            %>                    
            </tbody>
        </table>
    </div>
    <div class="text-end mt-3">
        <button type="button" class="btn btn-primary px-4 py-2 rounded-3 shadow-sm">수정</button>
    </div>
</div>
