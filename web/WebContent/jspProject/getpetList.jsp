
<%@page import="web.pet.model.PetsitterDTO"%>
<%@page import="web.pet.model.GetpetDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.pet.model.GetpetDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
<link href="xListStyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	.table{ width:800px; }
	#list{ width:760px;}
</script>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	//세션쿠키검사완료 (Allkind 페이지/ 1.쿠키만 존재하면 세션 만들어주기/ 2.세션이 있는 경우에만 '작성하기'버튼 생성)
	String sId = (String)session.getAttribute("sId");
	String admin = (String)session.getAttribute("admin");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(int i = 0; i < coo.length; i++){
			if(coo[i].getName().equals("cId")) cId = coo[i].getValue();
		}
	}
	
	if(sId == null && cId != null ){
		session.setAttribute("sId", cId);
		sId = cId;
	}
	
	// 1. 기본세팅
	String pageNum = null;
	if (request.getParameter("pageNum") == null) { pageNum = "1"; }
	else { pageNum = request.getParameter("pageNum"); }
	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	int pageSize = 5;
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	
	GetpetDAO dao = new GetpetDAO();
	List getpetList = null;
	// 2. 전체 글 갯수 가져와서 count에 세팅
	
	/////////////검색기능 코드
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	
	
	if(sel != null && search != null){
		count = dao.getSearchArticleCount(sel, search);
		if(count > 0){
			getpetList = dao.getSearchArticleList(startRow, endRow, sel, search);
		}
	}else{
		count = dao.articleCount();
		if(count > 0){
			getpetList = dao.getpetList(startRow, endRow);
		}	
	}

%>
<body>
	<header>
		<jsp:include page="petHeader.jsp" flush="false"/>
	</header>
	<section>
		<h1 align="center" style="margin-bottom: 0; color: #3e6383;">펫시터 예약하기</h1>
	
		<br/>
		<h1 align="center" >
	 <% if(sId != null){ %>
			<button class="listButt" onclick="window.location.href='getpetWriteForm.jsp'">작성하기</button>
	 <% } %>
		<button class="listButt" onclick="window.location.href='commentList.jsp'">펫시터 이용후기 보러가기</button>
		</h1>
		<div class="table">
		<table id="list">
			<tr>    
				<td colspan="4" align="right">
					<%-- 검색기능 추가 --%>
					<form action="getpetList.jsp" method="post">
						<select name="sel" id="sel">
							<option value="area">지역</option>
							<option value="petsit">경력</option>
							<option value="avgpoint">평점</option>
							<option value="name">펫시터</option>
						</select>
						<input class="text" type="text" name="search"/>
						<input type="submit" value="검색"/>
					</form>
				</td>
			</tr>
			<tr>
				<td colspan="2" width="500">제목</td>
				<td>글쓴이</td>
				<td>조회수</td>
			</tr>
		<%
			if(count != 0){  //게시판에 글이 1개라도 존재하면 
				GetpetDTO getpet = null;
				PetsitterDTO sitter = new PetsitterDTO();
	
				for(int i = 0; i < getpetList.size(); i++){
					getpet = (GetpetDTO)getpetList.get(i);
					String sitterId = getpet.getId();
					//PetsitterDTO의 id값으로 펫시터멤버가져오는 메소드접근하여 펫시터정보 가져오기.
					sitter = dao.getSitter(sitterId); 
					int commentCount = dao.getCommentCount(sitter.getName());
					%>	
				<tr height="100px">
					<td >
					<%if(sitter.getPhoto() != null){%>				
					<img src="/web/save/<%=sitter.getPhoto()%>" width="100"/>					
				<% 	}else{ %>				
					<img src="img/empty.png" width="100"/>
				<% 	} %>
					</td>
					<td width="500" height="100px">
					<h2><a href="getpetContent.jsp?num=<%=getpet.getNum()%>&pageNum=<%=pageNum%>&count=<%=count%>"><%=getpet.getSubject()%></a></h2>
					지역 : <%=getpet.getArea() %> &nbsp; 펫시터 경력 : <%=sitter.getPetsit() %>회 &nbsp; 키워본 동물 수 : <%=sitter.getPet() %>마리 <br/>
					후기 : <%=dao.getCommentCount(sitter.getName())%> 개 &nbsp; 평점 : <%=String.format("%.1f", getpet.getAvgpoint()) %>점
					</td>
					<td><%=getpet.getName() %></td> 
					<td><%=getpet.getReadcount() %></td>
					<%if(admin != null && admin.equals("admin")) {%>
					<td>
					<button onclick="window.location.href='getpetDeletePro.jsp?num=<%=getpet.getNum()%>'">삭제</button>
					</td>
					<% } %>
				</tr>			
					
		<%		}	
			
			}else{
		%>		
				<tr>
					<td class="listButt" colspan="4">작성된 글이 없습니다.</td>
				</tr>
		
		<%	}
		%>
		
		</table>
		</div>
		<br/>
		<br/>
		<br/>
		
		<div class="view" align="center">
		<%
			if(count > 0){
				//10페이지씩 끊어서 나타내기
				
				//1. 총 몇페이지 나오는 지 계산
				int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);
				//2. 보여줄 페이지 번호의 갯수 지정
				int pageBlock = 2;
				//3. 현재 위치한 페이지에서 페이지 뷰어 첫번째 숫자가 무엇인지 찾기.
				int startPage = 0;
					if(currentPage % pageBlock == 0){
						startPage = (int)((currentPage-1)/pageBlock)*pageBlock +1;
					}else{
						startPage = (int)(currentPage/pageBlock)*pageBlock +1;
					}
				//4. 마지막에 보여지는 페이지뷰어에 페이지 개수가 10미만일 때, 마지막 페이지 번호가 endPage가 되도록
				int endPage = startPage + pageBlock - 1;
				if(endPage > pageCount) endPage = pageCount;
				
				//6. startPage가 10보다 크면 '<'
				if(startPage > pageBlock){ %>
					<a class="view" href = "getpetList.jsp?pageNum=<%=startPage-1%>"> &lt; </a>	
			<%  }
				//5. 페이지번호 반복해서 뿌려주기
				for(int i = startPage; i <= endPage; i++){ %>
					<a class="view" href = "getpetList.jsp?pageNum=<%=i %>"> &nbsp; <%= i %> &nbsp; </a>
		<% 		}
				
				//7. 뒷 페이지가 더 있으면 '>'
				if(endPage < pageCount){ %>
				<a class="view" href = "getpetList.jsp?pageNum=<%=endPage+1%>"> &gt; </a>	
		<%  	}
			}
			
		%>
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