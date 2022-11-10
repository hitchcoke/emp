<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertBoardForm</title>
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		textarea {
			width: 100%;
			height: 200px;
			padding: 10px;
			box-sizing: border-box;
			border: solid 2px gray;
			border-radius: 5px;
			font-size: 16px;
			resize: both;
		}
	</style>
</head>
<body>

<br>
	<div>
		<jsp:include page="../menu.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div>

<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">글 추가</h1>
	<br>
	<br>
	<form action="<%=request.getContextPath()%>/board/insertBoardAction.jsp" method="post">
		<div class="container">
		<label for="exampleFormControlInput1" class="form-label">&nbsp;제목</label>
  			<input type="text" class="form-control" name="boardTitle"><!-- plaecholder로 들어갈 부서넘버의 예시를 알려준다 -->
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;작성자</label>
  			<input type="text" class="form-control" name="boardWrite">
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;비밀번호</label>
  			<input type="password" class="form-control" name="boardPw"><!-- plaecholder로 들어갈 부서넘버의 예시를 알려준다 -->
  		<label for="exampleFormControlInput1" >&nbsp;내용</label>
  			<textarea name="boardContent"></textarea>
		<div class="d-grid gap-2 mt-5">
			<button type="submit" class="btn btn-outline-primary">추가</button>
		</div>
		</div>
	</form>
	<%
		if(request.getParameter("msg")!=null){
	%>
		<div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
	<% 			
		}
	%>
	
</body>
</html>