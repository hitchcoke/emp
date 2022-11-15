<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %><%@ page import = "vo.*" %><%@ page import="java.util.ArrayList" %><%@ page import = "java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String word = request.getParameter("word");
	String type= request.getParameter("type");
	
	//class의 무분별한 생성의 피로도를 줄여야한다  map타입을 이용
	 
	int rowPerPage= 10;
	int currentPage= 1;
	int lastPage=0;
	if(request.getParameter("currentPage")!=null){
		currentPage= Integer.parseInt(request.getParameter("currentPage"));
	}
	int beginRow= rowPerPage*(currentPage-1);

	 
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
		
		sql="SELECT d.dept_no deptNo, d.dept_name deptName, CONCAT(e.first_name, e.last_name) name, de.from_date fromDate, de.to_date toDate FROM dept_emp de INNER JOIN employees e ON de.emp_no= e.emp_no INNER JOIN departments d ON de.dept_no=d.dept_no ORDER BY e.emp_no LIMIT ?,?";
		stmt= conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		sql1="SELECT COUNT(*) FROM dept_emp de INNER JOIN employees e ON de.emp_no= e.emp_no";
		stmt1=conn.prepareStatement(sql1);
		rs1=stmt1.executeQuery();
		
	}else{
		
		if(type.equals("d.dept_name")){
		sql= "SELECT d.dept_no deptNo, d.dept_name deptName, CONCAT(e.first_name, e.last_name) name, de.from_date fromDate, de.to_date toDate FROM dept_emp de INNER JOIN employees e ON de.emp_no= e.emp_no INNER JOIN departments d ON de.dept_no=d.dept_no WHERE "+type+" LIKE '%"+word+"%' ORDER BY e.emp_no LIMIT ?,?";
		}else if(type.equals("name")){
		sql= "SELECT d.dept_no deptNo, d.dept_name deptName, CONCAT(e.first_name, e.last_name) name, de.from_date fromDate, de.to_date toDate FROM dept_emp de INNER JOIN employees e ON de.emp_no= e.emp_no INNER JOIN departments d ON de.dept_no=d.dept_no WHERE e.first_name LIKE '%"+word+"%' OR e.last_name LIKE '%"+word+"%' ORDER BY e.emp_no LIMIT ?,?";
				
		}
		stmt= conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		rs = stmt.executeQuery();
		
		sql1= "SELECT COUNT(*) FROM dept_emp de INNER JOIN employees e ON de.emp_no= e.emp_no WHERE e.first_name LIKE ? OR e.last_name Like ?";
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
	ArrayList<DeptEmp> list = new ArrayList<DeptEmp>();
	
	while(rs.next()){
		DeptEmp m = new DeptEmp();
		m.emp=new Employees();
		m.emp.firstName=rs.getString("name");
		m.dept=new Department();
		m.dept.deptName=rs.getString("deptName");
		m.dept.deptNo=rs.getString("deptNo");
		m.fromDate=rs.getString("fromDate");
		m.toDate=rs.getString("toDate");
		
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
<title>deptEmpList</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
		<jsp:include page="../menu.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div>
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">부서 내 사원</h1>
	<table class="table table-bordered align-middle">
		<tr class="mt-4 p-5 bg-primary text-white rounded">
			<th>부서번호</th>
			<th>부서이름</th>
			<th>사원이름</th>
			<th>계약일자</th>
			<th>퇴사일자</th>
		</tr>
		<%
		for(DeptEmp m : list){
		%>
			<tr>
				<td><%=m.dept.deptNo%></td>
				<td><%=m.dept.deptName%></td>
				<td><%=m.emp.firstName%></td>
				<td><%=m.fromDate%></td>
				<td><%=m.toDate%></td> 
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
	      				<a class="page-link" href="<%=request.getContextPath()%>/deptemp/deptEmpList.jsp?currentPage=<%=currentPage-1%>">Previous</a>
	    			</li>
	    		<%if(currentPage > 1){%>	
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/deptemp/deptEmpList.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
	    		<%} %>
	    			<li class="page-item active" aria-current="page">
	    				<span class="page-link"><%=currentPage%></span></li>
	    		<%if(currentPage < lastPage){%>		
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/deptemp/deptEmpList.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
	    		<%}
	    		  if(currentPage < lastPage){%>	
	    			<li class="page-item">
	    		<%}else{ %>
	    			<li class="page-item disabled"><%} %>
	      		   		<a class="page-link" href="<%=request.getContextPath()%>/deptemp/deptEmpList.jsp?currentPage=<%=currentPage+1%>">Next</a>
	    			</li>
	    	<%}else{ %>
	    		<%if(currentPage > 1){%>	
	   				<li class="page-item">
	   				<% }else{ %>
	   				<li class="page-item disabled"><%} %>
	      				<a class="page-link" href="<%=request.getContextPath()%>/deptemp/deptEmpList.jsp?currentPage=<%=currentPage-1%>&word=<%=word%>&type=<%=type%>">Previous</a>
	    			</li>
	    		<%if(currentPage > 1){%>	
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/deptemp/deptEmpList.jsp?currentPage=<%=currentPage-1%>&word=<%=word%>&type=<%=type%>"><%=currentPage-1%></a></li>
	    		<%} %>
	    			<li class="page-item active" aria-current="page">
	    				<span class="page-link"><%=currentPage%></span></li>
	    		<%if(currentPage < lastPage){%>		
	    			<li class="page-item">
	    				<a class="page-link" href="<%=request.getContextPath()%>/deptemp/deptEmpList.jsp?currentPage=<%=currentPage+1%>&word=<%=word%>&type=<%=type%>"><%=currentPage+1%></a></li>
	    		<%}
	    		  if(currentPage < lastPage){%>	
	    			<li class="page-item">
	    		<%}else{ %>
	    			<li class="page-item disabled"><%} %>
	      		   		<a class="page-link" href="<%=request.getContextPath()%>/deptemp/deptEmpList.jsp?currentPage=<%=currentPage+1%>&word=<%=word%>&type=<%=type%>">Next</a>
	    			</li>
	    	<%} %>
 	   		</ul>
	   </nav>
	</div>
	<div>
		<form method="post" action="<%=request.getContextPath()%>/deptemp/deptEmpList.jsp">
			<span>&nbsp;&nbsp;&nbsp;</span><select name="type">
	    		<option value="d.dept_name">부서이름</option>
	   			<option value="name">사원이름</option>
			</select>
			<span>&nbsp;</span><input type="text" name=word <%if(word==null||word.equals("")){ %>placeholder="사원검색"<%}else{ %>value="<%=word%>"<%} %>>
			<button type="submit" class="btn btn-outline-primary">검색</button>
		</form>
	</div>
</body>
</html>