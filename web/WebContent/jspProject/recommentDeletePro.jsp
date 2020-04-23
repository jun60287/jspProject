<%@page import="java.io.File"%>
<%@page import="web.pet.model.CommentbDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<% //세션쿠키검사 완료

	request.setCharacterEncoding("UTF-8");
	String pw = request.getParameter("pw");
	String sId = (String)session.getAttribute("sId");
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
	
	if(sId == null || pw == null){%>
		<script>
		alert("접근 오류.");
		window.location.href="main.jsp";
		</script>
	<%}else{ 
		int num = Integer.parseInt(request.getParameter("num"));
		CommentbDAO dao = new CommentbDAO();
		//사진삭제 위해 이미지이름 받아놓기
		String img = dao.commentImage(num);
		
		//세션에존재하는 아이디값으로 회원정보의 pw와 비교 후 같으면 num으로 글 찾아 삭제
		int x = dao.deleteArticle(sId, num, pw);
		
		switch(x){
		case 1:
			
			//사진삭제
			if(img != null){
				File f = new File("D:\\hyunsu\\classclass\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\web\\save\\"+img);
				f.delete();
			}
			
			%>
			<script>
				alert("삭제가 완료되었습니다.");
				window.location.href="commentList.jsp";
			</script>
			<%
		case 0:
			%>
			<script>
				alert("시스템 오류. 다시 입력해주세요.");
				history.go(-1);
			</script>
			<%
		case -1:	
			%>
			<script>
				alert("비밀번호가 일치하지 않습니다.");
				history.go(-1);
			</script>
			<%
		}
	} %>

</body>
</html>