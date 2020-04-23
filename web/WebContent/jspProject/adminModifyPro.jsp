<%@page import="web.pet.model.PDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 회원관리 - 회원정보 수정 페이지(프로)</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("sId") == null || !session.getAttribute("sId").equals("admin")){%>
		<script>
			alert("관리자 전용페이지입니다.");
			location.href = "main.jsp";
		</script>
<%	}else{
%>
<jsp:useBean id = "admin" class = "web.pet.model.PDTO" />
<jsp:setProperty property = "*" name = "admin" />
<%
		PDAO dao = new PDAO();
		dao.modifyAdminmember(admin);
%>
<body>
	<script>
		alert("수정이 완료되었습니다.");
		location.href = "adminManager.jsp";
	</script>
</body>
<%	} %>
</html>