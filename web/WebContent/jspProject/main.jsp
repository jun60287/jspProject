<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
<link href="xPetMain.css" rel="stylesheet" type="text/css" />
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
	<header>
		<jsp:include page="petHeader.jsp" flush="false"/>
	</header>
	<section>
		<br/>
		<br/>
		<br/>
		<div id="superMain" align="center">
			<div class="board" align="center"><a href="getpetList.jsp">
				<p class="boardList">펫시터 예약하기</p>
				<img class="arrow" src="/web/save/arrow2.png" width="30px" />
				<img src="/web/save/getpet.jpg" width="300"/>
			</a></div>
			<div class="board" align="center"><a href="commentList.jsp">
				<p class="boardList">펫시터 이용후기</p>
				<img class="arrow" src="/web/save/arrow2.png" width="30px" />
				<img src="/web/save/comment.jpg" width="300"/>
			</a></div><br/>
			<div class="board" align="center"><a href="boardList.jsp">
				<p class="boardList">커뮤니티</p>
				<img class="arrow" src="/web/save/arrow2.png" width="30px" />
				<img src="/web/save/board.jpg" width="300"/>
			</a></div>
			<div class="board" align="center"><a href="tradeList.jsp">
				<p class="boardList">애견 용품 거래</p>
				<img class="arrow" src="/web/save/arrow2.png" width="30px" />
				<img src="/web/save/trade.jpg" width="300"/>
			</a></div><br/>
			<div id="board" align="center"><a href="qnaForm.jsp">
				<p class="boardList">QnA</p>
				<img class="arrow" src="/web/save/arrow2.png" width="30px" /><br/>
				<img src="/web/save/qna.jpg" width="600"/>
			</a></div>
		</div>
			
		<br/><br/><br/>
		<br/><br/><br/>
		<br/><br/><br/>
	</section>
	<footer>
		<jsp:include page="petFooter.jsp" flush="false"/>
	</footer>

</body>
</html>