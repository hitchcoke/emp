<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %><%@page import="java.net.URLEncoder" %>

<%

	request.setCharacterEncoding("utf-8");
	String boardNo = request.getParameter("boardNo");
	String commentNo= request.getParameter("commentNo");
	String commentPw= request.getParameter("commentPw");
	
	// 2. 요청처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	
	String sql1= "SELECT comment_pw FROM comment WHERE comment_no= "+commentNo;
	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	
	ResultSet rs = stmt1.executeQuery();
	if(rs.next()){
		if(commentPw.equals(rs.getString("comment_pw"))){
			String sql = "delete from comment where comment_no ="+commentNo;
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.executeUpdate();
		}else{
			String msg = URLEncoder.encode("비밀번호가 틀렸습니다","utf-8"); // get방식 주소창에 문자열 인코딩
		    response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?msg="+msg+"&boardNo="+boardNo);
		    return;
		}
	}

	response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?boardNo="+boardNo);
	// 3. 출력
%>
