<%@page import="web.pet.model.PetmemberDAO"%>
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
	#list { width:420px; margin:0 auto; }
	.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center; width : 430px; 
		border-radius: 5px; background-color: #eff1f4; }
</style>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(int i = 0; i < coo.length; i++){
			if(coo[i].getName().equals("cId")) cId = coo[i].getValue();
		}
	}
	
	if(sId != null || cId != null ){ %>
		<script type="text/javascript">
			alert("접근오류.");
			window.location.href="main.jsp";
		</script>
	<% }else{
		
			String id = request.getParameter("id");
			if(id == null){ %>
				<script type="text/javascript">
					alert("접근오류.");
					window.location.href="main.jsp";
				</script>
		 <% }else{ %>

			<jsp:useBean id="petmember" class="web.pet.model.PetmemberDTO" />
			<jsp:setProperty property="*" name="petmember"/>
			
			<%
				PetmemberDAO dao = new PetmemberDAO();
				dao.signup(petmember);
			%>
			<body>
				<br/>
				<br/>
				<br/>
				<h1 align="center" style="margin-bottom: 0; color: #3e6383;">회원가입</h1>
				<br/>
				<br/>
				<div class="table2">
					<table id="list">
						<tr>
							<td>
								<%=petmember.getId()%> 님 회원가입이 완료되었습니다.
								<br/>
								<br/>
								<button class="listButt" onclick="window.location.href='main.jsp'">메인으로</button>
							</td>
						</tr>
					</table>
				</div>
			</body>

		<%	}
	   } %>
</html>