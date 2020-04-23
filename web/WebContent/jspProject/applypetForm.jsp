<%@page import="web.pet.model.PetsitterDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>펫시터 신청페이지</title>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
	<link href="xListStyle.css" rel="stylesheet" type="text/css" />
	<style>
		.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center;
		#list4 { width: 600px; border-collapse: collapse; border: 2px solid #eff1f4;}
			border-radius: 5px; background-color: #eff1f4; width: 650px; }
	</style>
	<script>
		function check(){
			var checkapply = document.applypet;
			if(!checkapply.pw.value){
				alert("비밀번호를 입력하시오.");
				return false;
			}
			if(!checkapply.pwCh.value){
				alert("비밀번호 확인란을 입력하시오.")
				return false;
			}
			if(checkapply.pw.value != checkapply.pwCh.value){
				alert("비밀번호를 동일하게 입력하시오.")
				return false;
			}
			if(!checkapply.name.value){
				alert("이름을 입력하시오.");
				return false;
			}
			if(!checkapply.petsit.value){
				alert("펫시터 경험회수를 입력하시오.")
				return false;
			}
			if(!checkapply.pet.value){
				alert("키우고 있거나 키워본 반려동물 수를 입력하시오.");
				return false;
			}
		}
	</script>
</head>
<%
//필요한 변수 세팅
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
		window.location.href="main.jsp";
	</script>
<%}else {
	if( sId == null && cId != null){ //쿠키만 존재할 경우 세션 만들어주고  sId에 값도 담아주기
	session.setAttribute("sId", cId);
	sId = cId;
	}
	PetsitterDAO dao = new PetsitterDAO();
		boolean check = dao.petsitCheck(sId);
		if(check){%>
			<script>
				alert("펫시터 등록이 되어있는 상태입니다!");
				window.location.href = "mainpet.jsp";
			</script>
<%		}else{%> 
	<body>
		<header>
			<jsp:include page="petHeader.jsp" flush="false"/>
		</header>
		<div id="wrapper">
			<aside class="aside">
				<jsp:include page="mypageAside.jsp" flush="false"/>
			</aside>
			<section class="section">
				<br/>
				<br/>	
				<h2 align="center" style="margin-bottom: 0; color: #3e6383;">펫시터 신청페이지</h2>
				<br/>
				<br/>
				<form name = "applypet" action = "applypetPro.jsp" method = "post" onsubmit = "return check()" enctype = "multipart/form-data">
					<div class="table2">
						<table id="list4">   	<%-- 펫시터 평점 컬럼도 만들어져는 있으나 자신이 입력하지 못하는 항목이므로 여기에는 넣지 않음 --%>
							<tr>
								<td>아이디(회원가입 아이디와 동일)</td>
								<td><%= session.getAttribute("sId") %></td>
							</tr>
							<tr>
								<td>비밀번호 *(후에 탈퇴 및 수정시 필요한 비밀번호입니다.)</td>
								<td><input class="text" type = "text" name = "pw" /></td>
							</tr>
							<tr>
								<td>비밀번호 확인 *</td>
								<td><input class="text" type = "password" name = "pwCh" /></td>
							</tr>
							<tr>
								<td>이름 *</td>
								<td><input class="text" type = "text" name = "name" /></td>
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
								<td><input class="text" type = "text" name = "petsit" /></td>
							</tr>
							<tr>
								<td>키우고 있거나 키워본 반려동물 수 *</td>
								<td><input class="text" type = "text" name = "pet" /></td>
							</tr>
							<tr>
								<td>휴대폰 번호</td>
								<td><input class="text" type = "text" name = "phone" /></td>
							</tr>
							<tr>
								<td colspan="2">기타사항(관련 자격증이나 하고 싶은 말 등을 적으시면 됩니다.) <br/><br/>
									<textarea name = "box" cols = "50" rows = "10"></textarea>
								</td>
							</tr>
							<tr>
								<td>프로필 사진</td>
								<td>
									<input class="text" type = "file" name = "photo" />
								</td>
							</tr>
							<tr>
								<td colspan = "2" align = "center">
									<input class="listButt" type = "submit" value = "신청" />
									<input class="listButt" type = "reset" value = "재입력" />
									<input class="listButt" type = "button" value = "취소" onclick = "window.location.href = 'mainpet.jsp'" />
								</td>
							</tr>
						</table>
					</div>
				</form>
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
	
<%		}
	} %>

</html>










