<%@page import="web.pet.model.TradeDAO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 삭제(프로)</title>
</head>
<%
	String num1 = request.getParameter("num");
	request.setCharacterEncoding("UTF-8");
	///////////////////////////현재수정
	if(session.getAttribute("sId") == null || num1 == null) { %>
	<script>
		alert("잘못된 접근입니다.");
		window.location="main.jsp";
	</script>	
	<%	}else{
		String id = (String)session.getAttribute("sId");
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String pass = request.getParameter("pass");
		String path = request.getRealPath("save");
		
		TradeDAO dao = new TradeDAO();
		String photoName = dao.getPhotoName(id);
		
		if(id.equals("admin")){
			dao.deleteArticleByAdmin(num); %>
			<script>
				alert("삭제 완료!");
			</script>
<%			response.sendRedirect("tradeList.jsp?pageNum="+pageNum);
			}else{
		
			int result = dao.deleteArticle(num, pass);
			
			if(result == 1){
				if(photoName != null){
					path += ("\\" + photoName);
					File f = new File(path);
					f.delete();
				}
				response.sendRedirect("tradeList.jsp?pageNum="+pageNum);
				
			}else{	%>
				<script>
					alert("비밀번호가 맞지 않습니다.");
					history.go(-1);
				</script>
<%			}
		}
	} %>
<body>

</body>
</html>