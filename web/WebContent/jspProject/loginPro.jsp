<%@page import="web.pet.model.PetmemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String auto = request.getParameter("auto");

	
	//세션쿠키 검사완료
	//loginForm에서 넘어온 경우가 아니면(주소만 치고 들어왔을 경우) id 와 pw값이 null이다
	if(id == null && pw == null){ 
		//세션없고 쿠키만 있으면 -> 세션 만들고 -> 메인
		//세션있으면 -> 접근오류 경고창 -> 메인
		//둘다 없으면 -> 접근오류 경고창 -> 메인
		//둘다 있으면 -> 접근오류 경고창 -> 메인
		String sId = (String)session.getAttribute("sId");
		String cId = null;
		Cookie[] coo = request.getCookies();
		if(coo != null){
			for(int i = 0; i < coo.length; i++){
				if(coo[i].getName().equals("cId")) cId = coo[i].getValue();
			}
		}
		
		if(sId == null && cId != null){  //쿠키만 존재할 경우
			session.setAttribute("sId", cId);	//세션생성
			%>
			<script>
			alert("접근오류");
			window.location.href="main.jsp";
			</script>
			<%
		}else if(sId != null){	//세션이 존재할 경우
			response.sendRedirect("main.jsp");
		}
		
	%>
		<script>
			alert("접근 오류");
			window.location.href="main.jsp";
		</script>
	<%
	}
	
	PetmemberDAO dao = new PetmemberDAO();
	boolean b = dao.login(id, pw);
	
	if(b){
		session.setAttribute("sId", id);
		if(id.equals("admin")){
			session.setAttribute("admin", id);
		}
		if(auto != null){
			Cookie c = new Cookie("cId", id);
			c.setMaxAge(60*60*24);
			response.addCookie(c);
		}		
		response.sendRedirect("main.jsp");
	}else{ %>
	<script>
		alert("아이디와 패스워드를 확인하세요.");
		history.go(-1);
	</script>	
		
		
<% 	}
%>
<body>

</body>
</html>