<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %><%@page import="java.net.URLEncoder" %>

<%

	request.setCharacterEncoding("utf-8");
	String boardNo = request.getParameter("boardNo");
	String boardPw= request.getParameter("boardPw");
	
	// 2. 요청처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	
	String sql1= "SELECT board_pw FROM board WHERE board_no= "+boardNo;
	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	
	ResultSet rs = stmt1.executeQuery();
	if(rs.next()){
		if(boardPw.equals(rs.getString("board_pw"))){
			String sql = "delete from board where board_no ="+boardNo;
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.executeUpdate();
		}else{
			String msg = URLEncoder.encode("비밀번호가 틀렸습니다","utf-8"); // get방식 주소창에 문자열 인코딩
		    response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?msg="+msg+"&boardNo="+boardNo);
		    return;
		}
	}

	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	// 3. 출력
%>
