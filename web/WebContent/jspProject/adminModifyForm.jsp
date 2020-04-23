<%@page import="web.pet.model.PDTO"%>
<%@page import="web.pet.model.PDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 회원관리 - 회원정보 수정 페이지</title>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
	<link href="xListStyle.css" rel="stylesheet" type="text/css" />
	<style>
		.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center;
			border-radius: 5px; background-color: #eff1f4; width: 350px; }
		#list { width: 300px; margin: 0 auto;}
	</style>
	<script>
	function check(){
		var modifyy = document.modify;
		if(!modifyy.id.value){
			alert("아이디를 입력해주세요.");
			return false;
		}
		if(!modifyy.pw.value){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
	}
</script>
</head>
<%
	if(session.getAttribute("sId") == null || !session.getAttribute("sId").equals("admin")){%>
		<script>
			alert("관리자 전용페이지입니다.");
			location.href = "main.jsp";
		</script>
<%	}else{
		String id = request.getParameter("id");
		PDAO dao = new PDAO();
		PDTO member = dao.getAdminmember(id);
%>
<body>
	<br/>
		<br/>
	<h2 align="center" style="margin-bottom: 0; color: #3e6383;">관리자 전용 - 회원정보 수정</h2>
	<form name = "modify" action = "adminModifyPro.jsp" method = "post">
		<br/>
		<br/>
		<div class="table2">
			<table id="list">
				<tr>
					<td colspan="2"><%= id %>님의 정보를 수정중입니다.</td>
				</tr>      
				<tr>
					<td>아이디</td>	
					<td><input class="text" type = "text" name = "id" value = "<%= member.getId() %>" /></td>		
				</tr>
				<tr>
					<td>비밀번호</td>		
					<td><input class="text" type = "text" name = "pw" value = "<%= member.getPw() %>" /></td>	
				</tr>
				<tr>
					<td>이메일</td>
					<td><input class="text" type = "text" name = "email" value = "<%= member.getEmail() %>"/></td>
				</tr>
				<tr>
					<td colspan="2">
					<input class="listButt" type = "submit" value = "수정" />
					<input class="listButt" type = "button" value = "취소" onclick="history.go(-1)"/>
					</td>
				</tr>		
			</table>
		</div>
	</form>
</body>
<%	} %>
</html>