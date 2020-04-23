<%@page import="java.io.IOException"%>
<%@page import="web.pet.model.TradeDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 수정(프로)</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("sId") == null) { %>
	<script>
		alert("잘못된 접근입니다.");
		window.location="main.jsp";
	</script>	
<%	}else{
	try{
%>
<jsp:useBean id = "article" class = "web.pet.model.TradeDTO" />
<%
		String id = (String)session.getAttribute("sId");
		int num = 0;
		String pageNum = null;
		String path = request.getRealPath("save");
		int max = 1024*1024*10;
		String enc = "UTF-8";
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
		
		String sysname = mr.getFilesystemName("picture");
		String contentT = mr.getContentType("picture");
		if(sysname != null){
			String[] ct = contentT.split("/");
			File f = new File(sysname);
			if(!(ct[0].equals("picture"))){
				f.delete();
			%>
				<script type="text/javascript">
					alert("이미지 파일이 아닙니다. 이미지 파일을 업로드해주세요.");
					history.go(-1);
				</script>		
			<%	
			}
		}
		
		num = Integer.parseInt(mr.getParameter("num"));
		
		TradeDAO dao = new TradeDAO();
		
		String file = dao.getPhotoName(id);
		if(sysname == null)	{
			sysname = file;
		}else{
			File f = new File("D:\\usnoo\\eclipsejsp\\javaserverpage\\web\\WebContent\\save"+file);				
			f.delete();
		}
		
		article.setId(id);
		article.setSubject(mr.getParameter("subject"));
		article.setLocal(mr.getParameter("local"));
		article.setContent(mr.getParameter("content"));
		article.setPicture(sysname);
		article.setPass(mr.getParameter("pass"));
		article.setNum(num);
		
		int result = dao.updateArticle(article);
		
		if(result == 1){
			String url = "tradeList.jsp?pageNum"+pageNum;
			response.sendRedirect(url);
		}else{	%>
			<script>
				alert("비밀번호가 맞지 않습니다, 다시 시도해주세요.");
				history.go(-1);
			</script>
<%			}
		///////////////////////////현재수정
		}catch(IOException e){%>
			<script>
			alert("접근 오류");
			window.location.href("main.jsp");
			</script>
<%	}
} %>
<body>

</body>
</html>