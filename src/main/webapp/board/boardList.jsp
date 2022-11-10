<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>


<%
request.setCharacterEncoding("utf-8");

int currentPage=1;
int lastPage=0;
final int ROW_PER_PAGE =10;
if(request.getParameter("currentPage")!=null){
	currentPage= Integer.parseInt(request.getParameter("currentPage"));
}

Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");

String sql1 = "SELECT COUNT(*) FROM board";
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

String sql2 = "SELECT * FROM board ORDER BY board_no ASC Limit "+ROW_PER_PAGE*(currentPage-1)+", "+ROW_PER_PAGE;
PreparedStatement stmt2 = conn.prepareStatement(sql2);//기본 paging 알고리즘 표시값 * (페이지값-1)

ResultSet rs2 = stmt2.executeQuery();



ArrayList<Board> board = new ArrayList<Board>();
//db형태를 배열화 한다
while(rs2.next()){
	
	Board b = new Board();
	b.boardNo =rs2.getInt("board_no");
	b.boardTitle =rs2.getString("board_title");
	b.boardWrite =rs2.getString("board_write");
	b.boardContent =rs2.getString("board_content");
	b.creatDate=rs2.getString("create_date");
	
	board.add(b);
	
}


//db 테이블과 같은 클래스(vo,도메인)는 만들어야 한다

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
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
		  color : black;
		  text-decoration: none;
		}
		a:active {
		  color : black;
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
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">자유게시판</h1>
	
	<div class=".container-fluid"></div>
	<div>
		<table class="table table-bordered align-middle">		
				<tr class="mt-4 p-5 bg-primary text-white rounded">
					<th>&nbsp;&nbsp;제목</th>
					<th>작성자</th>
					<th>작성일자</th>
				</tr>	
				<%
					for(Board b : board ){
				%>		
					<tr>						
						<td>&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.boardNo%>">
							<%=b.boardTitle%></a></td>
  						
						<td><%=b.boardWrite%></td>
						<td><%=b.creatDate%></td>
					</tr>
				<%
					}
				%>	
		 </table>
	</div>
	<br>
		<h6>&nbsp;&nbsp;현재페이지: <%=currentPage%></h6>
		<br>
		<div>
		<% 
		if(currentPage < lastPage){
		%>
			<span>&nbsp;&nbsp;&nbsp;</span>
			<button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>'">다음</button>
		<%
		}
		%>
		<%
		if(currentPage >1){
		%>	
			<span>&nbsp;&nbsp;&nbsp;</span>
			<button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>'">이전</button>
			
		<%
		}%>
		<span>&nbsp;&nbsp;&nbsp;</span>
		<button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/board/boardList.jsp?currentPage=1'">처음으로</button>
		<span>&nbsp;&nbsp;&nbsp;</span>
		<button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=lastPage%>'">끝으로</button>
		<span>&nbsp;&nbsp;&nbsp;</span><button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='<%=request.getContextPath()%>/board/insertBoardForm.jsp;'">글 쓰기</button>
		
		</div>		 
	
</body>
</html>