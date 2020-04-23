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
	.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center; width : 450px; 
		border-radius: 5px; background-color: #eff1f4; }
	#list5 {width:400px; margin:0 auto; width: 400px;  border-collapse: collapse; margin-bottom: 20px;}
</style>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("sId");
	
	Cookie [] cs = request.getCookies();
	if(cs != null && session.getAttribute("sId") == null){
		for(Cookie coo : cs){
			if(coo.getName().equals("cId")) id = coo.getValue();
		}session.setAttribute("sId", id);
	}
	
	if(id == null){
		%>
		<script>alert("로그인이 필요한 서비스");history.back();</script>
		<%
	}
	
	QNADAO dao = null;
	List petList = null;
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
			<br/><br/>
			<h2 align="center" style="margin-bottom: 0; color: #3e6383;">나의 애견</h2>
			<br/><br/>
			<form action="addpet.jsp" method="post">
			<div class="table2">
				<br/>
				<table id="list5"> 
					<tr>
						<td><input type="submit" value="검색"> </td>			
						<td colspan = "3">
							<select id="sel" name = "category">
							<option style='background:black' value ="name" >이름</option>
							<option style='background:black' value ="kind" >종류</option>
							<option style='background:black' value ="age" >나이</option>
							</select>
							<input class="text" type="text" name="keyword">				
						</td>			
					</tr>
						<%	
							String category = request.getParameter("category");
							String keyword = request.getParameter("keyword");
							dao = new QNADAO(); 				
							if(category == null){
								petList = dao.myPetList(id);
							}
							else if(category.equals("name")){					
								petList = dao.myPetListName(id, keyword);
							}
							else if(category.equals("kind")){
								petList = dao.myPetListKind(id, keyword);
							}
							else{
								petList = dao.myPetListAge(id, keyword);
							}
								for(int i = 0 ; i < petList.size() ; i ++){
								QNADTO dto = (QNADTO)petList.get(i);
								
								%>
							<tr>
								<td>이름</td>
								<td><%= dto.getName()%></td>
								<td rowspan = "3"><img src = "/web/save/<%=dto.getImg()%>" width="200"/></td>
								<td rowspan = "3"><input class="listButt" type="button" value="삭제" name=delete onclick="window.location.href='addPetDelete.jsp?hidden1=<%= i%>'">
												  <input type="hidden" value="<%= i %>" name = "hidden1">
												  									 
								</td>					
							</tr>
							<tr>
								<td>종류</td>
								<td><%= dto.getKind()%></td>
							</tr>
							<tr>
								<td>나이</td>
								<td><%= dto.getAge()%></td>
							</tr>
							<%} %>
					<tr>
						<td colspan = "4">
							<br/>
							<input class="listButt" type="button" value="펫 추가" onclick="window.location.href='addPetForm.jsp'">
							<br/><br/>							
						</td>
					</tr>	
				</table>
				</div>
		</form>
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
</html>