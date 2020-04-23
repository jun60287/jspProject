<%@page import="web.pet.model.TradeDTO"%>
<%@page import="web.pet.model.TradeDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 내용 페이지</title>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
	<link href="xListStyle.css" rel="stylesheet" type="text/css" />
	<style>
		.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center;
			border-radius: 5px; background-color: #eff1f4; width: 550px; }
		#list { width: 500px;}
	</style>
</head>
<%
	String id = (String)session.getAttribute("sId");
	String num1 =request.getParameter("num");
	
	///////////////////////////현재수정
	if(id == null || num1 == null ) { %>
	<script>
		alert("로그인이 필요한 서비스.");
		window.location="main.jsp";		
	</script>	
<%	}else{
	int num =Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
	
	TradeDAO dao = new TradeDAO();
	TradeDTO article = dao.getArticle(num);
%>
<body>
	<header>
		<jsp:include page="petHeader.jsp" flush="false"/>
	</header>
	<section>
	<br />
	<h1 align="center" style="margin-bottom: 0; color: #3e6383;">글 내용</h1>
	<br/><br/>
		<div class="table2">
			<table id="list2">
				<tr>
					<td colspan="2"><b><%=article.getSubject() %></b></td>
				</tr>
				<tr>
					<td colspan="2"><b><%=article.getLocal() %></b></td>
				</tr>
				<tr>
					<%-- 내용 --%>
					<td colspan="2" height="100"><%=article.getContent() %></td>
				</tr>
				<tr>
					<td>posted by <b><%= article.getId() %></b> at <%=sdf.format(article.getTime())%></td>
					<td><%=article.getReadcount() %> viewed</td>
				</tr>
				<tr>
					<td colspan="2"><b><img src="/web/save/<%=article.getPicture() %>" width="400px"/></b></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<%-- # 본인또는 admin(관리자)만 수정 삭제 가능하게 --%>
						<%if(article.getId().equals(id) || id.equals("admin")){ %>
						<%-- 수정 버튼 modifyForm으로 링크걸기 (글고유번호와 페이지 번호 함께)  --%>
						<button class="listButt" onclick="window.location='tradeModifyForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">수  정</button>
						<button class="listButt" onclick="window.location='tradeDeleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">삭  제</button>
						<%} %>
						<%-- 답글 버튼 처리 : num, ref, re_step, re_level DB에서 받은정보 보내주면서 이동--%>
						<button class="listButt" onclick="window.location='tradeWriteForm.jsp?num=<%=num%>&ref=<%=article.getRef()%>&re_step=<%=article.getRe_step()%>&re_level=<%=article.getRe_level()%>'">답  글</button>
						<% String from = request.getParameter("from"); %>
						<button class="listButt" onclick="window.location='<%=from%>.jsp?pageNum=<%=pageNum%>'">리스트</button>
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
	</section>
	<footer>
		<jsp:include page="petFooter.jsp" flush="false"/>
	</footer>
</body>
<%} %>
</html>