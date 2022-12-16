<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="cash.Bean_Chul"%>
<%@page import="cash.Bean_Code"%>
<%@page import="cash.Bean_Member"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash" />

<%
	String usid = (String) session.getAttribute("idKey");
    int numb = Integer.parseInt(request.getParameter("numb"));
	//ChulBean cBean = cMgr.getChulnab(usid);  //입력자료 가져오기
	Bean_Chul cBean = cMgr.getChul2(numb);   //입력자료 가져오기
	session.setAttribute("bean", cBean);       //입력자료 세션에 저장

    //session.setAttribute("id_Key1",usid);
    //session.setAttribute("id_Key2",numb);

	//String usid_1 = (String) session.getAttribute("id_Key1");
	//int usid_2 = (int) session.getAttribute("id_Key2");
	
	//System.out.println("자료확인2");
    //System.out.println(usid_1);
    //System.out.println(usid_2);
%>
<html>
<head>
<title>회원가입</title>
<link href="../member/style.css" rel="stylesheet" type="text/css" >
<script type="text/javascript">
function chul_inputCheck(){
	if(document.chulFrm.nalja.value==""){
		alert("거래날짜를 입력해 주세요.");
		document.chulFrm.nalja.focus();
		return;
	}
	document.chulFrm.action = "chul02_p.jsp";
	document.chulFrm.submit();
}
</script>
</head>

<body bgcolor="#FFFFCC" onLoad="chulFrm.nalja.focus()">
	<div align="center">
		<br /> <br />
		<form name="chulFrm" method="post" action="chul02_p.jsp" >
			<table align="center" cellpadding="5" >
				<tr>
					<td align="center" valign="middle" bgcolor="#FFFFCC">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr align="center" bgcolor="#996600">
								<td colspan="3"><font color="#FFFFFF"><b>현금 출납 내역 수정</b></font></td>
							</tr>
							<tr>
								<td width="20%">아이디</td>
								<td width="50%">
									<input name="usid" size="15" value="<%=usid%>" readonly>
								</td>
								<td width="30%">접속 아이디입니다.</td>
							</tr>
							<tr>
								<td>순번</td>
								<td><input name="numb" size="15" value="<%=numb%>" readonly></td>
								<td>순번 입니다.</td>
							</tr>
							<tr>
								<td>사용자 아이디</td>
								<td><input name="usid" size="15" value="<%=cBean.getUsid()%>" readonly></td>
								<td>사용자 아이디 입니다.</td>
							</tr>
							<tr>
								<td>거래일자</td>
								<td><input type="date" name="nalja" size="15" value="<%=cBean.getNalja()%>"></td>
								<td>거래일자를 적어주세요.</td>
							</tr>
							<tr>
								<td>수입 종류</td>
								<td><select name=g_suip>
										<option value="-" selected>선택하세요.
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
								<script>document.chulFrm.g_suip.value="<%=cBean.getG_suip()%>"</script>
								<td>수입 종류를 선택하세요</td>
							</tr>
							<tr>
								<td>지출 종류</td>
								<td><select name=g_gichul>
										<option value="-" selected>선택하세요.
									<%
										Vector <Bean_Code> vlist2 = null;
										vlist2 = cMgr.getCodelist2("Ji");
										int listSize2 = vlist2.size();
										if (vlist1.isEmpty()) {
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
								<script>document.chulFrm.g_gichul.value="<%=cBean.getG_gichul()%>"</script>
								<td>지출 종류를 선택하세요</td>
							</tr>
							<tr>
								<td>현금 종류</td>
								<td><select name=g_cash>
										<option value="-" selected>선택하세요.
									<%
										Vector <Bean_Code> vlist3 = null;
										vlist3 = cMgr.getCodelist2("Cs");
										int listSize3 = vlist3.size();
										if (vlist1.isEmpty()) {
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
								<script>document.chulFrm.g_casg.value="<%=cBean.getG_cash()%>"</script>
								<td>현금 종류를 선택하세요</td>
							</tr>
							<tr>
								<td>카드 종류</td>
								<td><select name=g_card>
										<option value="-" selected>선택하세요.
									<%
										Vector <Bean_Code> vlist4 = null;
										vlist4 = cMgr.getCodelist2("Cd");
										int listSize4 = vlist4.size();
										if (vlist4.isEmpty()) {
											out.println("등록된 자료가 없습니다.");
										} else {
											for ( int i = 0; i < listSize4; i++) {
												if (i == listSize4) break;
												Bean_Code bean = vlist4.get(i);
												String gubun = bean.getGubun(); %>
										<option value="<%=gubun%>"> <%=gubun %> 
										<% } // for
										}	// if%>
								</select></td>
								<script>document.chulFrm.g_card.value="<%=cBean.getG_card()%>"</script>
								<td>카드 종류를 선택하세요</td>
							</tr>
							<tr>
								<td>은행 종류</td>
								<td><select name=g_bank>
										<option value="-" selected>선택하세요.
									<%
										Vector <Bean_Code> vlist5 = null;
										vlist5 = cMgr.getCodelist2("Ba");
										int listSize5 = vlist5.size();
										if (vlist5.isEmpty()) {
											out.println("등록된 자료가 없습니다.");
										} else {
											for ( int i = 0; i < listSize5; i++) {
												if (i == listSize5) break;
												Bean_Code bean = vlist5.get(i);
												String gubun = bean.getGubun(); %>
										<option value="<%=gubun%>"> <%=gubun %> 
										<% } // for
										}	// if%>
								</select></td>
								<script>document.chulFrm.g_bank.value="<%=cBean.getG_bank()%>"</script>
								<td>은행 종류를 선택하세요</td>
							</tr>
							<tr>
								<td>지출내역</td>
								<td><input name="gichul_list" size="15" value="<%=cBean.getGichul_list()%>"></td>
								<td>지출내역을 적어주세요.</td>
							</tr>
							<tr>
								<td>수입액</td>
								<td><input name="suip" size="15" value="<%=cBean.getSuip()%>" ></td>
								<td>수입액입니다.</td>
							</tr>
							<tr>
								<td>지출액</td>
								<td><input name="gichul" size="15" value="<%=cBean.getGichul()%>"></td>
								<td>지출액을 적어주세요.</td>
							</tr>
							<tr>
								<td>잔액</td>
								<td><input name="jan" size="15" value="<%=cBean.getJan()%>" readonly></td>
								<td>잔액금액을 적어주세요.</td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="bigo" size="30" value="<%=cBean.getBigo()%>" ></td>
								<td>비고 내용을 적어주세요.</td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료"> &nbsp; &nbsp; 
								<input type="reset" value="다시쓰기"> &nbsp; &nbsp; 
								<input type="button" value="자료삭제" onClick="location.href='chul03.jsp?numb=<%=numb%>'"> &nbsp; &nbsp;
								<input type="button" value="신규자료" onClick="location.href='chul01.jsp'"> &nbsp; &nbsp;
								<input type="button" value="출납내역" onClick="history.go(-1)"></td>						
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>