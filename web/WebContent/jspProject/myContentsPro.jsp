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
	String num1 = request.getParameter("num");
	request.setCharacterEncoding("UTF-8");
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	if(sId == null){
		Cookie [] cs = request.getCookies();
		if(cs != null){
			for(Cookie coo : cs){
				if(coo.getName().equals("cId")) cId = coo.getValue();
			}session.setAttribute("sId", sId);
		}
	}
	if(sId == null && cId != null){
		session.setAttribute("sId", cId);
		sId = cId;
	}
	
	if(sId == null || num1 == null){
		%> 
		<script>
		alert('잘못된 접근');
		location.href="main.jsp";
		</script>
	<% }else{
	
	int num = Integer.parseInt(request.getParameter("num"));
	String text = request.getParameter("text");
		
	QNADAO dao = new QNADAO();
	
	dao.modifyContent(num, text);
	%>
	<script>alert("수정완료");history.back();</script>
<%}
%>
<body>


</body>
</html>