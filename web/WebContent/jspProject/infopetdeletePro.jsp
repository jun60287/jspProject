<%@page import="web.pet.model.PetsitterDAO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>펫시터 정보 삭제페이지(프로)</title>
</head>
<%
   //세션쿠키검사
   //세션이 있는 경우에만 진행 쿠키만 있을 경우 세션 만들어주고 진행
   String sId = (String)session.getAttribute("sId");
   String cId = null;
   Cookie[] coo = request.getCookies();
   if(coo != null){
      for(Cookie c : coo ){
         if(c.getName().equals("cId")) cId = c.getValue();
      }
   }
   
   if(sId == null && cId == null){%>
      <script>
         alert("로그인 후 이용 가능한 페이지입니다.");
         window.location.href="loginForm.jsp";
      </script>
<%   }else{ 
      if(sId == null && cId != null){
         session.setAttribute("sId", cId);
         sId = cId;
      }
      if(sId.equals("admin") || cId != null){%>
	  	<script>
	  	alert("접근 오류");
	  	window.location.href="main.jsp";
	  	</script>	
	  <%}
      String id = (String)session.getAttribute("sId");
      String pw = request.getParameter("pw");
      String path = request.getRealPath("save");
      PetsitterDAO dao = new PetsitterDAO();
      String photoName = dao.getPhotoNamePet(id);
      if(photoName != null){
         path += ("\\" + photoName);
         File f = new File(path);
         f.delete();
      }
      int result = dao.deletepetMember(id, pw);
      if(result == 1){
         dao.deleteGetpet(id);
         session.invalidate();
         Cookie[] cs = request.getCookies();
         if(cs != null){
            for(Cookie c : cs){
               if(c.getName().equals("cId")){   
                  c.setMaxAge(0);
                  response.addCookie(c);
               }
            }
         }
%>
	<script>
		alert("펫시터가 해지되었습니다.");
		window.location.href = "main.jsp";
	</script>

<%		}else{ %>
			<script>
				alert("비밀번호가 맞지 않습니다.");
				history.go(-1);
			</script>
<%		}
	
	}
%>
<body>

</body>
</html>