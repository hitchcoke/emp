
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
   // 1
   int currentPage = 1;
   if(request.getParameter("currentPage") != null) {
      currentPage = Integer.parseInt(request.getParameter("currentPage"));
   }
   
   // 2
   final int ROW_PER_PAGE =10;
   int lastPage=0;
   int beginRow = ROW_PER_PAGE*(currentPage-1);
   Class.forName("org.mariadb.jdbc.Driver");
   Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root", "java1234");

   String sql = "SELECT s.emp_no empNo, s.salary salary, s.from_date fromDate, s.to_date toDate, e.first_name firstName, e.last_name lastName FROM salaries s INNER JOIN employees e ON s.emp_no = e.emp_no ORDER BY s.emp_no ASC LIMIT ?,?";
   PreparedStatement stmt = conn.prepareStatement(sql);
   stmt.setInt(1, beginRow);
   stmt.setInt(2, ROW_PER_PAGE);
   ResultSet rs = stmt.executeQuery();
   
   String sql1 = "SELECT COUNT(*) FROM salaries s INNER JOIN employees e ON s.emp_no = e.emp_no";
   PreparedStatement stmt1 = conn.prepareStatement(sql1);
   ResultSet rs1 = stmt1.executeQuery();
   
	int count =0;
	if(rs1.next()){
		count= rs1.getInt("COUNT(*)");
	}
	
	lastPage= count/ ROW_PER_PAGE;
	if(count % ROW_PER_PAGE !=0){
		lastPage++;
	} 
   
   ArrayList<Salary> salaryList = new ArrayList<>();
   while(rs.next()) {
      Salary s = new Salary();
      s.emp = new Employees(); // ☆☆☆☆☆
      s.emp.empNo = rs.getInt("empNo");
      s.salary = rs.getInt("salary");
      s.fromDate = rs.getString("fromDate");
      s.toDate = rs.getString("toDate");
      s.emp.firstName = rs.getString("firstName");
      s.emp.lastName = rs.getString("lastName");
      salaryList.add(s);
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>salaryList</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
		<jsp:include page="../menu.jsp"></jsp:include> 
		<!-- include의 주소에는 context를 사용하지 않는다 편한 액션 중하나 -->
	</div>
	<h1 style="text-align:center" class="mt-4 p-5 bg-primary text-white rounded">급여명세서</h1>
   <table class="table table-bordered align-middle">
   		<tr class="mt-4 p-5 bg-primary text-white rounded">
   			<th>사원번호</th>
   			<th>급여</th>
   			<th>입사일자</th>
   			<th>퇴사일자</th>
   			<th>사원이름</th>
   		</tr>
      <%
         for(Salary s : salaryList) {
      %>
            <tr>
               <td><%=s.emp.empNo%></td>
               <td><%=s.salary%></td>
               <td><%=s.fromDate%></td>
               <td><%=s.toDate%></td>
               <td><%=s.emp.firstName%> <%=s.emp.lastName%></td>
            </tr>
      <%      
         }
      %>
   </table>
   <br>
		<div>
			<nav aria-label="Page navigation example">
	  			<ul class="pagination justify-content-center pagination-lg">
	  				<%if(currentPage > 1){%>	
		   				<li class="page-item">
		   				<% }else{ %>
		   				<li class="page-item disabled"><%} %>
		      				<a class="page-link" href="<%=request.getContextPath()%>/salary/salaryList.jsp?currentPage=<%=currentPage-1%>">Previous</a>
		    			</li>
		    		<%if(currentPage > 1){%>	
		    			<li class="page-item">
		    				<a class="page-link" href="<%=request.getContextPath()%>/salary/salaryList.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
		    		<%} %>
		    			<li class="page-item active" aria-current="page">
		    				<span class="page-link"><%=currentPage%></span></li>
		    		<%if(currentPage < lastPage){%>		
		    			<li class="page-item">
		    				<a class="page-link" href="<%=request.getContextPath()%>/salary/salaryList.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
		    		<%}
		    		  if(currentPage < lastPage){%>	
		    			<li class="page-item">
		    		<%}else{ %>
		    			<li class="page-item disabled"><%} %>
		      		   		<a class="page-link" href="<%=request.getContextPath()%>/salary/salaryList.jsp?currentPage=<%=currentPage+1%>">Next</a>
		    			</li>	
	  			</ul>
	  		</nav>
  		</div>	
   
</body>
</html>