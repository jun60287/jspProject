<%@page import="web.pet.model.PetsitterDTO"%>
<%@page import="web.pet.model.GetpetDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.pet.model.GetpetDAO"%>
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
		border-radius: 5px; background-color: #eff1f4; width: 550px; }
</style>
</head>
<%
	//필요한 변수 세팅
	String pageNum = request.getParameter("pageNum");
	String sId = (String)session.getAttribute("sId");
	
	//( 로그인해야 글 볼 수 있도록 )세션쿠키검사 완료.
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(int i = 0; i < coo.length; i++){
			if(coo[i].getName().equals("cId")) cId = coo[i].getValue();
		}
	}
	
	if(sId == null && cId == null){ //세션쿠키 둘 다 없으면 메인으로 %>
		<script>
			alert("로그인 후 이용가능 한 페이지입니다.");
			window.location.href="getpetList.jsp";
		</script>
	<%}else if( sId == null && cId != null){ //쿠키만 존재할 경우 세션 만들어주고  sId에 값도 담아주기
		session.setAttribute("sId", cId);
		sId = cId;
	}
	int num = 0;
	if(request.getParameter("num") == null){%>
		<script>
		alert("접근 오류.");
		window.location.href="main.jsp";
		</script>
	<%}else{
		num = Integer.parseInt(request.getParameter("num"));
			
		//글 가져오는 메소드 호출
		GetpetDAO dao = new GetpetDAO();
		GetpetDTO article = dao.getpetArticle(num);
		
		//펫시터 정보가져오는 메소드 호출
		
		PetsitterDTO sitter = dao.getSitter(article.getId());
		
%>
	<body>
		<header>
			<jsp:include page="petHeader.jsp" flush="false"/>
		</header>
		<section>
			<h1 align="center" style="margin-bottom: 0; color: #3e6383;">펫시터구하기</h1>
			<br/>
			<br/>
			<div class="table2">
				<table id="list2">
					<tr>
						<td colspan="2">
						<br/>
						<img src="/web/save/<%=sitter.getPhoto()%>" width="150"/><br/>
						<h3>'<%=sitter.getName() %>'</h3>
						*지역 : <%=sitter.getArea() %>  &nbsp; *전화번호 : <%=sitter.getPhon() %>
					</tr>
					<tr>
						<td colspan="2">
						<h2 align="center" style="margin-bottom: 0; color: #3e6383;"><%=article.getSubject() %></h2></td>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							*펫시터 경력 : <%=sitter.getPetsit() %>회  &nbsp; 
							*반려견 경험 : <%=sitter.getPet() %>년  &nbsp;   	
							*평점 : <%=sitter.getPoint() %>점
							
						</td>
							
					</tr>
					<tr>
						<td colspan="2" width="400">
							소개
							<table align="center">
								<tr>
									<td width="400" height="200">
										<%  if(article.getImg() != null){ %>
										<img src="/web/save/<%=article.getImg()%>" width="400"/> <br/>
										<%  } %>
										<%=article.getContent() %> <br/>
									</td>
								</tr>
							</table>		
							<br/>	
							<a href="commentList.jsp?sel=name&search=<%=sitter.getName()%>">[ 후기보러가기 ]</a>
						</td>
					</tr>
					<% //사용자의 글이면 수정하기 삭제하기 버튼 띄우기
						//세션 아이디와, 글의 아이디가 일치하면 됨			
						if(sitter.getId().equals(sId)){
					%>
					<tr>
						<td colspan="2">
						<button class="listButt" onclick="window.location.href='getpetModifyForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">수정하기</button>	
						<button class="listButt" onclick="window.location.href='getpetDeleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">삭제하기</button>	
						</td>
					</tr>
					<% 	} %>
				</table>
			</div>
			<br/>
			<div align="center">
					<br/>
				<%	//다음글 버튼 생성하기
					//nextnum이 0보다 크면(존재하면) 다음글 버튼 생성
					int count = 0;	
					
					if(request.getParameter("count") != null){
						count = Integer.parseInt(request.getParameter("count"));	
						int realCount = dao.articleCount();
	
						if(count == realCount){
							int nextNum = dao.nextnum(num, count);
							if(nextNum > 0) { %>
							<button class="listButt" onclick="window.location.href='getpetContent.jsp?num=<%=nextNum%>&pageNum=<%=pageNum%>&count=<%=count%>'">다음글</button>	
						<% 	} %>			
							<button class="listButt" onclick="window.location.href='getpetList.jsp'">리스트보기</button>	
						<%	
							//이전글 버튼 생성하기
							//psatnum이 0 보다 크면 (존재하면) 이전글 버튼 생성
							int pastNum = dao.pastnum(num, count);
							if(pastNum > 0) {  %>
							<button class="listButt" onclick="window.location.href='getpetContent.jsp?num=<%=pastNum%>&pageNum=<%=pageNum%>&count=<%=count%>'">이전글</button>	
						<% 	}
						}else {%>
							<button class="listButt" onclick="window.location.href='getpetList.jsp?pageNum=<%=pageNum%>'">리스트보기</button>		 
					<% 	}
					}else{%>
				<button class="listButt" onclick="window.location.href='getpetList.jsp?pageNum=<%=pageNum%>'">리스트보기</button>
					<%} %>
			</div>			
		<br/>
		<br/>
		<br/>
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
<%} %>
</html>