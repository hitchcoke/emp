<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
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
	<br>
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">목차</h1>
	<br><br>
	<h4>
		<span>&nbsp;&nbsp;&nbsp;</span><button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/dept/deptList.jsp;'">부서관리</button>
		<span>&nbsp;&nbsp;&nbsp;</span><button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/emp/empList.jsp;'">사원목록</button>
		<span>&nbsp;&nbsp;&nbsp;</span><button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/board/boardList.jsp;'">게시판관리</button>
		
	</h4>
	
</body>
</html>