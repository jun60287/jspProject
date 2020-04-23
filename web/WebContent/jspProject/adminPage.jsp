<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 페이지</title>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
	<link href="xListStyle.css" rel="stylesheet" type="text/css" />
	<style>
		.list2 { width:300px; margin:0 auto; border-collapse: collapse; border: 2px solid #eff1f4;}
		.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center; width : 550px; 
			border-radius: 5px; background-color: #eff1f4; }
		h2 { padding-bottom: 23px; }	
	</style>
</head>
<%
	if(session.getAttribute("sId") == null || !session.getAttribute("sId").equals("admin")){%>
		<script>
			alert("관리자 전용페이지입니다.");
			window.location = 'main.jsp';
		</script>
<%	}else{%>
<body>
	<br/>
	<h1 align="center" style="margin-bottom: 0; color: #3e6383;">관리자님 환영합니다!</h1>
	<br /><br />
	<h1 align="center"><button class="listButt" onclick="window.location.href='main.jsp'">메인으로</button></h1>
	<div class="table2">
		<table class="list2">
			<tr>
				<td width="200"><h2 align="center" style="margin-bottom: 0; color: #3e6383;"><a href = 'adminManager.jsp'>전체 회원 관리</a></h2></td>
			</tr>
		</table>
	</div>	
		<br/>
	<div class="table2">	
		<table class="list2">
			<tr>
				<td>게시판 관리</td>
			</tr>
			<tr>
				<td><h2 align="center" style="margin-bottom: 0; color: #3e6383;"><a href = 'getpetList.jsp'>펫시터 예약 게시판 관리</a></h2></td>
			</tr>
			<tr>
				<td><h2 align="center" style="margin-bottom: 0; color: #3e6383;"><a href = 'tradeList.jsp'>거래 게시판 관리</a></h2></td>
			</tr>
			<tr>
				<td><h2 align="center" style="margin-bottom: 0; color: #3e6383;"><a href = 'boardList.jsp'>자유 게시판 관리</a></h2></td>
			</tr>
			<tr>
				<td><h2 align="center" style="margin-bottom: 0; color: #3e6383;"><a href = 'commentList.jsp'>펫시터 후기 게시판 관리</a></h2></td>
			</tr>
			<tr>
				<td><h2 align="center" style="margin-bottom: 0; color: #3e6383;"><a href = 'qnaForm.jsp'>QnA 게시판 관리</a></h2></td>
			</tr>
		</table>
		<br/>
	</div>
</body>
<%	} %>
</html>