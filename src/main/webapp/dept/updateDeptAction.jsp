<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>

<%

	request.setCharacterEncoding("utf-8"); //인코딩
	
	String deptName= request.getParameter("deptName");
	String deptNo= request.getParameter("deptNo");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	String sql = "update departments set dept_name=? where dept_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, deptName);
	stmt.setString(2, deptNo);
	
	stmt.executeUpdate();
	
	response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
	


%>