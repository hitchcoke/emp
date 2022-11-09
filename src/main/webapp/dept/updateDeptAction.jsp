<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>

<%

	request.setCharacterEncoding("utf-8"); //인코딩
	
	String deptName= request.getParameter("deptName");
	String deptNo= request.getParameter("deptNo");
	
	if(deptName==null||deptName.equals("")){
		response.sendRedirect(request.getContextPath()+"/dept/updateDeptForm.jsp");
				return;
	}//수정값이 null일 경우 되돌아가는 코드
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	String sql = "update departments set dept_name=? where dept_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, deptName);
	stmt.setString(2, deptNo);//deptno은 수정 넘버 그대로 readonly로 받아서 바로 준다
	
	stmt.executeUpdate();
	
	response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
	


%>