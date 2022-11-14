<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %><%@ page import = "vo.*" %><%@ page import="java.util.ArrayList" %>
<%
/* 	Class Student{
		public String name;
		public int age;	
	}

	Student s =  new Student();
	s.name= "이지원";
	s.age=26;  */
	
	//class의 무분별한 생성의 피로도를 줄여야한다  map타입을 이용
	HashMap<String, Object> m= new HashMap<String, Object>(); //Object 타입 같은 경우 모든 타입이 들어갈 수 있다.
	m.put("name", "이지원");
	m.put("age", 26);
	HashMap<String, Object> m1= new HashMap<String, Object>(); //Object 타입 같은 경우 모든 타입이 들어갈 수 있다.
	m1.put("name", "이지원");
	m1.put("age", 26);
	
	ArrayList<HashMap<String, Object>> stu = new ArrayList<HashMap<String, Object>>();
	stu.add(m);
	stu.add(m1);
	
	for(HashMap<String, Object> st : stu){
		System.out.println(st.get("name"));
		
		System.out.println(st.get("age"));
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>