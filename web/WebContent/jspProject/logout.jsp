<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	
	//세션쿠키검사완료
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(int i = 0; i < coo.length; i++){
			if(coo[i].getName().equals("cId")) cId = coo[i].getValue();
		}
	}
	
	if(sId == null && cId == null){  //주소창으로 바로 접근한 경우
	%>
		<script>
			alert("접근 오류");
			window.location.href="main.jsp";
		</script>
	<%
	}else{
		session.invalidate();		//세션있으면 세션삭제
		if(cId != null){			//쿠키 있으면 쿠키 삭제
			Cookie c = new Cookie("cId", cId);
			c.setMaxAge(0);
			response.addCookie(c);
		}
		response.sendRedirect("main.jsp");
	}
	
	
%>
<body>

</body>
</html>