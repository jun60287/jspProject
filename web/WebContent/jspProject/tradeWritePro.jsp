<%@page import="java.io.IOException"%>
<%@page import="web.pet.model.TradeDAO"%>
<%@page import="web.pet.model.TradeDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>글 작성(프로)</title>
</head>
<%
   request.setCharacterEncoding("UTF-8");
   //작성자, 제목, 지역, 내용, 사진, 비밀번호, num, ref, re_step, re_level
   
   if(session.getAttribute("sId") == null) { %>
      <script>
         alert("잘못된 접근입니다!");
         window.location.href="main.jsp";
      </script>   
<%   }else{
   ///////////////////////////현재수정
   try{
   String path = request.getRealPath("save");
   int max = 1024*1024*10;
   String enc = "UTF-8";
   DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
   MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
   
   String sysname = mr.getFilesystemName("picture");
   String contentT = mr.getContentType("picture");
   if(sysname != null){
      String[] ct = contentT.split("/");
      if(!(ct[0].equals("picture"))){
         File f = new File(sysname);
         f.delete();
      %>
         <script type="text/javascript">
            alert("이미지 파일이 아닙니다. 이미지 파일을 업로드해주세요.");
            history.go(-1);
         </script>      
      <%   
      }
   }
   
   int num = 0, ref = 0, re_step = 0, re_level = 0;
   if(mr.getParameter("num") != null && mr.getParameter("ref") != null && mr.getParameter("re_step") != null && mr.getParameter("re_level") != null){
      num = Integer.parseInt(mr.getParameter("num"));
      ref = Integer.parseInt(mr.getParameter("ref"));
      re_step = Integer.parseInt(mr.getParameter("re_step"));
      re_level = Integer.parseInt(mr.getParameter("re_level"));
   }
   
   TradeDTO article = new TradeDTO();
   String id = (String)session.getAttribute("sId");
   article.setNum(num);
   article.setId(id);
   article.setPass(mr.getParameter("pass"));   
   if(!mr.getParameter("pass").equals("")){
   article.setLocal(mr.getParameter("local"));
   article.setSubject(mr.getParameter("subject"));
   article.setTime(new Timestamp(System.currentTimeMillis()));
   article.setContent(mr.getParameter("content"));
   article.setPicture(sysname);
   article.setRef(ref);
   article.setRe_step(re_step);
   article.setRe_level(re_level);
   TradeDAO dao = new TradeDAO();
   dao.insertArticle(article);
   response.sendRedirect("tradeList.jsp");
   ///////////////////////////현재수정
   }else{%>
      <script>alert('비밀번호를 입력하세요'); history.back();</script>
   <%} %>
      
   
   <%}catch(IOException e){%>
      <script>
      alert("접근 오류");
      window.location.href("main.jsp");
      </script>
<%   }
%>   

<%   }%>
<body>

</body>
</html>