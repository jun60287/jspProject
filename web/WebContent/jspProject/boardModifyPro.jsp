<%@page import="web.pet.model.BoardDAO"%>
<%@page import="web.pet.model.BoardDTO"%>
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
</head>
<%
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(int i = 0; i < coo.length; i++){
			if(coo[i].getName().equals(cId)) cId = coo[i].getValue();
		}
	}
	if(sId == null && cId != null){
		session.setAttribute("sId", cId);
		sId = cId;
	}
	
	if(request.getParameter("num") == null || sId == null){%>
		<script>
		alert("접근 오류");
		window.location.href = "main.jsp"
		</script>	
<%	}else{

	BoardDTO article=new BoardDTO();
	
	int num = Integer.parseInt(request.getParameter("num"));
	
	String id = (String)session.getAttribute("sId");
	
	request.setCharacterEncoding("UTF-8");
	
	String path = request.getRealPath("save");
	
	int max = 1024*1024*5;
	
	String enc = "UTF-8";
	
	DefaultFileRenamePolicy dr = new DefaultFileRenamePolicy();
	
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dr);
	
	BoardDAO name = new BoardDAO();

	String photoname = name.getPhotoname(num);
	if(photoname != null){
		path += ("//" + photoname);
		File f = new File(path);
		f.delete();
	}

	article.setId(mr.getParameter("id"));
	article.setSubject(mr.getParameter("subject"));
	article.setContent(mr.getParameter("content"));
	article.setPhoto(mr.getFilesystemName("photo"));
	article.setNum(num);
	BoardDAO dao = new BoardDAO();
	boolean result = dao.modifyBoard(article);

	response.sendRedirect("boardList.jsp");

		}	
	%>
<body>

</body>
</html>