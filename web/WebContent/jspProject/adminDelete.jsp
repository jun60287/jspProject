<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 회원정보 삭제</title>
</head>
<jsp:useBean id = "manager" class = "web.pet.model.PDAO" />
<%
	String id = request.getParameter("id");
	if(session.getAttribute("sId") == null || !session.getAttribute("sId").equals("admin")){%>
	<script>
		alert("관리자 전용페이지입니다.");
		window.location = 'main.jsp';
	</script>
<%	}else{
		if(!id.equals("admin") && id != null){
			manager.deleteMemberByAdmin(id);%>
			<script>
				alert("삭제되었습니다.");
				window.location = "adminManager.jsp";
			</script>
<%		}else{%>
			<script>
				alert("id값이 없거나 잘못되었습니다.");
				window.location = "adminManager.jsp";
			</script>
<%		}
	}
%>
<body>

</body>
</html>