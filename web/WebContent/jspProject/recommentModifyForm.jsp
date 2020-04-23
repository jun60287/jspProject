<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.pet.model.CommentbDTO"%>
<%@page import="web.pet.model.CommentbDAO"%>
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
	
	
	//쿠키세션검사 완료.
	//비로그인 시 경고창 -> loginFrom.jsp로 보내기
	
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(Cookie c : coo){
			if(c.getName().equals("cId")) cId = c.getValue();
		}		
	}

	
	String pageNum = "1";
	if(request.getParameter("pageNum") != null)	pageNum = request.getParameter("pageNum");
	int num = 0; 

	if(cId != null) {
		session.setAttribute("sId", cId);
		sId = cId;
	}
	
	if(sId == null){%>
		<script>
			alert("로그인 후 이용 가능한 페이지입니다.");
			window.location.href="loginForm.jsp";
		</script>
	<%}else if(request.getParameter("num") == null){%>
		<script>
			alert("접근오류.");
			window.location.href="main.jsp";
		</script>
		
		
		
		
	<%}else{
	
		num = Integer.parseInt(request.getParameter("num"));
		CommentbDAO dao = new CommentbDAO();
		CommentbDTO comment = dao.getComment(num);	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
	%>	
	<body>
		<br/>
		<h2 align="center" style="margin-bottom: 0; color: #3e6383;">수정하기</h2>
		<form name="commentWrite" action="recommentModifyPro.jsp?num=<%=num %>&pageNum=<%=pageNum %>" method="post" encType="multipart/form-data">
		<input type="hidden" name="num" value="<%=num %>"/>
		<input type="hidden" name="pageNum" value="<%=pageNum %>"/>
		<br/><br/>
			<div class="table2">
				<table id="list">
					<tr>
						<td colspan="2">펫시터 : <%=comment.getName() %> &nbsp; 작성일 : <%= sdf.format(comment.getReg())%></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><h2><input class="text" type="text" name="subject" value="<%=comment.getSubject() %>" size="50px"/></h2></td>			
					</tr>
					<tr>
						<td >내용 </td>
						<td>
						<input class="text" type="file" name="img" /><br/>
						<%if(comment.getImg() != null){%>
							<img src="/web/commentImg/<%=comment.getImg() %>" width="400" /><br/>
						<% }%>
						<textarea name="content" rows="8" cols="70">
						<%=comment.getContent() %></textarea>
						</td>
					</tr>			
					<tr>
						<td colspan="2">
						<%				
							if(sId != null && sId.equals(comment.getId())){%>
							<input class="listButt" type="submit" value="수정하기"/>
							<input class="listButt" type="button" value="삭제하기" onclick="window.location.href='recommentDeleteForm.jsp?num=<%=comment.getNum()%>'"/>
							<%}	%>
						</td>
					</tr>
				</table>	
			</div>
		</form>
	</body>

<%} %>
</html>