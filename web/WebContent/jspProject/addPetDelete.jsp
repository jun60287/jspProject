<%@page import="web.pet.model.QNADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("sId");
	
	Cookie [] cs = request.getCookies();
	if(cs != null && session.getAttribute("sId") == null){
		for(Cookie coo : cs){
			if(coo.getName().equals("cId")) id = coo.getValue();
		}session.setAttribute("sId", id);
	}
	
	String str = request.getParameter("hidden1");
	
	if(str == null){
		%>
		<script>alert("잘못된 접근입니다.");history.back();</script>
		<%
	}else{
	
	int i = Integer.parseInt(str);
	

	
	QNADAO dao = new QNADAO();	
	dao.addPetDelete(id, i);
	
	response.sendRedirect("addpet.jsp");
	}
%>
<body>

</body>
</html>