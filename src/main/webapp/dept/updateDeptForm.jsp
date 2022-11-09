<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String deptNo= request.getParameter("deptNo");
	
	if(deptNo==null){
		
		response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
	}		//updateDeptForm를 바로 접속해 deptno의 정보가 없을시 deptlist로 보내는 식
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	String sql = "select dept_no, dept_name from departments where dept_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, deptNo);
	//dept_no deptlist에서 받아온 정보 사용
	ResultSet rs = stmt.executeQuery();
	String deptName=null;
	
	
	
	if(rs.next()){
		deptName=rs.getString("dept_name");//placeholder의 사용할 deptName 를 가져온다
	}
	

 %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateDeptForm</title>
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

<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">부서수정</h1>
	<br>
	<br>
	<form action="<%=request.getContextPath()%>/dept/updateDeptAction.jsp">
		<div class="container">
		<label for="exampleFormControlInput1" class="form-label" >&nbsp;부서번호</label>
  			<input type="text" class="form-control" name="deptNo" readonly="readonly" value="<%=deptNo%>">
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;부서이름</label>
  			<input type="text" class="form-control" name="deptName" placeholder="<%=deptName%>" >
		<div class="d-grid gap-2 mt-5">
			<button type="submit" class="btn btn-outline-primary">수정</button>
		</div>
		</div>
	</form>
	
</body>
</html>