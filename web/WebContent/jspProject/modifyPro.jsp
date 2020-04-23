<%@page import="web.pet.model.PetmemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
//세션쿠키검사 완료
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="member" class="web.pet.model.PetmemberDTO"/>
<jsp:setProperty property="*" name="member"/>

<%
	if(member.getPw() == null){%>
		<script>
			alert("접근 오류.");
			window.location.href="main.jsp";
		</script>
	<%}else{
		PetmemberDAO dao = new PetmemberDAO();
		dao.modifyPetmember(member);
	%>	
		
	<body>
	
		<script type="text/javascript">
			alert("수정이 완료 되었습니다.");
			history.go(-1);
		</script>
	
	</body>
<%	}%>
</html>