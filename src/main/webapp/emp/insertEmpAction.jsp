<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%><%@ page import="vo.*" %><%@ page import = "java.util.*" %><%@page import="java.net.URLEncoder" %>

<%
	
   // 1)
   request.setCharacterEncoding("utf-8");
   String birthDate = request.getParameter("birthDate");
   String firstName = request.getParameter("firstName");
   String lastName = request.getParameter("lastName");
   String gender = request.getParameter("gender");
   String hireDate = request.getParameter("hireDate");
   
   if(birthDate == null ||  == null || deptNo.equals("") || deptName.equals("")) {
      	String msg = URLEncoder.encode("부서번호와 부서이름을 입력하세요","utf-8"); // get방식 주소창에 문자열 인코딩
   		response.sendRedirect(request.getContextPath()+"/dept/insertDeptForm.jsp?msg="+msg);
      	return;
      	}
    
   // 2)
   // 이미 존재하는 key(dept_no)값 동일한 값이 입력되면 예외(에러)가 발생한다. -> 동일한 dept_no값이 입력되었을때 예외가 발생하지 않도록...
   Class.forName("org.mariadb.jdbc.Driver");
   Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");

   // 2-2 입력
   String sql = "INSERT INTO employees(birth_date, first) value(?,?)";
   PreparedStatement stmt = conn.prepareStatement(sql);
   stmt.setString(1,deptNo);
   stmt.setString(2,deptName);
   int row = stmt.executeUpdate();
   response.sendRedirect(request.getContextPath()+"/emp/empList.jsp");
   // 3)
%>

   