<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>

<%

request.setCharacterEncoding("utf-8");
String boardNo = request.getParameter("boardNo");

Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");


String sql1= "SELECT * FROM board WHERE board_no = "+boardNo;
PreparedStatement stmt1 = conn.prepareStatement(sql1);
ResultSet rs1 = stmt1.executeQuery();

Board bo = new Board();

if(rs1.next()){
	

	
	bo.boardTitle= rs1.getString("board_title");
	bo.boardContent= rs1.getString("board_content");
	bo.creatDate= rs1.getString("create_date");
	bo.boardWrite= rs1.getString("board_write");
	
	
}



%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	
<title>boardOne</title>
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
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">게시판</h1>
	<table class="table table-bordered align-middle">
		<tr>
			<th>제목</th>
			<td><%=bo.boardTitle%></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=bo.boardWrite%></td>
		</tr><tr>
			<th>작성일자</th>
			<td><%=bo.creatDate%></td>
		</tr>
	</table>
	
	<textarea readonly="readonly"><%=bo.boardContent%></textarea>
	<br>
	<br>
	<span>&nbsp;&nbsp;&nbsp;</span>
	<button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=boardNo%>'">수정</button>
	
	<span>&nbsp;&nbsp;&nbsp;</span>
  	<a class="btn btn-outline-primary btn-lg" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    삭제
  	</a>
	<form action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp">
		<div class="collapse" id="collapseExample">
		<br>
  		<input type="hidden" name="boardNo" value="<%=boardNo%>">
  		<div class="card card-body">
  		비밀번호를 입력해주세요 &nbsp; <input type="password" name="boardPw">
  		<br>
  		<button type="submit" class="btn btn-outline-primary btn-lg" >확인</button>
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