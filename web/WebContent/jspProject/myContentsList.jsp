<%@page import="web.pet.model.QNADTO"%>
<%@page import="web.pet.model.QNADAO"%>
<%@page import="java.util.List"%>
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
	.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center; width : 550px; 
		border-radius: 5px; background-color: #eff1f4; }
	#list4{ margin:0 auto; width:500px;border-collapse: collapse; border: 2px solid #eff1f4; }
</style>
</head>
<%      
   request.setCharacterEncoding("UTF-8");
   QNADAO dao = new QNADAO();
   String id = (String)session.getAttribute("sId");
   List list = dao.getMyContents(id);
   int number = dao.countMyContents(id); 
   
   
   if(id == null){
      %> 
      <script>
      alert('로그인이 필요한 서비스');location.href="main.jsp";
      </script>
   <%
   }else{
%>
<body>
<header>
		<jsp:include page="petHeader.jsp" flush="false"/>
	</header>
	<div id="wrapper">
		<aside class="aside">
			<jsp:include page="mypageAside.jsp" flush="false"/>
		</aside>
		<section class="section">
			<br><br>
			<h2 align="center" style="margin-bottom: 0; color: #3e6383;">내가 쓴 글</h2>
			<br><br>
			<div class="table2">
				<br/>
				<table id="list4">
					<tr>
						<td>no</td>
						<td width="350px">제목</td>
						<td>작성날짜</td>
					</tr>
				<% 	
					if( list != null){
						for(int i = list.size()-1; i > -1 ; i--){
							QNADTO article = (QNADTO)list.get(i);
							%>
						<tr>
					<form action = "myContentsForm.jsp">		
							<td><%=number-- %></td>
							<td>	
								<a href="boardContent.jsp?num=<%=article.getNum()%>"><%=article.getSubject() %></a>
								<%-- <input type="hidden" name = "num" value = "<%=article.getNum()%>"> --%>
							</td>
					</form>			
							
							
					<td><%=article.getReg() %></td>
						
					</tr>
					<%}%>
				</table>
				<br/>
			</div>	
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
		</section>
		</div>	
		<footer id="footer">
			<jsp:include page="petFooter.jsp" flush="false"/>
		</footer>
	</body>
	<%}else{ %>
	<script>alert("작성된 글이 없습니다.");history.back();</script>
	<%}
	}%>
</html>