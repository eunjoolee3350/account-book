<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="cash.Bean_Cost"%>
<%@page import="cash.Bean_Code"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<%
	String usid = (String) session.getAttribute("idKey");
%>
<html>
<head>
<title>요금계산</title>
<link href="../member/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="cost_script.js">
/*function chul_inputCheck(){
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
}*/
</script>
</head>

<body bgcolor="#FFFFCC" onLoad="costFrm.g_cost.focus()">
	<div align="center">
		<br /><br />
		<form name="costFrm" method="post" action="cost01_p.jsp">
			<table cellpadding="5">
				<tr>
					<td bgcolor="#FFFFCC">
						<table border="1" cellspacing="0" cellpadding="2" width="600">
							<tr bgcolor="#996600">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>요금계산하기</b></font></td>
							</tr>
							<tr>
								<td width="20%">아이디</td>
								<td width="50%">
									<input name="usid" size="15" value="<%=usid%>" readonly>
								</td>
								<td width="30%">접속 아이디입니다.</td>
							</tr>
							<tr>
								<td>요금 종류</td>
								<td><select name="g_cost">
									<option value="전기">전기
									<option value="가스">가스
									<option value="수도">수도
								</select></td>
								<td>요금종류를 적어주세요.</td>
							</tr>
							<tr>
								<td>전달 계량값</td>
								<td><input name="yt_1" size="15"></td>
								<td>전달 계량값을 입력하세요.</td>
							</tr>
							<tr>
								<td>이번달 계량값</td>
								<td><input name="yt" size="15"></td>
								<td>이번달 계량값을 입력하세요</td>
							</tr>
							
							<tr>
								<td colspan="3" align="center">
								    <input type="button" value="사용량 입력" onClick="cost_inputCheck()"> &nbsp; &nbsp; 
								    <input type="reset"  value="다시쓰기"> &nbsp; &nbsp; 
  								    <input type="button" value="요금 목록" onClick="history.go(-1)">						
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