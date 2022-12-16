<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@page import="cash.Bean_Chul"%>
<%@page import="cash.Bean_Member"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<jsp:useBean id="cBean" class="cash.Bean_Chul"/>
<jsp:setProperty  name="cBean" property="*"/>

<%
	  boolean result = cMgr.updateChul(cBean);
	  if(result){
%>
<script type="text/javascript">
		alert("입력자료를 수정 하였습니다.");
		location.href="chul02.jsp";
</script>
<% }else{%>
<script type="text/javascript">
		
		alert("입력자료 수정에 실패 하였습니다.");
		history.back();
</script>
<%} %>