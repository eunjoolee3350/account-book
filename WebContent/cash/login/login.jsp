<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="cash.Bean_Member"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash" />
<%
	String cPath = request.getContextPath();
	String usid = (String)session.getAttribute("idKey");
	Bean_Member gBean = cMgr.getMember2(usid);  //회원자료 가져오기
%>
<html>
<head>
<title>로그인</title>
<link href="../main/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function loginCheck() {
		if (document.loginFrm.usid.value == "") {
			alert("아이디를 입력해 주세요.");
			document.loginFrm.usid.focus();
			return;
		}
		if (document.loginFrm.uspw.value == "") {
			alert("비밀번호를 입력해 주세요.");
			document.loginFrm.uspw.focus();
			return;
		}
		document.loginFrm.action = "<%=cPath%>/cash/login/loginProc.jsp";
		document.loginFrm.submit();
	}
	
	function memberForm(){
		document.loginFrm.target = "content";
		document.loginFrm.action = "<%=cPath%>/cash/member/h01.jsp";
		document.loginFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
<br/><br/>
 <div align="center">
		<%
			if (usid != null) {
		%>
		<b><%=gBean.getName()%></b>[<%=usid%>]<b>[<%=gBean.getState()%>][<%=gBean.getNumb()%>]</b>님 환영 합니다.
		<p>제한된 기능을 사용 할 수가 있습니다.
		<%gBean.getNumb(); %>
		<p>
			<a href="<%=cPath%>/cash/login/logout.jsp">[로그아웃]</a>
			<%} else {%>
		<form name="loginFrm" method="post" action="loginProc.jsp">
			<table>
				<tr>
					<td align="center" colspan="2"><h4>로그인 </h4></td>
				</tr>
				<tr>
					<td>아 이 디</td>
					<td><input name="usid" value=""></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="uspw" value=""></td>
				</tr>
				<tr>
					<td colspan="2">
						<div align="right">
							<input type="button" value="로그인" onclick="loginCheck()">&nbsp;
							<input type="button" value="회원가입" onClick="memberForm()" >
						</div>
					</td>
				</tr>
			</table>
		</form>
		<%}%>
	</div>
	<form name="readFrm" method="get">
		<input type="hidden" name="numb"> 
	</form>
</body>
</html>