<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String deptNo= request.getParameter("deptNo");
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	String sql = "select dept_no, dept_name from departments where dept_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, deptNo);
	
	ResultSet rs = stmt.executeQuery();
	String deptName=null;
	
	
	if(rs.next()){
		deptName=rs.getString("dept_name");
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
<br>
<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">부서수정</h1>
	<br>
	<br>
	<form action="<%=request.getContextPath()%>/dept/updateDeptAction.jsp">
		<div class="container">
		<label for="exampleFormControlInput1" class="form-label" >&nbsp;전부서번호</label>
  			<input type="text" class="form-control" name="deptNo" readonly="readonly" value="<%=deptNo%>" placeholder="ex:d011">
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;부서이름</label>
  			<input type="text" class="form-control" name="deptName" value="<%=deptName%>" >
		<div class="d-grid gap-2 mt-5">
			<button type="submit" class="btn btn-outline-primary">수정</button>
		</div>
		</div>
	</form>
</body>
</html>