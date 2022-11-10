<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %><%@ page import="vo.*"  %>
<%@ page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>



<%

	 request.setCharacterEncoding("utf-8"); //인코딩
	 
	 String boardNo = request.getParameter("boardNo");
	 String boardTitle = request.getParameter("boardTitle");
	 String boardWrite = request.getParameter("boardWrite");
	 String boardPw = request.getParameter("boardPw");
	 String boardContent = request.getParameter("boardContent");

		 
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees","root","java1234");
	
 	String sql1= "SELECT board_pw FROM board WHERE board_no= "+boardNo;
	PreparedStatement stmt1 = conn.prepareStatement(sql1); 
	
	ResultSet rs = stmt1.executeQuery(); 
	
	if(rs.next()){
		if(boardPw.equals(rs.getString("board_pw"))){
			String sql = "UPDATE board SET board_title= ?, board_write= ?, board_content= ? WHERE board_no= ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, boardTitle);
			stmt.setString(2, boardWrite);
			stmt.setString(3, boardContent);
			stmt.setString(4, boardNo);
			
			stmt.executeUpdate();
				
		}else{
			String msg = URLEncoder.encode("비밀번호가 틀렸습니다","utf-8"); // get방식 주소창에 문자열 인코딩
		    response.sendRedirect(request.getContextPath()+"/board/updateBoardForm.jsp?msg="+msg+"&boardNo="+boardNo);
		    return;

		}
	}
	
	
	
	
	
	
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	
%>

