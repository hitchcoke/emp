<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>



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
<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">부서추가</h1>
	<br>
	<br>
	<form action="<%=request.getContextPath()%>/dept/insertDeptAction.jsp">
		<div class="container">
		<label for="exampleFormControlInput1" class="form-label">&nbsp;부서번호</label>
  			<input type="text" class="form-control" name="dept_no" placeholder="ex:d011">
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;부서이름</label>
  			<input type="text" class="form-control" name="dept_name">
		<div class="d-grid gap-2 mt-5">
			<button type="submit" class="btn btn-outline-primary">추가</button>
		</div>
		</div>
	</form>
</body>
</html>