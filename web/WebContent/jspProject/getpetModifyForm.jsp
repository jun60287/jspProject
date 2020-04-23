<%@page import="web.pet.model.PetsitterDTO"%>
<%@page import="web.pet.model.GetpetDTO"%>
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
	//기본변수 세팅
	
	String pageNum = request.getParameter("pageNum");
	int num = 0;
	
	//num이 존재하는 경우 ( content에서 수정버튼으로 온 경우 ) 에만 수정이 가능하도록(content에서 글쓴이 본인일 경우에면 수정버튼 생성됨).
	if(request.getParameter("num") == null){%>
	<script>
		alert("접근 오류.");
		window.location.href="main.jsp";
	</script>
	<%}else{   
		num = Integer.parseInt(request.getParameter("num"));
		
		//필요한 메소드 호출 (글정보, 시터정보)
		GetpetDAO dao = new GetpetDAO();
		GetpetDTO article = dao.getContent(num);	
		PetsitterDTO sitter = dao.getSitter(article.getId());		
	%>

		<body>
			<br/><br/>
			<h2 align="center" style="margin-bottom: 0; color: #3e6383;">수정하기</h2>
			<form action ="getpetModifyPro.jsp" method="post" enctype="multipart/form-data">
				<input type="hidden" name="num" value="<%=num %>" />
				<input type="hidden" name="pageNum" value="<%=pageNum %>" />
				<br/><br/>
				<div class="table2">
					<table id="list">
						<tr>
							<td>제목 : <br/>
							<input class="text" type="text" name="subject" value="<%=article.getSubject() %>" sizs="50px"/></td>
						</tr>
						<tr>
							<td>내용 : <br/>
							이미지 변경 : <input class="text" type ="file" name="img" /><br/>
						<%  if(article.getImg() != null){ %>
								<img src="/web/save/<%=article.getImg()%>" width="400"/> <br/>
						<%  } %>
							<textarea rows="20" cols="70" name="content">
		
							<%=article.getContent() %></textarea></td>
						</tr>
						<tr>
							<td>
							<input class="listButt" type="submit" value="수정하기" />
							<input class="listButt" type="button" value="뒤로가기" onclick="history.go(-1)" />
							</td>
						</tr>
					</table>
				</div>	
			</form>
			<br/><br/>
		</body>
	<%}%>
</html>