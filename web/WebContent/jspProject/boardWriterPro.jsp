<%@page import="java.io.IOException"%>
<%@page import="web.pet.model.BoardDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="article" class = "web.pet.model.BoardDTO"></jsp:useBean>
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
	
	if(sId == null){%>
		<script>
		alert("접근 오류");
		window.location.href = "main.jsp"
		</script>	
<%	}else{
	try{
	String id = (String)session.getAttribute("sId");
	request.setCharacterEncoding("UTF-8");
	
	String path = request.getRealPath("save");
	
	int max = 1024*1024*5;
	
	String enc = "UTF-8";
	
	DefaultFileRenamePolicy df = new DefaultFileRenamePolicy();
	
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, df);
	
	
	
	String imgname = mr.getFilesystemName("img");
	String contentType = mr.getContentType("img");
	
	if(contentType != null){
		String [] ct = contentType.split("/");
		if(!(imgname != null && ct[0].equals("image"))){
			File f = new File(imgname);
			f.delete();
		}
	}

	article.setId(id);
	article.setSubject(mr.getParameter("subject"));
	article.setContent(mr.getParameter("content"));
	article.setPhoto(mr.getFilesystemName("photo"));
	article.setReg(new Timestamp(System.currentTimeMillis()));
	
	BoardDAO dao = new BoardDAO();
	dao.inputBoard(article); 
	
	response.sendRedirect("boardList.jsp");
	
}catch(IOException e){%>
	<script>
		alert("접근 오류");
		window.location.href="main.jsp";
	</script>
<%
	}
}
%>
<body>

</body>
</html>