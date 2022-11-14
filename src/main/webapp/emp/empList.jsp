<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>


<%
	request.setCharacterEncoding("utf-8");

	String word=request.getParameter("word");

	int currentPage=1;
	int lastPage=0;
	final int ROW_PER_PAGE =10;
	if(request.getParameter("currentPage")!=null){
		currentPage= Integer.parseInt(request.getParameter("currentPage"));
	}
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	
		String sql1=null;
		PreparedStatement stmt1=null;
		String sql2=null;
		PreparedStatement stmt2=null;
		ResultSet rs1=null;
		
		if(word==null || word.equals("")){	
			sql1 = "SELECT COUNT(*) FROM employees";
			stmt1 = conn.prepareStatement(sql1);
			rs1 = stmt1.executeQuery();
			
			sql2 = "SELECT * FROM employees ORDER BY emp_no DESC Limit "+ROW_PER_PAGE*(currentPage-1)+", "+ROW_PER_PAGE;
			stmt2 = conn.prepareStatement(sql2);
			
		}else{
			sql1 = "SELECT COUNT(*) FROM employees WHERE first_name LIKE ? OR last_name Like ?";
			stmt1 = conn.prepareStatement(sql1);
			stmt1.setString(1, "%"+word+"%");
			stmt1.setString(2, "%"+word+"%");
			rs1 = stmt1.executeQuery();
			
			sql2 = "SELECT * FROM employees WHERE first_name LIKE ? OR last_name Like ? ORDER BY emp_no DESC Limit "+ROW_PER_PAGE*(currentPage-1)+", "+ROW_PER_PAGE;
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, "%"+word+"%");
			stmt2.setString(2, "%"+word+"%");
			
			
		} 
	
		int count =0;
		if(rs1.next()){
			count= rs1.getInt("COUNT(*)");
		}
		
		lastPage= count/ ROW_PER_PAGE;
		if(count % ROW_PER_PAGE !=0){
			lastPage++;
		} 
		
		
		
		ResultSet rs2 = stmt2.executeQuery();



	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>empList</title>
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
		<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">사원관리</h1>
		<table class="table table-bordered align-middle">
			<tr class="mt-4 p-5 bg-primary text-white rounded">
				<th>생년월일</th>
				<th>이름</th>
				<th>성별</th>
				<th colspan="3">입사일자</th>
			</tr>
			<%
			while(rs2.next()){
			%>
				<tr>
					<td><%=rs2.getString("birth_date")%></td>
					<td><%=rs2.getString("first_name")%> <%=rs2.getString("last_name")%></td>
					<td><%=rs2.getString("gender")%></td>
					<td><%=rs2.getString("hire_date")%></td>
					<td><a href="<%=request.getContextPath()%>/emp/updateEmpForm.jsp?empNo=<%=rs2.getInt("emp_no")%>" class="btn btn-outline-primary">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/emp/deleteEmp.jsp?empNo=<%=rs2.getInt("emp_no")%>" class="btn btn-outline-primary">삭제</a></td>
				</tr>
			<%
			}
			%>	
		</table>
		
		<br>
		<div>
			<nav aria-label="Page navigation example">
  			<ul class="pagination justify-content-center pagination-lg">
   			<%if(word==null){ %>
   				
	   			<%if(currentPage > 1){%>	
	   				<li class="page-item">
	   				<% }else{ %>
	   				<li class="page-item disabled"><%} %>
	      				<a class="page-link" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>">Previous</a>
	    			</li>
	    		<%if(currentPage > 1){%>	
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
	    		<%} %>
	    			<li class="page-item active" aria-current="page">
	    				<span class="page-link"><%=currentPage%></span></li>
	    		<%if(currentPage < lastPage){%>		
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
	    		<%}
	    		  if(currentPage < lastPage){%>	
	    			<li class="page-item">
	    		<%}else{ %>
	    			<li class="page-item disabled"><%} %>
	      		   		<a class="page-link" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>">Next</a>
	    			</li>
	    	<%}else{ %>
	    		<%if(currentPage > 1){%>	
	   				<li class="page-item">
	   				<% }else{ %>
	   				<li class="page-item disabled"><%} %>
	      				<a class="page-link" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&word=<%=word%>">Previous</a>
	    			</li>
	    		<%if(currentPage > 1){%>	
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&word=<%=word%>"><%=currentPage-1%></a></li>
	    		<%} %>
	    			<li class="page-item active" aria-current="page">
	    				<span class="page-link"><%=currentPage%></span></li>
	    		<%if(currentPage < lastPage){%>		
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&word=<%=word%>"><%=currentPage+1%></a></li>
	    		<%}
	    		  if(currentPage < lastPage){%>	
	    			<li class="page-item">
	    		<%}else{ %>
	    			<li class="page-item disabled"><%} %>
	      		   		<a class="page-link" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&word=<%=word%>">Next</a>
	    			</li>
	    	<%} %>
 	   		</ul>
	   </nav>
		</div>
		<div>
			<form method="post" action="<%=request.getContextPath()%>/emp/empList.jsp">
				<span>&nbsp;&nbsp;&nbsp;</span><input type="text" name="word" placeholder="사원검색">
				<button type="submit" class="btn btn-outline-primary">검색</button>
			</form>
		</div>	
	</body>
</html>