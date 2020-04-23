<%@page import="web.pet.model.TradeDAO"%>
<%@page import="web.pet.model.TradeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 메인페이지</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
<link href="xListStyle.css" rel="stylesheet" type="text/css" />
</head>
<%	
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("sId");
	
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(Cookie c : coo){
			if(c.getName().equals("cId")) cId = c.getValue();
		}		
	}
	if(cId != null) {
		session.setAttribute("sId", cId);
		id = cId;
	}
	
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	
	List articleList = null;
	TradeDAO dao = new TradeDAO();
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	
	if(sel != null && search != null) {
		count = dao.getSearchArticleCount(sel,search);	//  검색된 글 수
		if(count > 0){
			articleList = dao.getSearchArticles(startRow, endRow, sel, search); //  검색된 글 리스트받기
		}
	}else{
		// # 일반 전체 목록 
		count = dao.getArticleCount();		
		if(count > 0) {						
			articleList = dao.getArticles(startRow, endRow);	
		}
	}
	// 게시판에 뿌려줄 글번호 담기
	number = count - (currentPage - 1) * pageSize;
%>
<body>
	<header>
		<jsp:include page="petHeader.jsp" flush="false"/>
	</header>
	<section>
		<h1 align="center" style="margin-bottom: 0; color: #3e6383;"> 애견용품 거래 </h1>
		<br/><br/>
		<%-- 게시글 없을때와 있을때로 구분해서 처리 --%>
		<div class="table">
		<table id="list">
		<% if(count == 0) {%>
			<tr>
				<td><button class="listButt" onclick="window.location='tradeWriteForm.jsp'">글쓰기</button></td>
			</tr>
			<tr>
				<td align="center">게시글이 없습니다.</td>
			</tr>
		<%}else{ %>
			<tr>
			<%if(session.getAttribute("sId") != null){ %>
				<td colspan="7" align="right">
					<button class="listButt" onclick="window.location='tradeWriteForm.jsp'">글쓰기</button>
				</td>
			<%}else{%>		
				<td colspan="7" align="right"><button class="listButt" onclick="window.location='tradeWriteForm.jsp'">글쓰기</button></td>
			<%} %>
			</tr>
			<tr>
				<td width="50px">번호</td>
				<td width="50px">답글여부</td>
				<td width="400px">제  목</td>
				<td width="50px">지  역</td>
				<td width="50px">작성자</td>
				<td width="100px">시  간</td>
				<td width="50px">조회수</td>
			</tr>
			<%-- 게시글 반복해서 뿌려주기 --%>
			<% for(int i = 0; i < articleList.size(); i++){
				TradeDTO article = (TradeDTO)articleList.get(i);
			%>
			<tr>
				<td><%=number-- %></td>
				<td>
					<%	// 댓글은 제목 들여쓰기
						int wid = 0;
						if(article.getRe_level() > 0) {
							for(int j = 0; j < article.getRe_level(); j++ ){ %>
							<img src="img/replyImg.png" width="11"/>
						<%	}%>
					<%	}%>
				</td>
				<td>
					<a href="tradeContent.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage %>&from=tradeList"><%=article.getSubject() %></a>
				</td>
				<td><%=article.getLocal() %></td>
				<td><%=article.getId() %></td>
				<td><%=sdf.format(article.getTime()) %></td>
				<td><%=article.getReadcount() %></td>
			</tr>
			<%}%>
		<%} %>
		</table>
		</div>
		<%-- 목록의 페이지번호 뷰어 설정 --%>
		<div class="view" align="center">
			<br />
		<%
			if(count > 0){
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				int pageBlock = 10;			
				int startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
				int endPage = startPage + pageBlock - 1;
				if(endPage > pageCount) endPage = pageCount;
	
				if(startPage > pageBlock){ %>
					<a class="view" href="tradeList.jsp?pageNum=<%= startPage-pageBlock %>" > &lt; </a>
				<%}
				for(int i = startPage; i <= endPage; i++){ %>
					<a class="view" href="tradeList.jsp?pageNum=<%=i %>" name="list"> &nbsp; <%=i %> &nbsp; </a>
				<%}
				if(endPage < pageCount){ %>
					<a class="view" href="tradeList.jsp?pageNum=<%= startPage+pageBlock %>" > &gt; </a>
				<%}
			}
		%>
			<br /><br />
			<%-- # 작성/내용 검색   --%>
			<form action="tradeList.jsp" >
				<select name="sel"  id="sel">
					<option value='local'>지역</option>
				    <option value='id'>작성자</option>
				    <option value='subject'>제목</option>
				    <option value='content'>내용</option>
				</select>
				<input class="text" type="text" name="search" />
				<input type="submit" value="검색" />
			</form>
			<br />
			<button class="button" onclick="window.location='main.jsp'">메인 페이지로</button>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
	</section>
	<footer>
		<jsp:include page="petFooter.jsp" flush="false"/>
	</footer>
</body>
</html>