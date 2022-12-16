<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="cash.Bean_Chul"%>
<%@page import="cash.Bean_Code"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<%
	String usid = (String) session.getAttribute("idKey");
%>
<html>
<head>
<title>현금출납부</title>
<link href="../member/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function chul_inputCheck(){
	if(document.chulFrm.nalja.value==""){
		alert("거래일자를 입력해 주세요.");
		document.chulFrm.nalja.focus();
		return;
	}
	if(document.chulFrm.g_suip.value=="/" && document.chulFrm.g_gichul.value=="/"){
		alert("수입 또는 지출의 종류를 선택해 주세요.");
		document.chulFrm.g_suip.focus();
		return;
	}
	if(document.chulFrm.g_cash.value=="/" && document.chulFrm.g_card.value=="/"){
		alert("현금 또는 카드의 종류를 선택해 주세요.");
		document.chulFrm.g_cash.focus();
		return;
	}
	if(document.chulFrm.suip.value=="/" && document.chulFrm.gichul.value=="/"){
		alert("수입액 또는 지출액을 입력해주세요.");
		document.chulFrm.suip.focus();
		return;
	}
	document.chulFrm.action = "chul01_p.jsp";
	document.chulFrm.submit();
}
</script>
</head>

<body bgcolor="#FFFFCC" onLoad="chulFrm.nalja.focus()">
	<div align="center">
		<br /><br />
		<form name="chulFrm" method="post" action="chul01_p.jsp">
			<table cellpadding="5">
				<tr>
					<td bgcolor="#FFFFCC">
						<table border="1" cellspacing="0" cellpadding="2" width="600">
							<tr bgcolor="#996600">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>현금출납 내용 기록</b></font></td>
							</tr>
							<tr>
								<td width="20%">아이디</td>
								<td width="50%">
									<input name="usid" size="15" value="<%=usid%>" readonly>
								</td>
								<td width="30%">접속 아이디입니다.</td>
							</tr>
							<tr>
								<td>거래일자</td>
								<td><input type="date" name="nalja" size="15"></td>
								<td>거래일자를 적어주세요.</td>
							</tr>
							<tr>
								<td>수입종류</td>
								<td><select name="g_suip">
										<option value="-" selected>선택하세요
									<%
										Vector <Bean_Code> vlist1 = null;
										vlist1 = cMgr.getCodelist2("Su");
										int listSize1 = vlist1.size();
										if (vlist1.isEmpty()) {
											out.println("등록된 자료가 없습니다.");
										} else {
											for ( int i = 0; i < listSize1; i++) {
												if (i == listSize1) break;
												Bean_Code bean = vlist1.get(i);
												String gubun = bean.getGubun(); %>
										<option value="<%=gubun%>"> <%=gubun %> 
										<% } // for
										}	// if%>
								</select></td>
								<td>수입종류를 선택하세요.</td>
							</tr>
							<tr>
								<td>지출종류</td>
								<td><select name="g_gichul">
										<option value="-" selected>선택하세요
									<%
										Vector <Bean_Code> vlist2 = null;
										vlist2 = cMgr.getCodelist2("Ji");
										int listSize2 = vlist2.size();
										if (vlist2.isEmpty()) {
											out.println("등록된 자료가 없습니다.");
										} else {
											for ( int i = 0; i < listSize2; i++) {
												if (i == listSize2) break;
												Bean_Code bean = vlist2.get(i);
												String gubun = bean.getGubun(); %>
										<option value="<%=gubun%>"> <%=gubun %> 
										<% } // for
										}	// if%>
								</select></td>
								<td>지출종류를 선택하세요.</td>
							</tr>
							<tr>
								<td>현금종류</td>
								<td><select name="g_cash">
									<option value="0" selected>선택하세요
										<option value="-" selected>선택하세요
									<%
										Vector <Bean_Code> vlist3 = null;
										vlist3 = cMgr.getCodelist2("Cs");
										int listSize3 = vlist3.size();
										if (vlist3.isEmpty()) {
											out.println("등록된 자료가 없습니다.");
										} else {
											for ( int i = 0; i < listSize3; i++) {
												if (i == listSize3) break;
												Bean_Code bean = vlist3.get(i);
												String gubun = bean.getGubun(); %>
										<option value="<%=gubun%>"> <%=gubun %> 
										<% } // for
										}	// if%>
								</select></td>
								<td>현금종류를 선택하세요.</td>
							</tr>
							<tr>
								<td>카드종류</td>
								<td><select name=g_card>
									<option value="-" selected> 선택하세요.
								<%
									Vector<Bean_Code> vlist4 = null;
									int listSize4 = 0;
									vlist4 = cMgr.getCodelist2("Cd");
									listSize4 = vlist4.size();
									if (vlist4.isEmpty()) {
										out.println("등록된 자료가 없습니다.");
									} else {
										for (int i = 0; i < listSize4; i++) {
											if ( i == listSize4) break;
											Bean_Code bean = vlist4.get(i);
											String gubun = bean.getGubun(); %>
											<option value="<%=gubun%>"> <%=gubun%>
										<% }	// for
									} // if %>
								
								</select></td>
								<td>카드종류를 선택하세요.</td>
							</tr>
							<tr>
								<td>은행종류</td>
								<td><select name="g_bank">
									<option value="0" selected>선택하세요
								<%
									Vector<Bean_Code> vlist5 = null;
									int listSize5 = 0;
									vlist5 = cMgr.getCodelist2("Ba");
									listSize5 = vlist5.size();
									if (vlist5.isEmpty()) {
										out.println("등록된 자료가 없습니다.");
									} else {
										for (int i = 0; i < listSize5; i++) {
											if ( i == listSize5) break;
											Bean_Code bean = vlist5.get(i);
											String gubun = bean.getGubun(); %>
											<option value="<%=gubun%>"> <%=gubun%>
										<% }	// for
									} // if %>
								</select></td>
								<td>은행종류를 선택하세요.</td>
							</tr>
							<tr>
								<td>지출내역</td>
								<td><input name="gichul_list" size="15"></td>
								<td>지출내역을 적어주세요.</td>
							</tr>
							<tr>
								<td>수입액</td>
								<td><input name="suip" size="15"></td>
								<td>수입액을 적어주세요.</td>
							</tr>
							<tr>
								<td>지출액</td>
								<td><input name="gichul" size="15"></td>
								<td>지출액을 적어주세요.</td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="bigo" size="30"></td>
								<td>비고 내용을 적어주세요.</td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								    <input type="button" value="자료입력" onClick="chul_inputCheck()"> &nbsp; &nbsp; 
								    <input type="reset"  value="다시쓰기"> &nbsp; &nbsp; 
  								    <input type="button" value="출납목록" onClick="history.go(-1)">						
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>