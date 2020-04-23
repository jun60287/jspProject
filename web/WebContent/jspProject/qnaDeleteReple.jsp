<%@page import="web.pet.model.QNADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	String id = (String)session.getAttribute("sId");
	
	Cookie [] cs = request.getCookies();
	if(cs != null && session.getAttribute("sId") == null){
		for(Cookie coo : cs){
			if(coo.getName().equals("cId")) id = coo.getValue();
		}session.setAttribute("sId", id);
	}

	String ref = request.getParameter("ref");
	String re_level = request.getParameter("re_level");	
	String pw = request.getParameter("pwCheck");
	
	if(ref == null){
		%>
		<script>
		alert("잘못된 접근입니다.");
		location.href="main.jsp";
		</script>
		<%
	}else{
	
		QNADAO dao = new QNADAO();
		
			dao.qnaDeleteReple(ref, re_level);
			response.sendRedirect("qnaForm.jsp");
		
		}%>
<body>
</body>
</html>