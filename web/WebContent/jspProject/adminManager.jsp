<%@page import="web.pet.model.PDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보 관리</title>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
	<link href="xListStyle.css" rel="stylesheet" type="text/css" />
	<script>
		function adminmodify(id){
			alert(id);
			location.href = "adminModifyForm.jsp?id=" + encodeURI(id);
		}
		function admindelete(id){
			alert(id);
			location.href = "adminDelete.jsp?id=" + encodeURI(id);
		}
	</script>
</head>
<%
	if(session.getAttribute("sId") == null || !session.getAttribute("sId").equals("admin")){%>
		<script>
			alert("관리자 전용페이지입니다.");
			window.location = 'main.jsp';
		</script>
<%	}else{
%>
<jsp:useBean id = "manager" class = "web.pet.model.PDAO" />
<body>
	<h1 align="center" style="margin-bottom: 0; color: #3e6383;">** 관리자 - 전체 회원 관리 **</h1>
	<br /><br />
	<div class="table">
		<br/>
		<table id="list">
			<tr>
				<td>아이디</td>
				<td>비밀번호</td>
				<td>이메일</td>
				<td>가입날짜</td>
			</tr>
			<%
			ArrayList<PDTO> list = manager.getMemberAll();
			for(PDTO dto : list){	%>
			<tr>
				<td><%=dto.getId() %></td>
				<td><%=dto.getPw() %></td>
				<td><%=dto.getEmail() %></td>
				<td><%=dto.getReg() %></td>
				<td style="background-color:#e5ebf4; "><a href = "javascript:adminmodify('<%= dto.getId() %>')">수정하기</a></td>
				<td style="background-color:#d8e1ee; "><a href = "javascript:admindelete('<%= dto.getId() %>')">삭제하기</a></td>
			</tr>
		<%	}%>
		</table>
		<br/>
	</div>	
	<h2 align="center" style="margin-bottom: 0; color: #3e6383;"><a href = "adminPage.jsp">관리자 페이지로 돌아가기</a></h2>
</body>
<%	} %>
</html>