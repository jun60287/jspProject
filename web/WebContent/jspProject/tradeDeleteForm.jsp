<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 삭제</title>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
	<link href="xListStyle.css" rel="stylesheet" type="text/css" />
	<style>
		.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center;
			border-radius: 5px; background-color: #eff1f4; width: 350px; }
		#list { width: 300px; margin:0 auto;  border-collapse: collapse;}
	</style>
</head>
<%
	// # 로그인 상태 확인하고 페이지 처리
	String num1 = request.getParameter("num");
	///////////////////////////현재수정
	if(session.getAttribute("sId") == null || num1 == null) { %>
		<script>
			alert("잘못된 접근입니다.");
			window.location="main.jsp";
		</script>	
<%	}else{
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
%>
<body>
	<br/>
	<br/>
	<form action = "tradeDeletePro.jsp?pageNum=<%=pageNum %>" method = "post" >
		<input type = "hidden" name = "num" value = "<%=num %>" />
		<div class="table2">
			<table id="list">
				<tr>
					<td>비밀번호를 입력하세요.<br/><br/>
					<input class="text" type="password" name="pw" />
					</td>
				</tr>
				<tr>
					<td>
						<input class="listButt" type="submit" value="삭제하기"/>
						<input class="listButt" type="button" value="뒤로가기" onclick="history.go(-1)"/>
					</td>
				</tr>
			</table>
		</div>	
	</form>
</body>
<%	} %>
</html>