<%@page import="java.io.IOException"%>
<%@page import="web.pet.model.PetsitterDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="pet" class = "web.pet.model.PetsitterDTO"/>
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
	try{
		if(sId == null && cId != null){
			session.setAttribute("sId", cId);
			sId = cId;
		}
	String path = request.getRealPath("save");
	String photoname = "";
	PetsitterDAO name = new PetsitterDAO();
	photoname = name.getPhotoNamePet(sId);
	if(photoname != null){
		path += ("//"+photoname);
		File f = new File(path);
		f.delete();
	}


	path = request.getRealPath("save");
	String enc = "UTF-8";
	int max = 1024*1024*5;
	DefaultFileRenamePolicy dr = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dr );
	
	pet.setId(sId);
	pet.setPw(mr.getParameter("pw"));
	pet.setName(mr.getParameter("name"));
	pet.setArea(mr.getParameter("area"));
	pet.setPetsit(mr.getParameter("petsit"));
	pet.setPet(mr.getParameter("pet"));
	pet.setPhon(mr.getParameter("phone"));
	pet.setBox(mr.getParameter("box"));
	pet.setPhoto(mr.getFilesystemName("photo"));
	
	PetsitterDAO dao = new PetsitterDAO();
	dao.updatePet(pet);
	}catch(IOException e){%>
		<script>
		alert("접근 오류");
		window.location.href="main.jsp";
		</script>	
	<%
	}	
}
%>
<script>
	alert("수정이 완료되었습니다.");
	window.location.href="mainpet.jsp";
</script>

</head>
<body>

</body>
</html>