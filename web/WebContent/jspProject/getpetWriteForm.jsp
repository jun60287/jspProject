<%@page import="web.pet.model.PetsitterDTO"%>
<%@page import="web.pet.model.GetpetDAO"%>
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
	#list { width: 600px; margin:0 auto;  border-collapse: collapse;}
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

	if(sId == null && cId == null){	%>
		<script>
			alert("로그인 후 사용가능한 페이지입니다.");
			window.location.href="main.jsp";
		</script>	
<%	}else if(sId == null && cId != null){
		session.setAttribute("sId", cId);
		sId = cId;
	}
	
// 회원이 펫시터인지 아닌지 검사
	GetpetDAO dao = new GetpetDAO();
	PetsitterDTO sitter = dao.getSitter(sId);

	if(sitter == null){ %>
	<script>
		alert("펫시터 등록 후 이용 가능한 페이지입니다.");
		window.location.href="getpetList.jsp";
	</script>	
<% }else{ %>
	<body>
		<br/><br/>
		<h2 align="center" style="margin-bottom: 0; color: #3e6383;">펫시터 글 등록하기</h2>
		<br/>
		<br/>
		<div class="table2">
			<form action ="getpetWritePro.jsp" method="post" encType="multipart/form-data">
				<input type="hidden" name="area" value="<%=sitter.getArea()%>"/>
				<input type="hidden" name="petsit" value="<%=sitter.getPetsit() %>"/>
				<input type="hidden" name="name" value="<%=sitter.getName() %>"/>
				<table id="list">
						<tr>
							<td>
							이름 : <%=sitter.getName() %> <br/>
							지역 : <%=sitter.getArea() %>
							</td>
						</tr>
						<tr>
							<td>펫시터 횟수 : <%=sitter.getPetsit() %> 평점 : <%=sitter.getPoint() %></td>
						</tr>
						<tr>
							<td>제목 : <br/>
							<input class="text" type="text" name="subject" size="50px"/></td>
						</tr>
						<tr>
							<td>내용 : <br/>
							이미지 등록 : <input class="text" type ="file" name="img" /><br/>
							<textarea rows="20" cols="70" name="content"></textarea></td>
						</tr>
						<tr>
							<td>
							<input class="listButt" type="submit" value="등록" />
							<input class="listButt" type="button" value="뒤로가기" onclick="history.go(-1)" />
							</td>
						</tr>
					</table>
				</form>
			</div>	
		<br/><br/>
	</body>

<%
} %>
</html>