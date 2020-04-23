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
		border-radius: 5px; background-color: #eff1f4; COLOR: #22252e;}
	#list4{ margin:0 auto; width:500px; border-collapse: collapse;border: 2px solid #eff1f4; }
</style>
</head>
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
		<h2 align="center" style="margin-bottom: 0; color: #3e6383;">애견 등록</h2>
		<br/><br/>
		<form action="addPetPro.jsp" method="post" enctype="multipart/form-data">
		<%	
			request.setCharacterEncoding("UTF-8");
			String id = (String)session.getAttribute("sId");
			
			Cookie [] cs = request.getCookies();
			if(cs != null && session.getAttribute("sId") == null){
				for(Cookie coo : cs){
					if(coo.getName().equals("cId")) id = coo.getValue();
				}session.setAttribute("sId", id);
			}
			if(id != null){
		%>
		<div class="table2">
			<table id="list4">
				<tr>
					<td>이름</td>
					<td><input class="text" type="text" name="name"></td>
					<td>이미지 등록</td>
				</tr>
				<tr>
					<td>종류</td>
					<td><input class="text" type="text" name="kind"></td>
					<td rowspan="2"><input type="file" name="img"></td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input class="text" type="text" name="age"></td>
				</tr>
				<tr>
					<td colspan = "3">
					<input class="listButt" type="submit" value="저장">
					<input class="listButt" type="button" value="펫메인페이지 이동" onclick="window.location.href='addpet.jsp'">
					</td>
				</tr>
			</table>
		</div>
		<%}else{%>
			<script>alert('로그인 필요');history.back();</script>
		<%	
			} %>
		</form>
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