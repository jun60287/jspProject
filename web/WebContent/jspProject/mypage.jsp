
<%@page import="web.pet.model.BoardDAO"%>
<%@page import="web.pet.model.TradeDAO"%>
<%@page import="web.pet.model.QNADTO"%>
<%@page import="java.util.List"%>
<%@page import="web.pet.model.QNADAO"%>
<%@page import="web.pet.model.CommentbDAO"%>
<%@page import="web.pet.model.PetsitterDTO"%>
<%@page import="web.pet.model.PetsitterDAO"%>
<%@page import="web.pet.model.PetmemberDTO"%>
<%@page import="web.pet.model.PetmemberDAO"%>
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
	table { width: 500; margin: auto; text-align: center; border: 2px solid #eff1f4;
	FONT-SIZE: 11pt; COLOR: #22252e; FONT-FAMILY: 맑은 고딕,verdana,tahoma;  }
	.petImg { border-radius: 70px; }
	.pets { margin: 0 auto; width:180px; display: inline-block;}
</style>
</head>
<%
	//세션쿠키검사
	//세션이 있는 경우에만 진행 쿠키만 있을 경우 세션 만들어주고 진행
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(Cookie c : coo ){
			if(c.getName().equals("cId")) cId = c.getValue();
		}
	}
	
	if(sId == null && cId == null){%>
		<script>
			alert("로그인 후 이용 가능한 페이지입니다.");
			window.location.href="loginForm.jsp";
		</script>
<%	}else{ 
		if(sId == null && cId != null){
			session.setAttribute("sId", cId);
			sId = cId;
		}
		PetmemberDAO dao = new PetmemberDAO();
		PetmemberDTO petmember = dao.getPetmember(sId);
		CommentbDAO comment = new CommentbDAO();
		int commentWriteCount = comment.getcommentWriteCount(sId);
		TradeDAO trade = new TradeDAO();
		int tradeWriteCount = trade.gettradeWriteCount(sId);
		BoardDAO board = new BoardDAO();
		int boardWriteCount = board.getboardWriteCount(sId);
		
		boolean sitter = dao.checkSitter(sId); //펫시터 등록여부
		
		QNADAO mypet = new QNADAO();
		List pets = mypet.myPetList(sId);
		%>
<body>
	<header>
		<jsp:include page="petHeader.jsp" flush="false"/>
	</header>
	<aside class="aside">
		<jsp:include page="mypageAside.jsp" flush="false"/>
	</aside>
	<div id="wrapper">
		<section class="section">
			<br/>
			<h2 align="center" style="margin-bottom: 0; color: #3e6383;">마이페이지</h2>
			<br/>
			<h4 align="center" style="margin-bottom: 0; color: #3e6383; background-color:#e8e8fa; ">'<%=sId %>'님 환영합니다!</h4>
			<br/>
			<h2 align="center" style="margin-bottom: 0; color: #3e6383;">나의 반려동물</h2>
			<br/>
			<table align="center" >
				<tr>
					<td width="550">
						<br/>
						<% if(pets == null){ %> 
						등록하신 반려동물이 없습니다. 나의 반려동물을 등록해보세요.<br/><br/>
						<button class="listButt" onclick="window.location.href='addPetForm.jsp'">반려동물 등록하기</button>
						<% }else{ 
							QNADTO pet = null;	
							for(int i = 0; i < pets.size(); i++){
								pet = (QNADTO)pets.get(i); %>
								<div class="pets">
									<% if( pet.getImg() != null){ %> 
									<img class="petImg" src = "/web/save/<%= pet.getImg()%>" width="150px" />
									<% }else{ %> 
									<img class="petImg" src = "/web/save/defaultimg.jpg" width="150px" />
									<% } %>
									</a>	
									<br/>
									<%=pet.getName() %>
								</div>
							<% 	} %>
							<br/><br/><button class="listButt" onclick="window.location.href='addpet.jsp'">나의 애견 정보</button>
						<% } %> 
						<br/>
						<br/>
					</td>
				</tr>
			</table>
			<br/><br/>
			<h2  align="center" style="margin-bottom: 0; color: #3e6383;">나의 커뮤니티 활동내역</h2>
			<br/>
			<table align="center" >
				<tr>
					<td width="550">
						<br/>
						펫시터 이용 : &nbsp; &nbsp; <%=commentWriteCount %> 회 <br/>
						애견용품 거래 글 : &nbsp; &nbsp; <%=tradeWriteCount %> 개 <br/>
						자유게시판 글 등록 : &nbsp; &nbsp;<%=boardWriteCount %> 개 <br/>
						펫시터 등록 여부:  
						<% if(sitter){%> &nbsp;  &nbsp;  YES <%}
						else{%> &nbsp; &nbsp; NO <%}%>
						<br/><br/>
						<button class="listButt" onclick="window.location.href='myContentsList.jsp'">내가 쓴 글 보러가기</button>
						<br/><br/>
					</td>
				</tr>
			</table>
			<br/><br/>
			<h3 align="center"><a href="modifyForm.jsp">나의 정보 수정하러 가기</a></h3>
			<% 
			 PetsitterDAO sit = new PetsitterDAO();
			 boolean b = sit.petsitCheck(sId);	
			if(b){ %> 
			<h3 align="center"><a href="actpet.jsp">나의 펫시터 활동내역 보러가기</a></h3>	
			<% } %>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
		</section>
	</div>	
	<footer id="footer">
		<jsp:include page="petFooter.jsp" flush="false"/>
	</footer>
</body>
<%}%>
</html>