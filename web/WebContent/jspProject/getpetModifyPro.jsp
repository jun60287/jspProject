<%@page import="web.pet.model.GetpetDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="web.pet.model.GetpetDAO"%>
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
	#list { width: 300px;}
</style>
</head>
<%
	request.setCharacterEncoding("UTF-8");
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
			alert("접근오류.");
			window.location.href="main.jsp";
		</script>	
	<%	}else if(sId == null && cId != null){
		session.setAttribute("sId", cId);
		sId = cId;
	}
	
	//2.
	String path = request.getRealPath("save");
	//3.
	int max = 1024*1024*5;
	//4.
	String ecn = "UTF-8";
	//5.
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	
	MultipartRequest mr = null;
	try{
		mr = new MultipartRequest(request, path, max, ecn, dp);
		
		//img파일 검사
		String sysname = mr.getFilesystemName("img");
		String contentType = mr.getContentType("img");
		if(contentType != null){
			String[] ct = contentType.split("/");
	
			if(!(sysname != null && ct[0].equals("image"))){
				File f = new File("sysname");
				f.delete();
			%>
				<script type="text/javascript">
					alert("이미지 파일이 아닙니다. 이미지 파일을 업로드해주세요.");
					history.go(-1);
				</script>
			<% 		
			}
		}
		
		
		String pageNum = mr.getParameter("pageNum");
		int num = Integer.parseInt(mr.getParameter("num"));
		
		GetpetDTO article = new GetpetDTO();
		article.setNum(num);
		article.setSubject(mr.getParameter("subject"));
		article.setContent(mr.getParameter("content"));
		article.setImg(sysname);
		
		GetpetDAO dao = new GetpetDAO();
		//수정할 사진 존재할 경우 수정사진dto에 저장하고 이전 사진 삭제
		String img = dao.getpetImage(num);
		if(sysname != null){
			if(img != null){
				File f = new File("D:\\hyunsu\\classclass\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\web\\save\\"+img);
				f.delete();
			}
		}else{ //sysname이 존재하지 않을 경우 기존의 사진 다시 넣어주기
			article.setImg(img);
		}
		
		dao.modifyGetpet(article);
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
					<td>수정이 완료되었습니다.<br/><br/>
					<button class="listButt" onclick="window.location.href='getpetList.jsp'">리스트보기</button>
					<button class="listButt" onclick="window.location.href='getpetContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">수정글확인</button>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
	</body>
	<% }catch(Exception e){
		%>
		<script>
			alert("접근 오류.");
			window.location.href='main.jsp';
		</script>
 	<% } %>	
	
</html>