<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>


<%
	int lastPage=0;
	int currentPage= 1;
	int rowPerPage=10;
	
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	
	String sql1 = "SELECT COUNT(*) FROM employees";
	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	ResultSet rs1 = stmt1.executeQuery();
	int count =0;
	if(rs1.next()){
		count= rs1.getInt("COUNT(*)");
	}
	
	lastPage= count/ rowPerPage;
	if(count % rowPerPage !=0){
		lastPage++;
	}//최대값 구하고 페이지 표시값 만치 나눈다 그 후 딱 나눠 떨어지지않으면 한페이지 더 준다
	
	String sql2 = "SELECT * FROM employees ORDER BY emp_no ASC Limit "+rowPerPage*(currentPage-1)+", "+rowPerPage;
	PreparedStatement stmt2 = conn.prepareStatement(sql2);//기본 paging 알고리즘 표시값 * (페이지값-1)
	
	ResultSet rs2 = stmt2.executeQuery();
	
	

	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>empList</title>
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">	
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<br>
		<div>
			<jsp:include page="../menu.jsp"></jsp:include> 
			<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
		</div>
		<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">사원관리</h1>
		<table class="table table-bordered align-middle">
			<tr class="mt-4 p-5 bg-primary text-white rounded">
				<th>생년월일</th>
				<th>성</th>
				<th>이름</th>
				<th>성별</th>
				<th colspan="3">입사일자</th>
			</tr>
			<%
			while(rs2.next()){
			%>
				<tr>
					<td><%=rs2.getString("birth_date")%></td>
					<td><%=rs2.getString("first_name")%></td>
					<td><%=rs2.getString("last_name")%></td>
					<td><%=rs2.getString("gender")%></td>
					<td><%=rs2.getString("hire_date")%></td>
					<td><a href="<%=request.getContextPath()%>/emp/updateEmpForm.jsp?empNo=<%=rs2.getInt("emp_no")%>" class="btn btn-outline-primary">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/emp/deleteEmp.jsp?empNo=<%=rs2.getInt("emp_no")%>" class="btn btn-outline-primary">삭제</a></td>
				</tr>
			<%
			}
			%>	
		</table>
		<br>
		<h6>&nbsp;&nbsp;현재페이지: <%=currentPage%></h6>
		<br>
		<div>
		<%
		if(currentPage >1){
		%>	
			<span>&nbsp;&nbsp;&nbsp;</span>
			<button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage-1%>'">이전</button>
			
		<%
		}
		if(currentPage < lastPage){
		%>
			<span>&nbsp;&nbsp;&nbsp;</span>
			<button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage+1%>'">다음</button>
		<%
		}
		%>
		<span>&nbsp;&nbsp;&nbsp;</span>
		<button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/emp/empList.jsp?currentPage=1'">처음으로</button>
		<span>&nbsp;&nbsp;&nbsp;</span>
		<button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=lastPage%>'">끝으로</button>
		</div>
	</body>
</html>