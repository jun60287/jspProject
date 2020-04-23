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
	.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center;
		border-radius: 5px; background-color: #eff1f4; width: 650px; }
	#list { width: 600px; margin:0 auto;  border-collapse: collapse;}
</style>
<script>
	function check(){
		var comment = document.recommentWrite;
		if(!comment.subject.value){
			alert("제목을 입력하세요.");
			return false;
		}
		if(!comment.content.value){
			alert("내용을 입력하세요.");
			return false;
		}
	}
</script>
</head>
<% 
	//쿠키세션검사
	//비로그인 시 경고창 -> loginFrom.jsp로 보내기
	
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(Cookie c : coo){
			if(c.getName().equals("cId")) cId = c.getValue();
		}		
	}
	//commentList에서 넘어온 데이터들 저장해놓기 (없으면 접근오류)
	int num = 0, ref = 0, re_step = 0;
	String name = null;
	if(request.getParameter("num") != null || request.getParameter("ref") != null || request.getParameter("re_step") != null){
		num = Integer.parseInt(request.getParameter("num"));
		name = request.getParameter("name"); 
		ref = Integer.parseInt(request.getParameter("ref")); 
		System.out.println(ref);
		re_step = Integer.parseInt(request.getParameter("re_step")); 
	}else{%>
		<script>
			alert("접근오류.");
			window.location.href="main.jsp";
		</script>
	<%}
	//세션쿠키검사 완료
	if(cId != null) {
		session.setAttribute("sId", cId);
		sId = cId;
	}
	if(sId == null){%>
		<script>
			alert("로그인 후 이용 가능한 페이지입니다.");
			window.location.href="loginForm.jsp";
		</script>
	<%}else{ %>
		<body>
			<br/><br/>
			<h2 align="center" style="margin-bottom: 0; color: #3e6383;">후기 답글 쓰기</h2>
			<br/>
			<br/>
			<div class="table2">
				<form name="recommentWrite" onsubmit="return check()" action="recommentWritePro.jsp" method="post" encType="multipart/form-data">	
	
					<input type="hidden" name="ref" value="<%=ref%>"/>
					<input type="hidden" name="re_step" value="<%=re_step%>"/>
					<input type="hidden" name="name" value="<%=name%>"/>
					<table id="list">
						<tr>
							<td>제목</td>
							<td align="left"><input class="text" type="text" name="subject" size="60"/></td>
						</tr>
						<tr>
							<td>내용</td>
							<td align="left">
							<input class="text" type="file" name="img" /><br/>
							<textarea name="content" rows="8" cols="70"></textarea>
							</td>
						</tr>
					</table>
					<br/>
						<input class="listButt" type="submit" value="등록하기" />
						<%String pageNum = "1";
						if(request.getParameter("pageNum") != null)	pageNum = request.getParameter("pageNum"); %>
						<input class="listButt" type="button" value="뒤로가기" onclick="window.location.href='commentList.jsp?pageNum=<%=pageNum%>'"/>
					<br/><br/>
				</form>
			</div>	
		</body>
	<%}%>
</html>

