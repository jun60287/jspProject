<%@page import="web.pet.model.QNADTO"%>
<%@page import="web.pet.model.QNADAO"%>
<%@page import="java.util.List"%>
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
   #list { width: 650px; }
</style>
</head>
<%      
   
   String id = null;
   String sId = (String)session.getAttribute("sId");
   Cookie [] cs = request.getCookies();
   if(cs != null && session.getAttribute("sId") == null){
      for(Cookie coo : cs){
         if(coo.getName().equals("cId")) id = coo.getValue();
      }session.setAttribute("sId", id);
   }

   request.setCharacterEncoding("UTF-8");
   
   QNADAO dao = new QNADAO();
   QNADTO dto = null;
   QNADTO dto1 = null;
   
   List list = null;
   
   int count = dao.getQNANum();      // QNA 게시글 숫자
   int pageNum = 1;   
   int contentsSize = 3;
   double currentPage = 0;
   currentPage = (double)count/contentsSize;
   
   if(request.getParameter("pageNum")!=null){pageNum = Integer.parseInt(request.getParameter("pageNum"));}   
      
   int startNum = count - (pageNum-1)*contentsSize; 
   int endNum = count - (pageNum-1)*contentsSize - contentsSize + 1 ;
   if(endNum<0){}
   if(startNum == 0 && endNum ==0){
      startNum = count;
      endNum = count - contentsSize+1;
   }

   list = dao.getQNA(startNum, endNum, contentsSize);         // DTO 에 게시글 담아주기
//   list = dao.getQNA();
      
%>
<body>
   <header>
      <jsp:include page="petHeader.jsp" flush="false"/>
   </header>
   <section>
   <h1 align="center" style="margin-bottom: 0; color: #3e6383;">Q n A</h1>
   <br/><br/>
<% if(list != null){ %>
   <div class="table">
      <table id="list">
         <tr>
         <form action = "qnaPro.jsp" method="post">   
            <td colspan="6" style="border-right: none;" ><textarea cols="60" rows="8" name="content"></textarea>
            </td><td style="border-left: none;"><input class="listButt" type="submit" value="글 작성"></td>
            
            <%for(int i = list.size()-1 ; i > -1 ; i --){
            dto = (QNADTO)list.get(i);
            dto.getRef();
            if(!dao.checkContent(dto.getRef())){            
               
            %>   
            
            <input type="hidden" name="ref" value="<%=dto.getRef() %>">
         </tr>
      </form>
      
         <tr>      
            <td style="width:40px;">No.<br><%=dto.getRnum() %></td>            
               <td colspan = "5">
                  글쓴이 : <%= dto.getId()%> // 작성 날짜/시간 : <%= dto.getReg()%>
                  <br>
                  <%= dto.getContent()%><br>
               </td>
            <td>
         <form action = "qnaForm.jsp" method="post">                        
            <%if(sId != null && sId.equals("admin")){ %><input type="submit" value="답글"><%} %>
            <input type = "hidden" name="ref" value="<%=dto.getRef() %>">
         </form>   
      
         <form action = "qnaDelete.jsp" method="post">      
            <%if(sId != null && (sId.equals(dto.getId()) || sId.equals("admin"))){ %>   
            <input class="listButt" type="submit" value="삭제">         
            <%} %>                           
            <p align="center">                                          
               <input type="hidden" value="<%=dto.getRef()%>" name="ref">
               <input type = "hidden" name="ref" value="<%=dto.getRef() %>">
         </form>                  
         </tr>   
         
      
            <%if(request.getParameter("ref") != null && Integer.parseInt(request.getParameter("ref")) == dto.getRef()){ %>
            <tr>
      <form action = "qnaReplePro.jsp" method="post">
               <td colspan="5">
               <textarea cols="35" rows="1" name="reple<%=dto.getRef()%>">
               </textarea></td>
               <td><input class="listButt"  type="submit" value="등록"><input type = "hidden" name="ref" value="<%=dto.getRef() %>"></td>            
      </form>   
            </tr>      
            <%} %>
                     
            <%}else{count--; %>
            <tr>
               <td style="width:40px;">No.<br><%=dto.getRnum() %></td>               
               <td colspan = "5"><%= dto.getContent()%></td>
            </tr>         
                  <%} %>         
            
            <%
            if(dao.getCount(dto.getRef()) != 0){
               List getReple = dao.getReple(dto.getRef());                     
               
               for(int j = getReple.size()-1 ; j > -1 ; j--){
                  dto = (QNADTO)getReple.get(j);
                  if(!dao.checkContentReple(dto.getRefQNA(), dto.getRe_levelQNA())){
               %>
                  <form action = "qnaDeleteReple.jsp" method="post">               
                           
                  <tr>
                     <td>&nbsp;&nbsp;&nbsp;RE</td>                                             
                     <td colspan = "5"><%= dto.getContentQNA() %>                                       
                           <input type="hidden" value="<%=dto.getRe_levelQNA() %>" name="re_level">
                           <input type="hidden" value="<%=dto.getRefQNA() %>" name="ref">
                           
                     </td>
                     <td>                        
                           <%if( sId != null && (dto.getIdQNA().equals(sId) || sId.equals("admin"))){ %>
                           <input class="listButt" type="submit" value="삭제" class="a">                              
                           <%} %>   
                     </td>
                  </tr>   
                  </form>                                                                                       
               <%
                  }else{%>
                  <tr>
                     <td><img src="/web/save/repleicon.png"></td>
                     <td colspan = "5"><%= dto.getContentQNA() %></td>
                  </tr>                           
                  <%}
               }
            }
            %>   
         
         <%} %>
         <tr><td colspan = "7"><%for(int i = 1 ; i < (int)Math.ceil(currentPage)+1 ; i++){ %>
               <a href="qnaForm.jsp?pageNum=<%=i%>"><%= i%></a>
                          <% } %></td></tr>
      </table>
      <br/>
      <input class="listButt" type="button" value="메인 페이지 이동" onclick="window.location.href='main.jsp'">            
      <br/>
      <br/>
   </div>
   <br/>
<%}else{ 
   %>
         <form action="qnaPro.jsp" method="post">
            <table>   
               <tr>
                  <td colspan="4"><textarea cols="50" rows="10" name="content"></textarea><input type="hidden" name="ref" value="1"></td>            
                  <td><input class="listButt" type="submit" value="글 작성"></td>            
               </tr>
            </table>
         </form>
<%} %>
      <br/><br/>
      <br/><br/>
      <br/><br/>
      <br/><br/>
      <br/><br/>
   </section>
   <footer>
      <jsp:include page="petFooter.jsp" flush="false"/>
   </footer>
   </body>
</html>