
<%@page import="web.pet.model.PetsitterDTO"%>
<%@page import="web.pet.model.PetsitterDAO"%>
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
	#list { width:500px; margin:0 auto; }
	.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center; width : 530px; 
		border-radius: 5px; background-color: #eff1f4; }
	.text { text-align: center;}
</style>
<script>
	function check(){
		var checkList = document.modify;
		if(!checkList.pw.value){
			alert("비밀번호 미입력");
			return false;
		}
		if(!checkList.pwCh.value){
			alert("비밀번호확인 미입력");
			return false;
		}
		if(checkList.pw.value != checkList.pwCh.value){
			alert("비밀번호와 비밀번호 확인이 불일치 합니다.");
			return false;
		}
		if(!checkList.name.value){
			alert("이름을 입력해 주세요");
			return false;
		}
		if(!checkList.area.value ){
			alert("지역을 입력해 주세요");
			return false;
		}
		if(!checkList.petsit.value ){
			alert("펫시터경험횟수를 입력해 주세요");
			return false;
		}
		if(!checkList.pet.value ){
			alert("반려동물 입력란을 입력해 주세요");
			return false;
		}
	}
</script>
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
	PetsitterDAO dao = new PetsitterDAO();
	PetsitterDTO article = dao.getPetsitter(sId);
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
			<h2 align="center" style="margin-bottom: 0; color: #3e6383;">펫시터 정보 수정하기</h2>
			<br/><br/>
			<form action = "infopetmodifyPro.jsp" method = "post" name = "modify" onsubmit = "return check()" enctype = "multipart/form-data">
				<div class="table2">
					<table id="list">		<%-- 펫시터 평점 컬럼도 만들어져는 있으나 자신이 입력하지 못하는 항목이므로 여기에는 넣지 않음 --%>
						<tr>
							<td>아이디</td>
							<td><%=article.getId() %></td>
						</tr>
						<tr>
							<td>비밀번호 *</td>
							<td><input class="text" type = "text" name = "pw" /></td>
						</tr>
						<tr>
							<td>비밀번호 확인 *</td>
							<td><input class="text" type = "text" name = "pwCh" /></td>
						</tr>
						<tr>
							<td>이름 *</td>
							<td><input class="text" type = "text" name = "name" value = "<%=article.getName()%>"/></td>
						</tr>
						<tr>
							<td>지역 *</td>
							<td>
				                <select id="sel" name = "area">
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
							<td>펫시터 경험회수 *</td>
							<td><input class="text" type = "text" name = "petsit" value = "<%=article.getPetsit()%>"/></td>
						</tr>
						<tr>
							<td>키우고 있거나 키워본 반려동물 수 *</td>
							<td><input class="text" type = "text" name = "pet" value = "<%=article.getPet()%>"/></td>
						</tr>
						<tr>
							<td>휴대폰 번호</td>
							<td><input class="text" type = "text" name = "phone" value = "<%=article.getPhon()%>"/></td>
						</tr>
						<tr>
							<td colspan="2">[ 기타사항 ]<br/>(관련 자격증이나 하고 싶은 말 등을 적으시면 됩니다.)<br/><br/>
								<textarea name = "box" cols = "50" rows = "10"><%=article.getBox()%></textarea>
							</td>
						</tr>
						<tr>
							<td colspan="2">[ 프로필 사진 ]<br/><br/>
							<% if(article.getPhoto() !=null){ %> 
							<img src = "/web/save/<%=article.getPhoto() %>" width="300px"><br/>
							<% } %>
								<input class="listButt" type = "file" name = "photo" >
							</td>
						</tr>
						<tr>
							<td colspan = "2" align = "center">
								<br/>
								<input class="listButt" type = "submit" value = "신청" />
								<input class="listButt" type = "reset" value = "재입력" />
								<input class="listButt" type = "button" value = "취소" onclick = "window.location.href = 'mainpet.jsp'" />
								<br/>
							</td>
						</tr>
					</table>
				</div>
			</form>
			<br/><br/><br/><br/><br/><br/><br/><br/>
			<br/><br/><br/><br/>
		</section>
	</div>	
	<footer id="footer">
		<jsp:include page="petFooter.jsp" flush="false"/>
	</footer>
</body>
<% } %>
</html>