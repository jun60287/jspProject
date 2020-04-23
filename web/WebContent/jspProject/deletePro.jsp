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
	#list { width:250px; margin:0 auto; }
	.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center; width : 300px; 
		border-radius: 5px; background-color: #eff1f4; }
</style>
</head>

<%	
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
			alert("접근오류.");
			window.location.href="main.jsp";
		</script>	
	<%	}else if(sId == null && cId != null){
		session.setAttribute("sId", cId);
		sId = cId;
	}
	String pw = request.getParameter("pw");
	
	if(pw == null){%>
		<script>
			alert("접근오류.");
			window.location.href="main.jsp";
		</script>	
<%	}else{
	
		PetmemberDAO dao =  new PetmemberDAO();
		int result = dao.deleteMember(sId, pw);
		if(result == 1) {	
			session.invalidate();
			Cookie[] cs = request.getCookies();	
			if(cs != null){	
				for(Cookie c : cs){ 
					if(c.getName().equals("cId")){	
						c.setMaxAge(0);
						response.addCookie(c);
					}
				}
			} %> 
		<body>
			<br /><br/><br/><br/><br/>
			<div class="table2">
				<table id="list">	
					<tr>
						<td>
						회원탈퇴가 완료 되었습니다.<br/><br/>
						<button class="listButt" onclick="window.location.href='main.jsp'" > 메인으로 </button> </td>
					</tr>
				</table>
			</div>	
		</body>
			
	<%	}else{	%>
			<script>
				alert("비밀번호가 맞지 않습니다.");
				history.go(-1);
			</script>
	<%	}	
	}
%>

</html>