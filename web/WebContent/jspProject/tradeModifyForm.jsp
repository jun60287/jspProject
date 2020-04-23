<%@page import="web.pet.model.TradeDTO"%>
<%@page import="web.pet.model.TradeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 수정</title>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
	<link href="xListStyle.css" rel="stylesheet" type="text/css" />
	<style>
		.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center;
			border-radius: 5px; background-color: #eff1f4; width: 650px; }
		#list { width: 600px;}
	</style>
</head>
<%
	//# 로그인 상태 확인하고 페이지 처리
	String num1 = request.getParameter("num");
	///////////////////////////현재수정
	if(session.getAttribute("sId") == null||num1 == null) { %>
		<script>
			alert("잘못된 접근입니다.");
			window.location="main.jsp";
		</script>	
<%	}else{
	
	String id = (String)session.getAttribute("sId");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	TradeDAO dao = new TradeDAO();
	TradeDTO article = dao.getArticle(num);
%>
<body>
	<br/><br/>
	<h2 align="center" style="margin-bottom: 0; color: #3e6383;">수정하기</h2>
	<form action = "tradeModifyPro.jsp?pageNum=<%=pageNum %>" method = "post" enctype = "multipart/form-data">
		<input type = "hidden" name = "num" value = "<%= num %>" />
		<br/><br/>
		<div class="table2">
			<table id="list">
				<tr>
					<td>아이디</td>
					<td><%= id %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td align = "left"><input class="text" type = "text" name = "subject" SIZE="60PX;" /></td>
				</tr>
				<tr>
					<td>지  역</td>
					<td align = "left">
	                <select id="sel" name = "local">
	                    <option value = "경기도" selected>경기도</option>
	                    <option value = "강원도">강원도</option>
	                    <option value = "경상북도">경상북도</option>
	                    <option value = "경상남도">경상남도</option>
	                    <option value = "충청북도">충청북도</option>
	                    <option value = "충청남도">충청남도</option>
	                    <option value = "전라북도">전라북도</option>
	                    <option value = "전라남도">전라남도</option>
	                    <option value = "제주도">제주도</option>
	                    <option value = "서울특별시">서울특별시</option>
	                    <option value = "인천광역시">인천광역시</option>
	                    <option value = "대전광역시">대전광역시</option>
	                    <option value = "세종특별시">세종특별시</option>
	                    <option value = "광주광역시">광주광역시</option>
	                    <option value = "대구광역시">대구광역시</option>
	                    <option value = "부산광역시">부산광역시</option>
	                    <option value = "울산광역시">울산광역시</option>
	                </select>
	            	</td>
				</tr>
				<tr>
					<td>내  용</td>
					<td align = "left"><textarea rows = "20" cols = "70" name = "content"></textarea></td>
				</tr>
				<tr>
					<td>사  진</td>
					<td align = "left">
						<input class="text" type = "file" name = "picture" />
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td align = "left"><input class="text" type = "password" name = "pass" /></td>
				</tr>
				<tr>
					<td colspan = "2" align = "right">
						<input class="listButt" type = "submit" value = "저장" />
						<input class="listButt" type = "reset" value = "재작성" />
						<input class="listButt" type = "button" value = "리스트보기" onclick = "window.location = 'tradeList.jsp?pageNum=<%=pageNum %>'" />
					</td>
				</tr>
			</table>
		</div>	
	</form>
	<br/><br/>
</body>
<%	} %>
</html>