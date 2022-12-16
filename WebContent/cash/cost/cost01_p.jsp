<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<jsp:useBean id="cBean" class="cash.Bean_Cost"/>
<jsp:setProperty  name="cBean" property="*"/>
<%
	  boolean result = cMgr.insertCost(cBean);
	  if(result){
%>
<script type="text/javascript">
		alert("내용을 입력 하였습니다.");
		location.href="cost02.jsp";
</script>
<% }else{%>
<script type="text/javascript">
		alert("내용 입력에 실패 하였습니다.");
		history.back();
</script>
<%} %>