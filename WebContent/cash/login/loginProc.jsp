<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<%
	  String cPath = request.getContextPath();
	  String usid = request.getParameter("usid");
	  String uspw = request.getParameter("uspw");
	  String url = cPath+"/cash/main/left.jsp";
	  String msg = "로그인에 실패 하였습니다.";
	  
	  boolean result = cMgr.loginMember(usid,uspw);
	  if(result){
	    session.setAttribute("idKey",usid);
	    msg = "로그인에 성공 하였습니다.";
	  }
%>
<script>
	alert("<%=msg%>");
	top.document.location.reload(); 
	location.href="<%=url%>";
</script>