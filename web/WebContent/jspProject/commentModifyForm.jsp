<%@page import="web.pet.model.CommentbDAO"%>
<%@page import="web.pet.model.CommentbDTO"%>
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
	function searchId(){
		var url = "commentWriteNameSearch.jsp";
		open(url, "펫시터 검색", "toolbar=no, status=no, menubar=no, scrollbars=no, resizalbe=no, width=400px, height==300px");
	}
</script>
</head>
<%
	
	
	//쿠키세션검사 완료.
	//비로그인 시 경고창 -> loginFrom.jsp로 보내기
	
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(Cookie c : coo){
			if(c.getName().equals("cId")) cId = c.getValue();
		}		
	}

	
	String pageNum = "1";
	if(request.getParameter("pageNum") != null)	pageNum = request.getParameter("pageNum");
	int num = 0; 

	if(cId != null) {
		session.setAttribute("sId", cId);
		sId = cId;
	}
	
	if(sId == null){%>
		<script>
			alert("로그인 후 이용 가능한 페이지입니다.");
			window.location.href="loginForm.jsp";
		</script>
	<%}else if(request.getParameter("num") == null){%>
		<script>
			alert("접근오류.");
			window.location.href="main.jsp";
		</script>
		
		
		
		
	<%}else{
		num = Integer.parseInt(request.getParameter("num"));
		CommentbDAO dao = new CommentbDAO();
		CommentbDTO comment = dao.getComment(num);	
		String[] petdate = comment.getPetdate().split(" ");
	%>	
	<body>
		<br/><br/>
		<h2 align="center" style="margin-bottom: 0; color: #3e6383;">수정하기</h2>
		<form name="commentWrite" action="commentModifyPro.jsp?num=<%=num %>&pageNum=<%=pageNum %>" method="post" encType="multipart/form-data">
			<input type="hidden" name="num" value="<%=num %>" />
			<input type="hidden" name="ref" value="<%=comment.getRef() %>" />
			<input type="hidden" name="re_step" value="<%=comment.getRe_step() %>" />
			<br/><br/>
			<div class="table2">
				<table id="list">
					<tr>
						<td>지역</td>
						<td align="left"><select class="sel" name="area">
								<option value="<%=comment.getArea()%>" selected><%=comment.getArea()%></option>
								<option value="강원도">강원도</option>
								<option value="경기도">경기도</option>
								<option value="경상남도">경상남도</option>
								<option value="경상북도">경상북도</option>
								<option value="광주">광주</option>
								<option value="대구">대구</option>
								<option value="대전">대전</option>
								<option value="부산">부산</option>
								<option value="울산">울산</option>
								<option value="인천">인천</option>
								<option value="서울">서울</option>
								<option value="세종">세종</option>
								<option value="전라남도">전라남도</option>
								<option value="전라북도">전라북도</option>
								<option value="충청남도">충청남도</option>
								<option value="충청북도">충청북도</option>
								<option value="제주도">제주도</option>
							</select></td>
						<td>펫시터</td>
						<td align="left">
							<input class="text" type="text" name="name" value="<%=comment.getName() %>"readonly/>
							<input class="listButt" type="button" value="검색" onclick="searchId()"/>
						</td>
					</tr>
					<tr>
						<td>이용날짜</td>
						<td colspan="3" align="left">
						<input class="text" type="date" name="petdate" value="<%=petdate[0]%>"/>
						<select class="sel" name="petday">
							<option value="<%=comment.getPetday()%>" selected><%=comment.getPetday()%></option>
							<option value="하루">하루</option>
							<option value="1박2일">1박2일</option>
							<option value="2박3일">2박3일</option>
							<option value="3박 이상">3박 이상</option>
							<option value="일주일">일주일</option>
							<option value="장기">장기</option>
						</select>
						</td>
					</tr>
					<tr>
						<td>만족도</td>
						<td colspan="3">
						<% for(int i = 5; i > 0; i--){%>
							<input type="radio" name="point" value="<%=i %>" 
							<%if(i == comment.getPoint()) {%> checked <%}%>
							/><%=i %>
						<%}%>
						</td>
					</tr>
					<tr>
						<td>제목</td>
						<td align="left" colspan="3"><input class="text" type="text" name="subject" value="<%=comment.getSubject() %>" size="60"/></td>
					</tr>
					<tr>
						<td align="left" colspan="4">
							<input class="text" type="file" name="img" /><br/>
							<%if(comment.getImg() != null){%>
							<img src="/web/save/<%= comment.getImg()%>" width="400" />		
							<%}%>
						</td>
					</tr>
					<tr>
						<td colspan="4">	
							후기<br/>
							<textarea name="content" rows="10" cols="70"><%=comment.getContent() %></textarea>
						</td>
					</tr>
				</table>
				<br/>
				<input class="listButt" type="submit" value="수정하기" />
				<input class="listButt" type="button" value="뒤로가기" onclick="window.location.href='commentContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>'"/>
				<br/><br/>
			</div>
		</form>
		<br/><br/>
	</body>
<%  }%>

</html>