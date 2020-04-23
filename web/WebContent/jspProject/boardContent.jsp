<%@page import="web.pet.model.BoardDTO"%>
<%@page import="web.pet.model.BoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
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
			border-radius: 5px; background-color: #eff1f4; width: 550px; }
		#list { width: 500px;}
	</style>
</head>
<script>

</script>
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
	
	if(request.getParameter("num") == null){%>
		<script>
			alert("접근 오류");
			window.location.href="main.jsp";
		</script>
	<%}else{
	int num = Integer.parseInt(request.getParameter("num"));
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
	BoardDAO dao = new BoardDAO();
	BoardDTO article = dao.getArticle(num);
	
%>
<body>
 	<header>
		<jsp:include page="petHeader.jsp" flush="false"/>
	</header>
	<section>
		<h1 align="center" style="margin-bottom: 0; color: #3e6383;"><%=article.getId() %>님의 게시물</h1>
		<br/>
		<br/>
		<div class="table2">
			<table id="list2">
				<tr	width = "300">
					<td colspan = "4">
						제목<br/>
						<h3 align="center" style="margin-bottom: 0; color: #3e6383;"><%=article.getSubject() %></h3>
						<br/>
					</td>
				</tr>
				<tr>
					<td >
						글쓴이
					</td>
					<td >
						<%=article.getId()%>
					</td>
					<td>조회수</td>
					<td><%=article.getReadcount() %></td>
				</tr>
				<tr>
					<td colspan = "4">
						<img src = /web/save/<%=article.getPhoto() %> width="400px"><br/>
						<textarea rows = "15" cols = "60" readonly ><%=article.getContent()%></textarea>
					</td>
				</tr>
				<tr>
					<td colspan = "4">
					<button class="listButt" onclick = "window.location = 'boardList.jsp'">리스트가기</button>
					<button class="listButt" onclick = "window.location = 'boardModifyForm.jsp?num=<%=article.getNum() %>'">수   정</button>
					<button class="listButt" onclick = "window.location = 'boardDeleteForm.jsp?num=<%=article.getNum() %>'">삭   제</button>
					</td>
				</tr> 
			</table>
		</div>	
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
	</section>
	<footer>
		<jsp:include page="petFooter.jsp" flush="false"/>
	</footer>
</body>
<% } %>
</html>