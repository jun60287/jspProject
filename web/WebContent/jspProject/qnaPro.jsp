<%@page import="web.pet.model.QNADAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
	
	String content = request.getParameter("content");
	String ref = request.getParameter("ref");
	
	if(ref == null){
		%>
		<script>alert('잘못된 접급입니다.');location.href="main.jsp";</script>
		<%
	}else{
	
		QNADAO dao = new QNADAO();
		String pw = dao.getPw(id);
		
		
		if(id != null){
			if(!content.equals("")){
				dao.insertQNA(id, content);
				response.sendRedirect("qnaForm.jsp");	
			}else{
				response.sendRedirect("qnaForm.jsp");
			}
		}else{%>
			
		<script>
			alert('로그인이 필요합니다.')
			history.back();
		</script>
	<%}
	}%>

<body>

</body>
</html>