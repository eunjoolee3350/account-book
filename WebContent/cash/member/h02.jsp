<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="cash.Bean_Member"%>
<%@ page import="java.util.Vector"%>
<%@ page import="cash.Mgr_Cash"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<%
	request.setCharacterEncoding("UTF-8");

	String check = request.getParameter("check");
	String perm1 = request.getParameter("perm1");
	String perm2 = request.getParameter("perm2");
	
	int recnum = Integer.parseInt(request.getParameter("numb"));
	if (check == null) check = "N";
	if (perm1 == null) perm1 = "XX";
	if (perm2 == null) perm2 = "XX";
	// 여기서 GG는 클릭을 했다는 뜻
	if (perm2.equals("GG")) {
		cMgr.updatePerm(recnum, perm1);
	}
	
	int totalRecord=0;
	int listSize=0;
		Vector<Bean_Member> vlist = null;
	String usid = (String) session.getAttribute("idKey");
	Bean_Member bBean = cMgr.getMember2(usid);
	String us_state = bBean.getState();
	String us_appro = bBean.getAppro();
	int numb = bBean.getNumb();
	
	totalRecord = cMgr.getTotalCount(us_state, check);
%>

<html>
<head>
<title>copy</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function h02_m(numb){
		document.readFrm.numb.value=numb;
		document.readFrm.action="h02_m.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function h03(numb){
		document.readFrm.numb.value=numb;
		document.readFrm.action="h03.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
	
	function h02_appro(numb, appro){
			document.readFrm.numb.value=numb;
			document.readFrm.perm1.value=appro;
			document.readFrm.perm2.value="GG";
			document.readFrm.action="h02.jsp";
			document.readFrm.target="content";
			document.readFrm.submit();

	}
</script>

<body leftmargin="0" topmargin="0" bgcolor="#FFFFCC">

<div align="center">
    <br/>
		<h2>회 원 명 단</h2>
    <br>
	<table totalRecorder" width="700" border="1">
		<tr>
			<td>회원수 : <%=totalRecord%></td>
		</tr>
	</table>
	<table align="center" width="700" cellpadding="3">
			<%		vlist = cMgr.getMemberList(us_state, check);
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물 번호
				  if (vlist.isEmpty()) {
					out.println("등록된 게시물이 없습니다.");
				  } else {
			%>
				  <table width="700" cellpadding="2" cellspacing="0" border="1">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>번 호</td>
						<td>아이디</td>
						<td>권 한</td>
						<td>승인여부</td>
						<td>이 름</td>
						<td>전화번호</td>
						<td>이메일</td>
						<td>수정</td>
						<td>삭제</td>
						
					<%
						for (int i = 0;i<listSize; i++) {
							if (i == listSize) break;
							Bean_Member bean = vlist.get(i);
							numb = bean.getNumb();
							usid = bean.getUsid();
							String state = bean.getState();
							String appro = bean.getAppro();
							String name = bean.getName();
							String telp = bean.getTelp();
							String email = bean.getEmail();
							
							
					%>
					<tr>
						<td align="center">
						   <%=numb%>
						</td>
						<td align="center">
 						   <%=usid%>
						</td>
						<td align="center">
						   <%=state%>
						</td>
						<td align="center">
						<% 
							if (us_state.equals("관리자")) {
						%>
						   <a href="javascript:h02_appro('<%=numb%>','<%=appro%>')"><%=appro%></a>
						   <%
							} else {
						   %> <%=appro%>
						   <% } %>
						</td>
<%--   --%>
						<td align="center">
						   <%=name%>
						</td>
						<td align="center">
						   <%=telp%>
						</td>
						<td align="center">
						   <%=email%>
						</td>
						<td align="center">
						   <a href="javascript:h02_m('<%=numb%>')">수정</a>
						</td>
						<td align="center">
						   <a href="javascript:h03('<%=numb%>')">삭제</a>
						</td>
					</tr>
					<%}//for%>
				</table> <%
 			}//if
 		%>
			</td>
		</tr>
		</table>
	<form name="readFrm" method="get">
	    <br>
		<input type="button" value="신규회원" onClick="location.href='h01.jsp'"> &nbsp; &nbsp;
		<input type="button" value="전체회원" onClick="location.href='h02.jsp?check=N&numb=0'"> &nbsp; &nbsp;
		<input type="button" value="승인회원" onClick="location.href='h02.jsp?check=J&numb=0'"> &nbsp; &nbsp;
		<input type="button" value="미승인회원" onClick="location.href='h02.jsp?check=Y&numb=0'"> &nbsp; &nbsp;
		<input type="hidden" name="numb"> 
		<input type="hidden" name="perm1"> 
		<input type="hidden" name="perm2"> 
	</form>
</div>


</body>
</html>