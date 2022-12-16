<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="cash.Bean_Member"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash" />
<html>
<head>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<%
	request.setCharacterEncoding("EUC-KR");
	String usid = (String) session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));
    String cPath = request.getContextPath();

	Bean_Member gBean = cMgr.getMember2(usid);  //회원자료 가져오기
    
	//System.out.println("자료확인");
    //System.out.println(gBean.getUspw());
    //System.out.println(numb); 
    
	if (request.getParameter("pass") != null) {
		String inPass = request.getParameter("pass");
		String dbPass = gBean.getUspw();
		if (inPass.equals(dbPass)) {
	cMgr.deleteMember(numb);
	String url = "h02.jsp?check=N&numb=0";
	response.sendRedirect(url);
		} else {
%>
<script type="text/javascript">
	alert("입력하신 비밀번호가 아닙니다.");
	history.back();
</script>
<%}
	} else {
%>
<script type="text/javascript">
	function check() {
		if (document.delFrm.pass.value == "") {
			alert("패스워드를 입력하세요.");
			document.delFrm.pass.focus();
			return false;
		}
		document.delFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br/><br/>
		<table width="300" cellpadding="3">
			<tr>
				<td bgcolor=#dddddd height="21" align="center">
					[한라산]사용자의 비밀번호를 입력해주세요.
				</td>
			</tr>
		</table>
		<form name="delFrm" method="post" action="h03.jsp">
			<table width="300" cellpadding="2">
				<tr>
					<td align="center">
						<table>
							<tr>
								<td>레코드 번호</td>
								<td><%=gBean.getNumb()%></td>
							</tr>
							<tr>
								<td>사용자 권한</td>
								<td><%=gBean.getState()%></td>
							</tr>
							<tr>
								<td>사용자 ID</td>
								<td><%=gBean.getUsid()%></td>
							</tr>
							<tr>
								<td>사용자 이름</td>
								<td><%=gBean.getName()%></td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td><%=gBean.getTelp()%></td>
							</tr>
							<tr>
								<td align="center">
									<input type="password" name="pass" size="17" maxlength="15">
								</td>
							</tr>
							<tr>
								<td><hr size="1" color="#eeeeee"/></td>
							</tr>
							<tr>
								<td align="center">
									<input type="button" value="삭제완료" onClick="check()"> 
									<input type="reset" value="다시쓰기">
									<input type="button" value="뒤로" onClick="history.go(-1)">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="numb" value="<%=numb%>">
		</form>
	</div>
	<%}%>
</body>
</html>