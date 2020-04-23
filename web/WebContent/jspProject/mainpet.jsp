<%@page import="web.pet.model.PetsitterDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>펫시터 메인페이지</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
<link href="xListStyle.css" rel="stylesheet" type="text/css" />
<style>
	.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center; width : 550px; 
		border-radius: 5px; background-color: #eff1f4; }
	#list4{ margin:0 auto; width:500px; border-collapse: collapse; border: 2px solid #eff1f4; }
</style>
</head>
<%
	if(session.getAttribute("sId") == null){	%>
		<script>
			alert("잘못된 접근입니다!");
			window.location.href = "main.jsp";
		</script>
<%	}else{
		String id = (String)session.getAttribute("sId");
		PetsitterDAO dao = new PetsitterDAO();
		boolean check = dao.petsitCheck(id); %>

<body>
	<header>
		<jsp:include page="petHeader.jsp" flush="false"/>
	</header>
	<div id="wrapper">
		<aside class="aside">
			<jsp:include page="mypageAside.jsp" flush="false"/>
		</aside>
		<section class="section">
			<br /><br />
			<h2 align="center" style="margin-bottom: 0; color: #3e6383;">펫시터 메인페이지</h2>
			<br/><br/>
			<div class="table2">
				<br/>
				<table id="list4">
					<% if(check){	%>
					<tr>
						<td>
							<%= id %>님 환영합니다.	<br /><br/>
							<button class="listButt" onclick = "window.location.href = 'infopet.jsp'" >내 펫시터 정보보기</button>
							<button class="listButt" onclick = "window.location.href = 'actpet.jsp'" >내 펫시터 활동내역보기</button>
							<br/><br/>
						</td>
					</tr>
					<%}else{%>
					<tr>
						<td>
							<%= session.getAttribute("sId") %>님 환영합니다. <br />
							<button class="listButt" onclick = "window.location.href = 'applypetForm.jsp'" >펫시터 신청</button>
							<br/><br/>
						</td>
					</tr>
					<%} %>
				</table>
			</div>
		</section>
		<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
		<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
		<br/><br/><br/><br/><br/><br/><br/><br/>
		<br/><br/><br/><br/><br/><br/><br/><br/>

	</div>	
	<footer>
		<jsp:include page="petFooter.jsp" flush="false"/>
	</footer>
</body>
<% 	}%>
</html>