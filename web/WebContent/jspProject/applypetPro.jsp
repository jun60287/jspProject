<%@page import="java.io.IOException"%>
<%@page import="web.pet.model.PetsitterDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>펫시터 신청페이지(프로)</title>
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
if(sId == null && cId != null){ 
	session.setAttribute("sId", cId);
	sId = cId;
}

if(sId == null){ //세션없으면 메인으로 %>
	<script>
		alert("로그인 후 이용가능 한 페이지입니다.");
		window.location.href="main.jsp";
	</script>
<%}else {
	try{
	request.setCharacterEncoding("UTF-8"); %>


<jsp:useBean id = "pet" class = "web.pet.model.PetsitterDTO" />

<%
	String id = (String)session.getAttribute("sId");
	String path = request.getRealPath("save");
	int max = 1024*1024*10;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	pet.setId(id);
	pet.setPw(mr.getParameter("pw"));
	pet.setName(mr.getParameter("name"));
	pet.setArea(mr.getParameter("area"));
	pet.setPetsit(mr.getParameter("petsit"));
	pet.setPet(mr.getParameter("pet"));
	pet.setPhon(mr.getParameter("phone"));
	pet.setBox(mr.getParameter("box"));
	pet.setPhoto(mr.getFilesystemName("photo"));
	
	PetsitterDAO dao = new PetsitterDAO();
	dao.insertpetMember(pet);
%>
<script>
	alert("펫시터 등록이 완료되었습니다.");
	window.location.href="mainpet.jsp";
</script>
<%}catch(IOException e){%>
	<script>
	alert("접근 오류");
	window.location.href="main.jsp";
	</script>
<%		}
	}%>
<body>

</body>
</html>








