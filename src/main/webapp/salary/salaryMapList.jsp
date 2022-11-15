<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %><%@ page import = "vo.*" %><%@ page import="java.util.ArrayList" %><%@ page import = "java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String word = request.getParameter("word");
	
	//class의 무분별한 생성의 피로도를 줄여야한다  map타입을 이용
	 
	int rowPerPage= 10;
	int currentPage= 1;
	int beginRow=rowPerPage*(currentPage-1);
	int lastPage=0;
	 
	String driver= "org.mariadb.jdbc.Driver";
	String dbur1="jdbc:mariadb://localhost:3306/employees";
	String user="root";
	String dbpw="java1234";
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbur1, user, dbpw);
	//프로토콜(jdbc:mariadb)://(주소: 통로):localhost(도메인으로 ip를 쉽게 부를려고 한다 alias):3306/(db테이블 주소), "사용자 이름" "db password" 
	
	
	String sql= null;
	PreparedStatement stmt = null;
	ResultSet rs=null;
	String sql1=null;
	PreparedStatement stmt1 = null;
	ResultSet rs1= null;
	
	if(word==null||word.equals("")){
		
		sql= "SELECT s.emp_no empNo, s.salary salary, s.from_date fromDate, s.to_date toDate, CONCAT(e.first_name, e.last_name) name FROM salaries s INNER JOIN employees e ON s.emp_no = e.emp_no ORDER BY s.emp_no LIMIT ?,?";		
		stmt= conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		sql1="SELECT COUNT(*) FROM salaries s INNER JOIN employees e ON s.emp_no= e.emp_no";
		stmt1=conn.prepareStatement(sql1);
		rs1=stmt1.executeQuery();
		
	}else if(word!=null&&word.equals("")==false){
		
		sql= "SELECT s.emp_no empNo, s.salary salary, s.from_date fromDate, s.to_date toDate, CONCAT(e.first_name, e.last_name) name FROM salaries s INNER JOIN employees e ON s.emp_no = e.emp_no WHERE e.first_name LIKE ? OR e.last_name LIKE ? ORDER BY s.emp_no LIMIT ?,?";
		stmt= conn.prepareStatement(sql);
		
		stmt.setString(1, "%"+word+"%");
		stmt.setString(1, "%"+word+"%");
		stmt.setInt(3, beginRow);
		stmt.setInt(4, rowPerPage);
		
		rs = stmt.executeQuery();
		
		sql1= "SELECT COUNT(*) FROM salaries s INNER JOIN employees e ON s.emp_no= e.emp_no WHERE e.first_name LIKE ? OR e.last_name Like ?";
		stmt1= conn.prepareStatement(sql1);
		stmt1.setString(1, "%"+word+"%");
		stmt1.setString(2, "%"+word+"%");
		rs1=stmt1.executeQuery();
	}
	
	int count= 0;
	if(rs1.next()){
		count=rs1.getInt("COUNT(*)");
	}
	
	lastPage = count/rowPerPage;
	if(count%rowPerPage!=0){
		lastPage++;
	}
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("empNo", rs.getInt("empNo"));
		m.put("fromDate", rs.getString("fromDate"));
		m.put("name", rs.getString("name"));
		m.put("toDate", rs.getString("toDate"));
		m.put("salary", rs.getInt("salary"));
		list.add(m);
	}
	
	
	
	rs1.close();
	stmt1.close();
	rs.close();
	stmt.close();
	conn.close();//ram최소화를 위해 닫아준다 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>salaryMapList</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
		<jsp:include page="../menu.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div>
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">연봉 지출 내역</h1>
	<table class="table table-bordered align-middle">
		<tr class="mt-4 p-5 bg-primary text-white rounded">
			<th>사원번호</th>
			<th>사원이름</th>
			<th>연봉</th>
			<th>계약일자</th>
			<th>퇴사일자</th>
		</tr>
		<%
		for(HashMap<String, Object> m : list){
		%>
			<tr>
				<td><%=m.get("empNo")%></td>
				<td><%=m.get("name")%></td>
				<td><%=m.get("salary")%></td>
				<td><%=m.get("fromDate")%></td>
				<td><%=m.get("toDate")%></td> 
			</tr>
		<%
		}%>	
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
	      				<a class="page-link" href="<%=request.getContextPath()%>/salary/salaryMapList.jsp?currentPage=<%=currentPage-1%>">Previous</a>
	    			</li>
	    		<%if(currentPage > 1){%>	
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/salary/salaryMapList.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
	    		<%} %>
	    			<li class="page-item active" aria-current="page">
	    				<span class="page-link"><%=currentPage%></span></li>
	    		<%if(currentPage < lastPage){%>		
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/salary/salaryMapList.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
	    		<%}
	    		  if(currentPage < lastPage){%>	
	    			<li class="page-item">
	    		<%}else{ %>
	    			<li class="page-item disabled"><%} %>
	      		   		<a class="page-link" href="<%=request.getContextPath()%>/salary/salaryMapList.jsp?currentPage=<%=currentPage+1%>">Next</a>
	    			</li>
	    	<%}else{ %>
	    		<%if(currentPage > 1){%>	
	   				<li class="page-item">
	   				<% }else{ %>
	   				<li class="page-item disabled"><%} %>
	      				<a class="page-link" href="<%=request.getContextPath()%>/salary/salaryMapList.jsp?currentPage=<%=currentPage-1%>&word=<%=word%>">Previous</a>
	    			</li>
	    		<%if(currentPage > 1){%>	
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/salary/salaryMapList.jsp?currentPage=<%=currentPage-1%>&word=<%=word%>"><%=currentPage-1%></a></li>
	    		<%} %>
	    			<li class="page-item active" aria-current="page">
	    				<span class="page-link"><%=currentPage%></span></li>
	    		<%if(currentPage < lastPage){%>		
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/salary/salaryMapList.jsp?currentPage=<%=currentPage+1%>&word=<%=word%>"><%=currentPage+1%></a></li>
	    		<%}
	    		  if(currentPage < lastPage){%>	
	    			<li class="page-item">
	    		<%}else{ %>
	    			<li class="page-item disabled"><%} %>
	      		   		<a class="page-link" href="<%=request.getContextPath()%>/salary/salaryMapList.jsp?currentPage=<%=currentPage+1%>&word=<%=word%>">Next</a>
	    			</li>
	    	<%} %>
 	   		</ul>
	   </nav>
	</div>
	<div>
		<form method="post" action="<%=request.getContextPath()%>/salary/salaryMapList.jsp">
			<span>&nbsp;&nbsp;&nbsp;</span><input type="text" name=word <%if(word==null||word.equals("")){ %>placeholder="사원검색"<%}else{ %>value="<%=word%>"<%} %>>
			<button type="submit" class="btn btn-outline-primary">검색</button>
		</form>
	</div>
</body>
</html>