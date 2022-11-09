<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertEmpForm</title>
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

<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">사원추가</h1>
	<br>
	<br>
	<form action="<%=request.getContextPath()%>/emp/insertEmpAction.jsp">
		<div class="container">
		<label for="exampleFormControlInput1" class="form-label">&nbsp;생일</label>
  			<input type="date" class="form-control" name="birthDate">
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;성</label>
  			<input type="text" class="form-control" name="firstName">
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;이름</label>
  			<input type="text" class="form-control" name="lastName" >
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;성별</label>&nbsp;
  			<input type="radio" name="gender" value="F">여&nbsp;
  			<input type="radio" name="gender" value="M">남
  		<br>
  		<label for="exampleFormControlInput1" class="form-label">&nbsp;입사일자</label>
  			<input type="date" class="form-control" name="hireDate">
		<div class="d-grid gap-2 mt-5">
			<button type="submit" class="btn btn-outline-primary">추가</button>
		</div>
		</div>
	</form>
	<br>
	<%
		if(request.getParameter("msg")!=null){
	%>
		<div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
	<% 			
		}
	%>
	
	
</body>
</html>