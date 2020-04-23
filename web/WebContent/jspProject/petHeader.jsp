<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap&subset=korean" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
<link href="xListStyle.css" rel="stylesheet" type="text/css" />
<style>
	body{
		width: 900px; margin: 0 auto; background-color: #f3f8fa; FONT-FAMILY: 맑은 고딕,verdana,tahoma; 
	}
	.mainA { margin:0 auto; color:#6175b3; font-size:45px; font-family: 'Do Hyeon', sans-serif; 
		border-radius: 30px; height:55px; width:300px; text-align: center; background-color: #eff1f7; padding-bottom: 8px;
		font-weight: lighter;
	}
	#headerDiv{
		text-align: right; width: 870px;
	}
	.headerB{
		HEIGHT: 30px; font-size: 14px; BORDER: 1px solid #eff1f7; COLOR: #6175b3; FONT-FAMILY: 맑은 고딕,verdana; BACKGROUND-COLOR: #eff1f7;
		margin-top:7px; border-radius: 3px;
	}
	.HeaderMenu{
		display: inline-block; background-color: #dfe3ef; width: 140px; height: 38px; margin: 17px;
        padding-top: 10px; text-align: center; font-size: 17px; color : #6175b3;
        border-radius: 5px; FONT-FAMILY: 맑은 고딕,verdana,tahoma; font-weight: bolder;
	}
	
	.mainA:link {text-decoration:none;color:#6175b3}
	.mainA:hover{text-decoration:none;color:#6175b3}
	.mainA:visited{text-decoration:none; color:#6175b3;}

	.HeaderMenu:focus{ background-color:black; }
</style>
</head>
<%
	//세션 쿠키 검사 완료.
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(int i = 0; i < coo.length; i++){
			if(coo[i].getName().equals("cId")) cId = coo[i].getValue();
		}
	}
	if(sId == null && cId != null) response.sendRedirect("loginPro.jsp");

%>
<body>
	<div id="headerDiv" >
		<% if(sId == null && cId == null){//로그인상태X -> 로그인/회원가입 버튼생성%>
			<button class="headerB" onclick="window.location.href='loginForm.jsp'">로그인</button>
			<button class="headerB" onclick="window.location.href='signupForm.jsp'">회원가입</button>
		<% }else{ //로그인상태 -> 마이페이지/로그아웃 버튼생성
				if(sId != null && sId.equals("admin")){ %>
			<button class="headerB" onclick="window.location.href='adminPage.jsp'">관리자페이지</button>
			<% 	}else{ %>
			<button class="headerB" onclick="window.location.href='mypage.jsp'">마이페이지</button>
			<%	} %>
			<button class="headerB" onclick="window.location.href='logout.jsp'">로그아웃</button>
		<% } %>
	</div>
	<br/>
	<h1 class="mainA"><a class="mainA" href="main.jsp">펫 플레닛</a></h1>
	<br/>
	<br/>
	<a href="getpetList.jsp"><div class="HeaderMenu" >펫시터 예약하기</div></a> 
	<a href="tradeList.jsp"><div class="HeaderMenu" >애견 용품 거래</div></a> 
	<a href="boardList.jsp"><div class="HeaderMenu" >커뮤니티</div></a> 
	<a href="commentList.jsp"><div class="HeaderMenu" >펫시터 이용 후기</div></a> 
	<a href="qnaForm.jsp"><div class="HeaderMenu" >QnA</div></a> 
</body>
</html>