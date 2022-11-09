<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	// ★★★★★  들여쓰기 / 주석 / 디버깅  ★★★★★
	
	// 1. 요청분석
	request.setCharacterEncoding("utf-8");
	String empNo = request.getParameter("empNo");
	
	// 2. 요청처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	String sql = "delete from employees where emp_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, empNo);
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("삭제성공");
	} else {
		System.out.println("삭제실패");
	}

	response.sendRedirect(request.getContextPath()+"/emp/empList.jsp");
	// 3. 출력
%>
