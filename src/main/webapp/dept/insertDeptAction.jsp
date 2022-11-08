<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("dept_name")==null){
		response.sendRedirect(request.getContextPath()+"/dept/insertDeptForm.jsp");
		return;
		}//부서이름 공백시 다시 리턴
		
	String deptName= request.getParameter("dept_name");
	String deptNo=request.getParameter("dept_no");
	//form에서 user의 deptname 받아오기
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	//jsp 와 employees db와 연결
	
	PreparedStatement stmt= conn.prepareStatement
	("insert into departments(dept_name, dept_no) values(?,?)");
	
	stmt.setString(1, deptName);
	stmt.setString(2, deptNo);
	//departments 열 deptName 추가
	stmt.executeUpdate();
	
	/* int row= stmt.executeUpdate();
 		if(row==1){
			 System.out.println("입력성공");
	 	}else{
		 	System.out.println("입력실패");//debuging
		}   */

	response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
	//작업완료후 list로 넘어감
	
	/*
	
	*/
%>