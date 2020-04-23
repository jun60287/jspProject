<%@page import="web.pet.model.CommentbDTO"%>
<%@page import="web.pet.model.CommentbDAO"%>
<%@page import="web.pet.model.PetsitterDAO"%>
<%@page import="web.pet.model.PetsitterDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫시터 활동내역</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
<link href="xListStyle.css" rel="stylesheet" type="text/css" />
<style>
 	#list3 {
	width: 300; margin:0 auto; text-align: center; border-collapse: collapse;
	FONT-SIZE: 11pt; COLOR: #22252e; FONT-FAMILY: 맑은 고딕,verdana,tahoma; border: 2px solid #eff1f4;
	}
	td{ padding: 3px; }

</style>
</head>

<%

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	PetsitterDAO dao = new PetsitterDAO();
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(int i = 0; i < coo.length; i++){
			if(coo[i].getName().equals("cId")) cId = coo[i].getValue();
		}
	}
	if(sId == null && cId != null){ 
		session.setAttribute("sId", cId);
		sId = cId;
	}
	PetsitterDTO article = dao.getPetsitter(sId);
	
	String pageNum = request.getParameter("pageNum");
	int num = 0;
	if(sId == null) {%>
		<script>
		alert("접근오류.");
		window.location.href="main.jsp";
		</script>
	<%}else{
	
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	
	int pagesize = 10;
	int startRow = (currentPage - 1) * pagesize + 1;
	int endRow = currentPage * pagesize;
	int count = 0;
	int number = 0;
	
	CommentbDAO dao1 = new CommentbDAO();
	String name = article.getName();
	count = dao1.sitterCommentCount(name);
	List articleList = null;
	articleList = dao1.getConmmentList1(startRow, endRow, name);
	
	number = count - (currentPage - 1) * pagesize;
%>
<body>
	<header>
		<jsp:include page="petHeader.jsp" flush="false"/>
	</header>
	<div id="wrapper">
		<aside class="aside">
			<jsp:include page="mypageAside.jsp" flush="false"/>
		</aside>
		<section class="section">
			<br/><br/>
			<h2 align="center" style="margin-bottom: 0; color: #3e6383;">펫시터 활동 내역</h2>
			<br/><br/>
			<div>
				<table id="list3">
					<tr>
						<td rowspan = "4" width = "150">
						<img src = "/web/save/<%=article.getPhoto()%>" width = "150" />
						</td>
						<td width="80px">아이디</td>
						<td  width="100px" colspan = "3">
							<%=session.getAttribute("sId") %>
						</td>
					</tr>
					<tr>
						<td>이름</td>
						<td colspan = "3">
							<%=article.getName() %>
						</td>
					</tr>
					<tr>
						<td>지역</td>
						<td colspan = "3">
							<%=article.getArea() %>
						</td>
					</tr>
					<tr>
						<td>평점</td>
						<td colspan = "3">
						<%=String.format("%.1f", article.getAvgpoint()) %>
						</td>
					</tr>
				</table>
			</div>
			<br/><br/><br/>
			<div class="table">
				<br/>
				<table id="list">
					<tr>
						<td>No.</td>
						<td>제목</td>
						<td>글쓴이</td>
						<td>날짜</td>
						<td>조회수</td>
					</tr>
					<%
					if(count == 0){%> 
						<tr>
							<td colspan = "5" align = "center">
							작성된 글이 없습니다.
							
							</td>
					<%}else{
				 	CommentbDTO comment = null;
						for(int i = 0; i < articleList.size(); i++){
							comment = (CommentbDTO)articleList.get(i);
							//String[] petdate = comment.getPetdate().split(" ");
							%>
						<tr>
								<td><%= number-- %></td>
								<td width="350">
								<h2><a href="commentContent.jsp?num=<%=comment.getNum()%>&pageNum=<%=pageNum%>&count=<%=count%>"><%= comment.getSubject() %></a></h2>
								이용날짜 :  &nbsp; <%=comment.getPetday() %> <br/>
								지역 : <%=comment.getArea() %> &nbsp; 펫시터 : <%= comment.getName() %>님 &nbsp; 만족도 :<%= comment.getPoint() %> 점
								</td>
								<td><%= comment.getId() %></td>
								<td><%= sdf.format(comment.getReg()) %></td>
								<td><%= comment.getReadcount() %></td>
							</tr>
					
					
					<%}
					}%>
					
					
				</table>
			</div>		
			<br/><br/>
			<div class="view" align="center">
				
				<%
				if(count > 0){
						int pagecount = (count / pagesize) + (count % pagesize == 0?0:1);
						int pageBlock = 5;
						int startpage = 0;
							if(currentPage % pageBlock == 0){
								startpage = (currentPage - 1 / pageBlock) * pageBlock + 1 ;
							}else{
								startpage = (currentPage / pageBlock) * pageBlock + 1;
							}
							
						int endpage = startpage + pageBlock - 1;//9
						if(endpage > pagecount) endpage = pagecount;
						
					if(startpage > pageBlock){%>
						<a class="view" href = "actpet.jsp?pageNum=<%=startpage - 1%>">&lt;</a>
					<%}
					for(int i = startpage; i <= endpage; i++){%>
						<a class="view" href = "actpet.jsp?pageNum=<%=i %>">&nbsp;<%=i %>&nbsp;</a>
					<%}
					if(endpage < pagecount){%>
						<a class="view" href = "actpet.jsp?pageNum=<%=endpage + 1%>">&gt;</a>
			<%
						}
					}
				}%>	
				
				</div>
			<br/><br/><br/><br/><br/><br/><br/><br/>
			<br/><br/><br/><br/><br/><br/><br/><br/>
			<br/><br/><br/><br/>
		</section>
	</div>	
	<footer id="footer">
		<jsp:include page="petFooter.jsp" flush="false"/>
	</footer>		
</body>
</html>