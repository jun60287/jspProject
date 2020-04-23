<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
	<link href="xListStyle.css" rel="stylesheet" type="text/css" />
	<style>
		.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center;
			border-radius: 5px; background-color: #eff1f4; width: 350px; }
		#list { width: 300px;}
	</style>
</head>
<%
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(int i = 0; i < coo.length; i++){
			if(coo[i].getName().equals(cId)) cId = coo[i].getValue();
		}
	}
	if(sId == null && cId != null){
		session.setAttribute("sId", cId);
		sId = cId;
	}
	
	if(request.getParameter("num") == null || sId == null){%>
		<script>
		alert("접근 오류");
		window.location.href = "main.jsp"
		</script>	
<%	}else{
	int num = Integer.parseInt(request.getParameter("num"));
%>
<body>

	<br/>
	<br/>
	<form name = "delete" action = "boardDeletePro.jsp" method = "post" onsubmit = "return check()">
		<input type = "hidden" name = "num" value ="<%=num %>">
		<br/>
		<br/>
		<div class="table2">
			<table id="list">
			<%if(!(sId.equals("admin"))) {%>
				<tr>
					<td colspan = "2"><br/>삭제하시려면 비밀번호를 입력해주세요.</br><br/></td>			
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input class="text" type = "password" name = "pw"></td>			
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input class="text" type = "password" name = "pwre"></td>			
				</tr>
			<%}else{ %>
				<tr>
					<td colspan="2">이 게시물을 삭제하시겠습니까?</td>
				</tr>
			<%} %>
				<tr>
					<td align = "center" colspan = "2">
						<input class="listButt" type = "submit" value = "확인">
						<input class="listButt" type = "button" onclick = "window.location='boardList.jsp'" value = "리스트가기">
					</td>			
				</tr>
			</table>
		</div>	
	</form>

</body>
<%} %>
</html>