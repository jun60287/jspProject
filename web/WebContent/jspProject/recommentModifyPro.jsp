<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="web.pet.model.CommentbDTO"%>
<%@page import="java.io.File"%>
<%@page import="web.pet.model.CommentbDAO"%>
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
	.table2 { border: 2px solid #97a7b7; margin:0 auto; text-align: center;
		border-radius: 5px; background-color: #eff1f4; width: 350px; }
	#list { width: 300px; margin:0 auto;  border-collapse: collapse;}
</style>
</head>
<%

	request.setCharacterEncoding("UTF-8");	

	//세션,버그잡기 완료
	String sId = (String)session.getAttribute("sId");
	String pageNum = null;
	int num = 0; 

	if(request.getParameter("pageNum") == null || request.getParameter("num") == null || sId == null){%>
		<script>
			alert("접근오류.");
			window.location.href="main.jsp";
		</script>
	<%}else {
		pageNum = request.getParameter("pageNum");
		num = Integer.parseInt(request.getParameter("num"));
	}

	
	//2.
	String path= request.getRealPath("save");
	//D:\hyunsu\classclass\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\web\commentImg
	//3.
	int max = 1024*1024*5;
	//4.
	String enc = "UTF-8";
	//5.
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	
	MultipartRequest mr = null;
	
	try{
		mr = new MultipartRequest(request, path, max, enc, dp);
		
		String sysname = mr.getFilesystemName("img");
		String contentT = mr.getContentType("img");
		if(sysname != null){
			String[] ct = contentT.split("/");
			File f = new File(sysname);
			if(!(ct[0].equals("image"))){
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
		
		String subject = mr.getParameter("subject");
		String content = mr.getParameter("content");
		
		CommentbDAO dao = new CommentbDAO();
		
		String img = dao.commentImage(num);
		if(sysname == null)	{
			sysname = img;
		}else{
			File f = new File("D:\\hyunsu\\classclass\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\web\\save\\"+img);				
			f.delete();
		}	
		
		CommentbDTO comment = new CommentbDTO();
		comment.setNum(num);
		comment.setSubject(subject);
		comment.setContent(content);
		comment.setImg(sysname);
		
		dao.modifyRecomment(comment);
		
	%>
	<body>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>	
		<div class="table2">
			<table id="list">
				<tr>
				<tr>
					<td>수정이 완료되었습니다.<br/><br/>
					<button class="listButt" onclick="window.location.href='commentList.jsp?pageNum=<%=pageNum%>'">리스트보기</button>
					<button class="listButt" onclick="window.location.href='commentContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">수정글확인</button>
					</td>
				</tr>
				
			</table>
		</div>
	</body>
		
 	<%}catch(Exception e){%>
		<script>
			alert("접근오류.");
			window.location.href="main.jsp";
		</script>
	<%}%> 
</html>