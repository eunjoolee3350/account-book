<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="cash.Bean_Member"%>
<%@page import="cash.Bean_Chul"%>
<%@page import="cash.Bean_Code"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash" />

<html>
<head>
<title>JSP Board</title>
<link href="../member/style.css" rel="stylesheet" type="text/css" >
<%
	String usid = (String) session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));

	Bean_Member gBean = cMgr.getMember2(usid);     //회원 자료 가져오기
    Bean_Chul   cBean = cMgr.getChul2(numb);   //출납 자료 가져오기
    
	//System.out.println("자료확인");
    //System.out.println(gBean.getName());
    //System.out.println(cBean.getNumb()); 
    	
	if (request.getParameter("pass") != null) {
		String inPass = request.getParameter("pass");
		String dbPass = gBean.getUspw();
		if (inPass.equals(dbPass)) {
	cMgr.deleteChul(numb);
	String url = "chul02.jsp";
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
		<table width="400" cellpadding="3">
			<tr>
				<td bgcolor=#dddddd height="21" align="center">
					자료를 삭제합니다.
				</td>
			</tr>
		</table>
		<form name="delFrm" method="post" action="chul03.jsp">
			<table width="400" cellpadding="2">
				<tr>
					<td align="center">
						<table>
							<tr>
								<td>순번</td>
								<td><%=cBean.getNumb()%></td>
							</tr>
							<tr>
								<td>사용자 아이디</td>
								<td><%=cBean.getUsid()%></td>
							</tr>
							<tr>
								<td>거래일자</td>
								<td><%=cBean.getNalja()%></td>
							</tr>
							<tr>
								<td>수입 또는 지출</td>
								<td>
								<%
									if (cBean.getG_suip() != "-") {
										%> <%=cBean.getG_suip()%>
								<%} else {%>
									<%=cBean.getG_gichul()%>
									<% } %>
								</td>
							</tr>
							<tr>
								<td>지출내역</td>
								<td><%=cBean.getGichul_list()%></td>
							</tr>
							<tr>
								<td>수입액</td>
								<td><%=cBean.getSuip()%></td>
							</tr>
							<tr>
								<td>지출액</td>
								<td><%=cBean.getGichul()%></td>
							</tr>
							<tr>
								<td>잔액내역</td>
								<td><%=cBean.getJan()%></td>
							</tr>
							<tr>
								<td align="center">
									패스워드 &nbsp; &nbsp;&nbsp; &nbsp; 
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