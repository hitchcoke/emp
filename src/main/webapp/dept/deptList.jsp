<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>


<%
//1.요청분석(controller)
//2.업무처리 (model)
Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");

/* PreparedStatement stmt = conn.prepareStatement
("select dept_no, dept_name from departments"); */

String sql = "SELECT dept_no deptNo, dept_name deptName FROM departments ORDER BY dept_no ASC"; //order by ...asc 로 내림차순으로 변경
PreparedStatement stmt = conn.prepareStatement(sql);//Department class 와 name 동일화

ResultSet rs = stmt.executeQuery();//배열 형태가아닌 db형태 java화 되있지 않다

//3.출력(view) 나중되면 3개를 분리해서 작동시킨다(MVC)

ArrayList<Department> dept = new ArrayList<Department>();
//db형태를 배열화 한다
while(rs.next()){
	
	Department d = new Department();
	d.deptNo=rs.getString("deptNo");
	d.deptName= rs.getString("deptName");
	dept.add(d);
	
}


//db 테이블과 같은 클래스(vo,도메인)는 만들어야 한다

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deptList</title>
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		a:link {
		  color : blue;
		  text-decoration: none;
		}
		a:visited {
		  color : blue;
		  text-decoration: none;
		}
		a:hover {
		  color : white;
		  text-decoration: none;
		}
		a:active {
		  color : white;
		  text-decoration: none;
		}
	</style>
	
</head>
<body>
	<br>
	<div>
		<jsp:include page="../menu.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div>
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">부서관리</h1>
	
	<div class=".container-fluid"></div>
	<div>
		<table class="table table-bordered align-middle">		
				<tr class="mt-4 p-5 bg-primary text-white rounded">
					<th>부서번호</th>
					<th colspan="3">부서이름</th>
				</tr>	
				<%
					for(Department d : dept ){
				%>		
					<tr>
						<td>
							<%=d.deptNo%>
						</td>
						
						<td><%=d.deptName%></td>
						<td>
							<a href="<%=request.getContextPath()%>/dept/updateDeptForm.jsp?deptNo=<%=d.deptNo%>" class="btn btn-outline-primary">
							수정
							</a>
						</td>								
						<td>
							<a href="<%=request.getContextPath()%>/dept/deleteDept.jsp?deptNo=<%=d.deptNo%>" class="btn btn-outline-primary">
							삭제
							</a>
						</td>
					</tr>
				<%
					}
				%>	
		 </table>
	</div>	 
	
</body>
</html>