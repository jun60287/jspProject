<%@page import="java.io.IOException"%>
<%@page import="web.pet.model.QNADAO"%>
<%@page import="web.pet.model.QNADTO"%>
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
		String sId = (String)session.getAttribute("sId");
		int num = 0;
		if(sId == null) {%>
			<script>
			alert("접근오류.");
			window.location.href="main.jsp";
			</script>
		<%}else{
		
		Cookie [] cs = request.getCookies();
		if(cs != null && session.getAttribute("sId") == null){
			for(Cookie coo : cs){
				if(coo.getName().equals("cId")) sId = coo.getValue();
			}session.setAttribute("sId", sId);
		}
		try{
			String path = request.getRealPath("save");
			int max = 1024 * 1024 * 10 ;
			String enc = "UTF-8";
			DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
			
			MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);	
			
			String name = mr.getParameter("name");
			String kind = mr.getParameter("kind");
			String age = mr.getParameter("age");
			String img = mr.getFilesystemName("img");
						
			QNADTO dto = new QNADTO();
			
			dto.setId(sId);
			dto.setName(name);
			dto.setKind(kind);
			dto.setAge(age);
			dto.setImg(img);
			
			QNADAO dao = new QNADAO();
			
			dao.addPet(dto);
			
			response.sendRedirect("addpet.jsp");
		}catch(IOException e){%>
			<script>
				alert("접근 오류");
				window.location.href="main.jsp";
			</script>
		<%}
	}%>
</head>
<body>

</body>
</html>