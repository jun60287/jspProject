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
	#list5 { width:200px; margin:0 auto; border-collapse: collapse; border: 2px solid #eff1f4; }
	.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center; width : 300px; 
		border-radius: 5px; background-color: #eff1f4; }
	.modiTR { border-style: none; }
</style>
<script>
	function checkValues(){
		var modify = document.modify;
		if(!modify.pw.value){
			alert("비밀번호 확인을 입력하세요.");
			return false;
		}
		if(!modify.pw2.value){
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if(modify.pw.value != modify.pw2.value){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
	}
</script>
</head>
<%
//세션쿠키검사 완료
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
			window.location.href="main.jsp";
		</script>
<%	}else if(sId == null && cId != null){
		session.setAttribute("sId", cId);
		sId = cId;
	}
	
	if(sId != null){
	PetmemberDAO dao = new PetmemberDAO();
	PetmemberDTO member = dao.getPetmember(sId);
	
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
		<br/>
		<br/>
		<h2 align="center" style="margin-bottom: 0; color: #3e6383;">정보 수정</h2>
		<br/><br/>
		<form name="modify" action="modifyPro.jsp" onsubmit="return checkValues()" method="post">
			<input type="hidden" name="id" value="<%=member.getId() %>" />
			<div class="table2">
				<table id="list5">      
					<br/>
					<tr>
						<td class="modiTR">아이디 : <%=member.getId() %><br/><br/></td>			
					</tr>
					<tr>
						<td class="modiTR">비밀번호 : <input class="text" type="password" name="pw2" value="<%=member.getPw() %>"/></td>			
					</tr>
					<tr>
						<td class="modiTR">비밀번호 확인 : <input class="text" type="password" name="pw" /></td>			
					</tr>
					<tr>
						<td class="modiTR">이메일 : <input class="text" type="text" name="email" value="<%=member.getEmail() %>"/></td>
					</tr>
					<tr>
						<td class="modiTR"><input class="listButt" type="submit" value="수정" /><br/><br/></td>
					</tr>		
				</table>
			</div>	
		</form>
		
		<div align="center">
			<br/>
			<br/>
			<br/>
			<br/>
			<div><a id="view" href="deleteForm.jsp"><u>회원탈퇴하기</u></a></div>
		</div>
	</section>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/>
</div>	
<footer id="footer">
	<jsp:include page="petFooter.jsp" flush="false"/>
</footer>
</body>
<%} %>
</html>