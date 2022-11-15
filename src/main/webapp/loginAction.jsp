<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	String dbuserId = "goodee";
	String dbuserPw = "1234";
	
	String result = null;
	if(id.equals(dbuserId)&&pw.equals(dbuserPw)){
		result= "success";
		session.setAttribute("x", "y");//session x= y값이 session 안에 들어감 
	}else {
		result= "failed";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%=result%><a href="./loginTest.jsp">페이지이동</a>
</body>
</html>