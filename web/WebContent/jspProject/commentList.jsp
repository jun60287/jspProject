
<%@page import="web.pet.model.PetsitterDAO"%>
<%@page import="web.pet.model.PetsitterDTO"%>
<%@page import="web.pet.model.CommentbDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.pet.model.CommentbDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기게시판</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
<link href="xListStyle.css" rel="stylesheet" type="text/css" />
</head>
<%
	//전체공개, 게시글도 전체공개    쿠키세션검사완료
	//글쓰기만 회원전용으로
	request.setCharacterEncoding("UTF-8");
	String admin = (String)session.getAttribute("admin");
	String sId = (String)session.getAttribute("sId");

	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(Cookie c : coo){
			if(c.getName().equals("cId")) cId = c.getValue();
		}		
	}
	if(cId != null) {
		session.setAttribute("sId", cId);
		sId = cId;
	}

	
	String pageNum = null;	
	if(request.getParameter("pageNum") != null) {
		pageNum = request.getParameter("pageNum");
	}
	else 	{pageNum = "1"; }

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	int pageSize = 10;
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize + 1;
	int endRow = currentPage*pageSize;
	int number = 0; // 게시판에 뿌려줄 글번호
	
	//전체 글 갯수 반환
	int count = 0;
	
	CommentbDAO dao = new CommentbDAO();
	List getConmmentList = null;
	
	/////////검색기능을 사용했으면 검색관련 글 뽑아주기
	
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	if(sel != null && search != null){
		count = dao.getSearchCommentCount(sel, search);
		if(count > 0){
			getConmmentList = dao.getSearchCommentList(sel, search, startRow, endRow);
		}
	}else{
		count = dao.getCommentCount();
		if(count > 0){
			getConmmentList = dao.getConmmentList(startRow, endRow);
		}
	}
	
	//현재페이지에서부터 모든 글의 수 
	number = count - (currentPage -1) * pageSize;
%>
<body>
	<header>
		<jsp:include page="petHeader.jsp" flush="false"/>
	</header>
	<section>
		<h1 id="listSub" align="center" style="margin-bottom: 0; color: #3e6383;">펫시터 이용후기</h1>
		<br/>
		<h1 align="center">
		<button class="listButt" onclick="window.location.href='getpetList.jsp'">펫시터 예약하기</button>
		<button class="listButt" onclick="window.location.href='commentWriteForm.jsp?pageNum=<%=pageNum%>'">후기작성하기</button>
		</h1>
		<div class="table">
			<table id="list">
				<tr>
					<td colspan="5" align="right">
						<form action="commentList.jsp" method="post">
							<select name="sel" id="sel">
								<option value="area">지역</option>
								<option value="name">펫시터</option>
								<option value="point">만족도</option>
							</select>
							<input class="text" type="text" name="search" />
							<input type="submit" value="검색" />
						</form>
					</td>
				</tr>
				<tr>
					<td>No.</td>
					<td width="400px">제목</td>
					<td>글쓴이</td>
					<td>날짜</td>
					<td>조회수</td>
				</tr>
			<% // 글이 없을 때
				if(count == 0){ %>
					<tr>
						<td colspan="5">작성된 글이 없습니다.</td>
					</tr>	
			<% 	}else{ //글이 있을 때 
				CommentbDTO comment = null;
				for(int i = 0; i < getConmmentList.size(); i++){
					comment = (CommentbDTO)getConmmentList.get(i);
					if(comment.getRe_step() > 0){	//답글일 때 %>
						<tr>
							<td><%= number-- %></td>
							<td width="450">
							<a href="commentContent.jsp?num=<%=comment.getNum()%>&pageNum=<%=pageNum%>&count=<%=count%>&re_step=<%=comment.getRe_step()%>">
							 &nbsp; &nbsp;
							 <img src = "img/rewriteIcon.png" width="15" /> [답글]
							 <%= comment.getSubject() %></a>
							</td>
							<td><%= comment.getName() %></td>
							<td><%= sdf.format(comment.getReg()) %></td>
							<td><%= comment.getReadcount() %></td>
							<%if(admin != null){ %> 
							<td><button onclick="window.location.href='commentDeletePro.jsp?num=<%=comment.getNum()%>'">삭제</button></td>
							<% } %>
						</tr>
						
				<% 	}else{ //새글 일 때
						String[] petdate = comment.getPetdate().split(" ");%>
							
						<tr>
							<td><%= number-- %></td>
							<td width="450">
							<h3><a href="commentContent.jsp?num=<%=comment.getNum()%>&pageNum=<%=pageNum%>&count=<%=count%>"><%= comment.getSubject() %></a></h3>
							이용날짜 : <%=petdate[0] %> &nbsp; <%=comment.getPetday() %> <br/>
							지역 : <%=comment.getArea() %> &nbsp; 펫시터 : <%= comment.getName() %>님 &nbsp; 만족도 : <%= comment.getPoint() %> 점
							</td>
							<td><%= comment.getId() %></td>
							<td><%= sdf.format(comment.getReg()) %></td>
							<td><%= comment.getReadcount() %></td>
							<%if(admin != null){ %> 
							<td><button onclick="window.location.href='commentDeletePro.jsp?num=<%=comment.getNum()%>'">삭제</button></td>
							<% } %>
						</tr>
				<%	}
			 	}
			} %>	
			</table>
		</div>
		<br/>
		<br/>
		<br/>
		<div class="view" align="center">
		<%//페이지뷰어 만들기
			if(count > 0){
				//1. 총 몇페이지 나오는지 계산
				int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);
				//2. 보여줄 페이지번호의 갯수
				int pageBlock = 5;
				//3. 현재 위치한 페이지에서 페이지 뷰어 첫번째 숫자가 무엇인지 찾기.
				int startPage = 0;
					if(currentPage % pageBlock == 0){
						startPage = (int)((currentPage-1)/pageBlock)*pageBlock+1;
					}else{
						startPage = (int)(currentPage/pageBlock)*pageBlock+1;
					}
				//4. 마지막에 보여지는 페이지뷰어에 페이지 갯수가 10 미만일 때. 마지막 페이지 번호가 endPage가 되도록.
				int endPage = startPage + pageBlock - 1;
				if(endPage > pageCount) endPage = pageCount;
				//6. startPage가 pageBlock보다 크면 '<'
				if(startPage > pageBlock){%>
				<a class="view" href="commentList.jsp?pageNum=<%=startPage-1%>"> &lt; </a>
				<%}
				//5. 페이지 반복해서 뿌려주기
				for(int i = startPage; i <= endPage; i++){%>
				<a class="view" href="commentList.jsp?pageNum=<%=i%>"> &nbsp; <%=i%> &nbsp; </a>
				<%}
				//7. endPage가 pageCount보다 작으면 '>'
				if(endPage < pageCount){%>
				<a class="view" href="commentList.jsp?pageNum=<%=endPage+1%>"> &gt; </a>
				<%}
			}%>
			<br/><br/>
			<button class="button" onclick="window.location.href='main.jsp'">메인으로</button>
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
