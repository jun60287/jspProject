<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫시터 정보 삭제페이지</title>
<script>
	function check(){
		var checkpet = document.petdel;
		if(!checkpet.pw.value){
			alert("비밀번호를 입력하시오.");
			return false;
		}
	}
</script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
<link href="xListStyle.css" rel="stylesheet" type="text/css" />
<style>
	.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center; width : 350px; 
		border-radius: 5px; background-color: #eff1f4; COLOR: #22252e;}
	#list4{ margin:0 auto; width:300px; border-collapse: collapse; border: 2px solid #eff1f4; }
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
		if(sId.equals("admin")){%>
		<script>
		alert("접근 오류");
		window.location.href="main.jsp";
		</script>	
	<%}
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
			<br /><br/>
			<h2 align="center" style="margin-bottom: 0; color: #3e6383;">펫시터 해지</h2>
			<br/><br/>
			<form name = "petdel" action = "infopetdeletePro.jsp" method = "post" onsubmit = "return check()" >
				<div class="table2">
					<table id="list4">
						<tr>
							<td>
								PW : &nbsp; 
								<input class="text" type = "password" name = "pw" />
							</td>
						</tr>	
						<tr>
							<td><input class="listButt" type = "submit" value = "펫시터 탈퇴" /> &nbsp; 
							<input class="listButt" type = "button" value = "취소" onclick = "window.location.href = 'mainpet.jsp'" /></td>
						</tr>
					</table>
				</div>
			</form>
			<%} %>
			<br/><br/><br/><br/><br/><br/><br/><br/>
			<br/><br/><br/><br/><br/><br/><br/><br/>
			<br/><br/><br/><br/><br/><br/><br/><br/>
			<br/><br/><br/><br/><br/><br/><br/><br/>
		</section>
	</div>	
	<footer id="footer">
		<jsp:include page="petFooter.jsp" flush="false"/>
	</footer>			
</body>
</html>