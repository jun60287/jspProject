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
	#list { width:200px; margin:0 auto; }
	.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center; width : 300px; 
		border-radius: 5px; background-color: #eff1f4; }
</style>
</head>
<%
//세션쿠키검사 완료
//세션있거나 쿠키 있으면 경고창띄운 후 -> Pro보내기

	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(Cookie c : coo ){
			if(c.getName().equals("cId")) cId = c.getValue();
		}
	}

	if(sId != null || cId != null){%>
		<script>
			alert("이미 로그인 상태입니다.");
			window.location.href="main.jsp";
		</script>
	<%}%>
<body>
	<br/>
	<br/>
	<br/>
	<h1 align="center" style="margin-bottom: 0; color: #3e6383;">로 그 인</h1>
	<form action="loginPro.jsp" method="post">
		<br/>
		<br/>
		<div class="table2">
			<table id="list">
				<tr>
					<td width="250px">
						<br/>
						아이디 : <br/>
						<input class="text" type="text" name="id" autofocus/>
						<br/><br/>
						패스워드 : <br/>
						<input class="text" type="password" name="pw" />
						<br/><br/>
						<input type="checkbox" name="auto" />자동로그인
						<br/>
						<br/>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<br/>
		<div align="center">
			<input class="listButt" type="submit" value="로그인" />
			<input class="listButt" type="button" value="회원가입" onclick="window.location.href='signupForm.jsp'"/>
		</div>
	</form>

</body>
</html>