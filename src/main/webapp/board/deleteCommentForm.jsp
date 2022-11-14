<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");

	int boardNo=Integer.parseInt(request.getParameter("boardNo"));
	int commentNo=Integer.parseInt(request.getParameter("commentNo"));
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<title>deleteCommentForm</title>
</head>
<body>
	<br>
	<div>
		<jsp:include page="../menu.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div>
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">댓글 삭제</h1>
	<br>
	<label for="exampleFormControlInput1" class="form-label">&nbsp;&nbsp;&nbsp;비밀번호</label>
	<br>
	<form action="<%=request.getContextPath()%>/board/deleteCommentAction.jsp" method="post">
		<input type="hidden" name="boardNo" value="<%=boardNo%>">
		<input type="hidden" name="commentNo" value="<%=commentNo%>">
		<input type="password" name="commentPw" class="form-control">
		<br>
		&nbsp;&nbsp;&nbsp;<button type="submit" class="btn btn-outline-primary">확인</button>
	</form>
</body>
</html>