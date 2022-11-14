<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%><%@ page import="vo.*" %><%@ page import = "java.util.*" %><%@page import="java.net.URLEncoder" %>

<%
	
   // 1)
   request.setCharacterEncoding("utf-8");
   String boardTitle = request.getParameter("boardTitle");
   String boardWrite = request.getParameter("boardWrite");
   String boardPw = request.getParameter("boardPw");
   String boardContent = request.getParameter("boardContent");
   if(boardTitle == null || boardWrite == null || boardTitle.equals("") || boardWrite.equals("")) {
      String msg = URLEncoder.encode("작성자 이름, 제목을 확인해주세요","utf-8"); // get방식 주소창에 문자열 인코딩
      response.sendRedirect(request.getContextPath()+"/board/insertBoardForm.jsp?msg="+msg);
      return;
   }
   if(boardPw == null || boardContent == null || boardPw.equals("") || boardContent.equals("")) {
	      String msg = URLEncoder.encode("비밀번호, 내용을 채워주세요","utf-8"); // get방식 주소창에 문자열 인코딩
	      response.sendRedirect(request.getContextPath()+"/board/insertBoardForm.jsp?msg="+msg);
	      return;
	   }
	   
   

   Class.forName("org.mariadb.jdbc.Driver");
   Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
   // 2-2 입력
   String sql = "INSERT INTO board(board_title, board_write, board_pw, board_content, create_date) value(?, ?, ?, ?, curdate())";
   PreparedStatement stmt = conn.prepareStatement(sql);
   stmt.setString(1, boardTitle);
   stmt.setString(2, boardWrite);
   stmt.setString(3, boardPw);
   stmt.setString(4, boardContent);
   int row = stmt.executeUpdate();
   response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
   // 3)
%>

   

	
