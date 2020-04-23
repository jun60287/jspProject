<%@page import="web.pet.model.BoardDTO"%>
<%@page import="web.pet.model.BoardDAO"%>
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
			border-radius: 5px; background-color: #eff1f4; width: 650px; }
		#list { width: 600px;}
	</style>
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
<%   }else{
   String pwch = request.getParameter("pwch");
   int num = Integer.parseInt(request.getParameter("num"));
   
   BoardDAO dao = new BoardDAO();
   BoardDTO article = dao.getArticle(num);
   String pw = dao.getPw(num);

   if(!(sId.equals("admin"))){%>
   <script>
      function pwCh(){
         var check = document.modify;
         if(check.pw.value != check.pwch.value){
            alert("비밀번호가 불일치합니다");
            return false;
         }else{
            alert("비밀번호가 일치합니다.")
         }
      }
   
   </script>
   <%} %>
<body>

   <br/><br/>
   <form  onsubmit = "return pwCh()" action = "boardModifyPro.jsp?num=<%=article.getNum() %>" method = "post" name = "modify" encType = "multipart/form-data">
   <input type = "hidden" value = "<%=pw %>" name = "pw" >
   		<h1 align="center" style="margin-bottom: 0; color: #3e6383;">수정하기</h1>
		<br/>
		<br/>
		<div class="table2">
			<table id="list">
			   <tr>
			      <td>아이디</td>
			      <td><text name = "id" readonly><%= article.getId()%></text></td>
			   </tr>
			   <tr>  
			      <td>제목</td>
			      <td><input class="text" type = "text" name = "subject" size="50px" value = "<%= article.getSubject()%>"></td>
			   </tr>
			   <tr>
			      <td>내용</td>
			      <td colspan>
			      <textarea rows="20" cols="70" name="content"><%=article.getContent() %></textarea>
			      </td>
			   </tr>
			   <tr>
			      <td>사진</td>
			      <td align = "left">
			      <input class="listButt" type = "file" name = "photo">
			      </td>
			   </tr>
			   <%if(!(sId.equals("admin"))){%>
			   <tr>
			      <td>비밀번호 확인</td>
			      <td align = "left">
			         <input class="text" type = "password" name = "pwch">
			      </td>
			   </tr>
			   <%} %>
			   <tr>
			      <td colspan = "2">
			         <input class="listButt" type = "submit" value = "저장">
			         <input class="listButt" type = "reset" value = "다시쓰기">
			         <input class="listButt" type = "button" value = "리스트" onclick ="window.location='boardList.jsp'">
			      </td>
			   </tr>
			</table>
		</div>	
   </form>
<%} %>
</html>