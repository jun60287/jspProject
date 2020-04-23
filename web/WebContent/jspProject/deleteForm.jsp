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
	#list { width:200px; margin:0 auto; }
	.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center; width : 300px; 
		border-radius: 5px; background-color: #eff1f4; margin-right: 190px;}
</style>
<script>
	function checkValues(){
		var deleteMember = document.deleteMember;
		if(!deleteMember.pw.value){
			alert("비밀번호 확인을 입력하세요.");
			return false;
		}
	}
</script> 
</head>
<%
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(int i = 0; i < coo.length; i++){
		if(coo[i].getName().equals("cId")) cId = coo[i].getValue();
		}
	}
	
	if(sId == null && cId == null){	%>
		<script>
			alert("로그인 후 이용 가능한 페이지입니다.");
			window.location.href="main.jsp";
		</script>	
	<%	}else if(sId == null && cId != null){
		session.setAttribute("sId", cId);
		sId = cId;
	}
	if(sId.equals("admin")){%>
		<script>
		alert("접근 오류");
		window.location.href="main.jsp";
		</script>	
<%
		
	}

%>
<body>
	<header>
		<jsp:include page="petHeader.jsp" flush="false"/>
	</header>
	<div id="wrapper">
		<aside class="aside">
			<jsp:include page="mypageAside.jsp" flush="false"/>
		</aside>
		<section>
			<br/><br/>
			<h2 align="center" style="margin-bottom: 0; color: #3e6383;"> 회원 탈퇴 </h2>
			<br/><br/>
			<div class="table2">
				<table id="list">
					<form name="deleteMember" action="deletePro.jsp" onsubmit="return checkValues()" method="post">
						<tr>
							<td >
								비밀번호를 입력하세요.<br/><br/>
								<input class="text" type="password" name="pw" />
							</td>
						</tr>
						<tr>
							<td>
								<input class="listButt" type="submit" value="회원 탈퇴" /> 
								<input class="listButt" type="button" value="취소" onclick="history.go(-1)" />
							</td>
						</tr>
					
					</form>
				</table>
			</div>	
		</section>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	</div>	
	<footer id="footer">
		<jsp:include page="petFooter.jsp" flush="false"/>
	</footer>
<body>

</body>
</html>