<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<jsp:useBean id="cBean" class="cash.Bean_Code"/>
<jsp:setProperty  name="cBean" property="*"/>

<%
	  boolean result = cMgr.updateCode(cBean);
	  if(result){
%>
<script type="text/javascript">
		alert("코드 정보를 수정 하였습니다.");
		location.href="code02.jsp?check=N";
</script>
<% } else {%>
<script type="text/javascript">
		alert("코드 정보 수정에 실패 하였습니다.");
		history.back();
</script>
<% } %>