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
	#list { width: 300px; margin:0 auto;  border-collapse: collapse;}
</style>
</head>
<%
	//세션쿠키검사완료
	String sId = (String)session.getAttribute("sId");	
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(int i = 0; i < coo.length; i++){
			if(coo[i].getName().equals("cId")) cId = coo[i].getValue();
		}
	}
	if(sId == null && cId != null){ 
		session.setAttribute("sId", cId);
		sId = cId;
	}
	
	int num = 0;
	
	if(request.getParameter("num") == null || sId == null){%>
		<script>
			alert("접근 오류.");
			window.location.href="main.jsp";
		</script>
	<%}else{ 
		num = Integer.parseInt(request.getParameter("num"));
	%>
		<body>
			<br/><br/>
			<form action="getpetDeletePro.jsp" method="post">
			<input type="hidden" name="num" value="<%=num%>"/>
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
	<%} %>
</html>