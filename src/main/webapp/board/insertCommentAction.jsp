<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%><%@ page import="vo.*" %><%@ page import = "java.util.*" %><%@page import="java.net.URLEncoder" %>

<%
	
   // 1)
   request.setCharacterEncoding("utf-8");
   int boardNo= Integer.parseInt(request.getParameter("boardNo"));
   String commentPw = request.getParameter("commentPw");
   String commentContent = request.getParameter("commentContent");
   if(commentPw == null || commentContent == null || commentPw.equals("") || commentContent.equals("")) {
	      String msg = URLEncoder.encode("비밀번호, 내용을 채워주세요","utf-8"); // get방식 주소창에 문자열 인코딩
	      response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?msg="+msg);
	      return;
	   }
	   
   

   Class.forName("org.mariadb.jdbc.Driver");
   Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
   // 2-2 입력
   String sql = "INSERT INTO comment(board_no, comment_pw, comment_content, create_date) value(?, ?, ?, curdate())";
   PreparedStatement stmt = conn.prepareStatement(sql);
   stmt.setInt(1, boardNo);
   stmt.setString(2, commentPw);
   stmt.setString(3, commentContent);
  
   int row = stmt.executeUpdate();
   response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?boardNo="+boardNo);
   // 3)
%>

   