<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>
<%

request.setCharacterEncoding("utf-8");

String boardNo = request.getParameter("boardNo");

if(boardNo==null){
	 String msg =URLEncoder.encode("정상적인 접근이 아닙니다", "utf-8");
	 response.sendRedirect(request.getContextPath()+"/board/boardList.jsp?msg="+msg);
	  return;

}

Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");


int currentPage=1;
int lastPage=0;
final int ROW_PER_PAGE =3;
if(request.getParameter("currentPage")!=null){
	currentPage= Integer.parseInt(request.getParameter("currentPage"));
}
String sql1 = "SELECT COUNT(*) FROM comment WHERE board_no="+boardNo;
PreparedStatement stmt1 = conn.prepareStatement(sql1);
ResultSet rs1 = stmt1.executeQuery();
int count =0;
if(rs1.next()){
	count= rs1.getInt("COUNT(*)");
}

lastPage= count/ ROW_PER_PAGE;

if(count % ROW_PER_PAGE !=0){
	lastPage++;
}//최대값 구하고 페이지 표시값 만치 나눈다 그 후 딱 나눠 떨어지지않으면 한페이지 더 준다

String sql2 = "SELECT * FROM comment WHERE board_no="+boardNo+" ORDER BY create_date DESC Limit "+ROW_PER_PAGE*(currentPage-1)+", "+ROW_PER_PAGE;
PreparedStatement stmt2 = conn.prepareStatement(sql2);//기본 paging 알고리즘 표시값 * (페이지값-1)

ResultSet rs2 = stmt2.executeQuery();


String sql3= "SELECT * FROM board WHERE board_no = "+boardNo;
PreparedStatement stmt3 = conn.prepareStatement(sql3);
ResultSet rs3 = stmt3.executeQuery();



ArrayList<Comment> comment = new ArrayList<Comment>();


while(rs2.next()){
	
	Comment c= new Comment();
	c.commentPw= rs2.getString("comment_pw");
	c.commentContent= rs2.getString("comment_content");
	c.creatDate= rs2.getString("create_date");
	c.commentNo=rs2.getInt("comment_no");
	comment.add(c);
}


Board bo = new Board();

if(rs3.next()){
	

	
	bo.boardTitle= rs3.getString("board_title");
	bo.boardContent= rs3.getString("board_content");
	bo.creatDate= rs3.getString("create_date");
	bo.boardWrite= rs3.getString("board_write");
	
	
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
	
	<textarea id="textarea" readonly="readonly"><%=bo.boardContent%></textarea>
	<br>
	<br>
	<span>&nbsp;&nbsp;&nbsp;</span>
	<button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=boardNo%>&boardWrite=<%=bo.boardWrite%>'">수정</button>
	
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
	<br>
	<table class="table table-bordered align-middle">
			<tr class="mt-4 p-5 bg-primary text-white rounded">
				<th>댓글</th>
				<th colspan="2">작성일자</th>
			</tr>
	<% 
		for(Comment c : comment){	
	%>
				<tr>
					<td><%=c.commentContent%></td>
					<td><%=c.creatDate %></td>
					<td><button type="button" class="btn btn-outline-primary" onclick="location.href='<%=request.getContextPath()%>/board/deleteCommentForm.jsp?boardNo=<%=boardNo%>&commentNo=<%=c.commentNo%>'">삭제</button></td>
				</tr>
	<%} %>
	</table>	
	<br>
	<div>
		<nav aria-label="Page navigation example">
  			<ul class="pagination justify-content-center">
   				
   			<%if(currentPage > 1){%>	
   				<li class="page-item">
   				<% }else{ %>
   				<li class="page-item disabled"><%} %>
      				<a class="page-link" href="<%=request.getContextPath()%>/board/boardOne.jsp?currentPage=<%=currentPage-1%>">Previous</a>
    			</li>
    		<%if(currentPage > 1){%>	
    			<li class="page-item">
    				<a class="page-link" href="<%=request.getContextPath()%>/board/boardOne.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
    		<%} %>
    			<li class="page-item active" aria-current="page">
    				<span class="page-link"><%=currentPage%></span></li>
    		<%if(currentPage < lastPage){%>		
    			<li class="page-item">
    				<a class="page-link" href="<%=request.getContextPath()%>/board/boardOne.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
    		<%}
    		  if(currentPage < lastPage){%>	
    			<li class="page-item">
    		<%}else{ %>
    			<li class="page-item disabled"><%} %>
      		   		<a class="page-link" href="<%=request.getContextPath()%>/board/boardOne.jsp?currentPage=<%=currentPage+1%>">Next</a>
    			</li>
 	   		</ul>
	   </nav>
	   	</div>
	<div>
	<br>
		<h4>댓글입력</h4>
		<form action="<%=request.getContextPath()%>/board/insertCommentAction.jsp" method="post">
			<input type="hidden" name="boardNo" value="<%=boardNo%>">
			<label for="exampleFormControlInput1" >&nbsp;내용</label>
  			<textarea name="commentContent"></textarea>
			<label for="exampleFormControlInput1" class="form-label">&nbsp;비밀번호</label>
  			<input type="password" class="form-control" name="commentPw"><!-- plaecholder로 들어갈 부서넘버의 예시를 알려준다 -->
  			
			<div><button type="submit" class="btn btn-outline-primary">추가</button></div>
		</form>	
	</div>
	
	<%
		if(request.getParameter("msg")!=null){
	%>
		<div class="alert alert-primary" role="alert"><%=request.getParameter("msg")%></div>
	<% 			
		}
	%>
</body>
</html>