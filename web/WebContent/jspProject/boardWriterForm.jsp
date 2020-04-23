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
			border-radius: 5px; background-color: #eff1f4; width: 650px; }
		#list { width: 600px;}
	</style>
</head>
<%
	int num = 0;
	String id = (String)session.getAttribute("sId");
	String cid = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(int i = 0; i < coo.length; i++){
			if(coo[i].getName().equals("cid")) cid = coo[i].getValue();
		}
	}
	
	if(id == null && cid == null){%>
		<script>
			alert("로그인 후 이용하실수 있습니다.");
			window.location.href="loginForm.jsp";
		</script>
<%	}else{
		if(id == null && cid != null){
			session.setAttribute("sId", cid);
			id = cid;
		}
	}
%>
<body>
	<form action="boardWriterPro.jsp" name = "input" method = "post" encType = "multipart/form-data">
		<br/><br/>
		<input type = "hidden" name = "num" value = "<%=num %>">
		<h2 align="center" style="margin-bottom: 0; color: #3e6383;">글쓰기</h2>
		<br/>
		<br/>
		<div class="table2">
			<table id="list">
				<tr>
					<td>아이디</td>
					<td><%= id %></td>
				</tr>
				<tr>	
					<td>제목</td>
					<td><input class="text" type = "text" name = "subject" size="50px"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
					<textarea rows="20" cols="70" name="content"></textarea>
					</td>
				</tr>
				<tr>
					<td>사진</td>
					<td align = "left">
					<input class="listButt" type = "File" name = "photo">
					</td>
				</tr>
				<tr>
					<td colspan = "2">
						<input class="listButt" type = "submit" value = "저장">
						<input class="listButt" type = "reset" value = "다시쓰기">
						<input class="listButt" type = "button" value = "리스트" onclick ="window.location='boardList.jsp'">
					</td>
				</tr>
				
			</table>
		</div>	
	</form>
	<br/><br/>
</body>
</html>