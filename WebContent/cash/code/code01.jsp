<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="cash.Bean_Code"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<%
	String usid = (String) session.getAttribute("idKey");
	Bean_Code gBean = cMgr.getCode();    	 // 코드 가져오기
%>
<html>
<head>
<title>신규 코드 등록</title>
<link href="../member/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="code_script.js"></script>

</head>

<body bgcolor="#FFFFCC" onLoad="codeFrm.usid.focus()">
	<div align="center">
		<br /><br />
		<form name="codeFrm" method="post" action="code01_p.jsp">
			<table cellpadding="5">
				<tr>
					<td bgcolor="#FFFFCC">
						<table border="1" cellspacing="0" cellpadding="2" width="600">
							<tr bgcolor="#996600">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>신규 코드 등록</b></font></td>
							</tr>
							<tr>
								<td>사용자 아이디</td>
								<td>
									<input name="usid" size="15" 
										value=<%=usid%> readonly>
								</td>
								<td>수정불가 : 사용자의 아이디 입니다.</td>
							</tr>
							<tr>
								<td>Code</td>
								<td>
									<input name="code" size="15">
								</td>
								<td>코드를 적어주세요.</td>
							</tr>
							<tr>
								<td>세부 내용</td>
								<td>
									<input name="gubun" size="15">
								</td>
								<td>세부 내용을 적어주세요.</td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								    <input type="button" value="코드등록" onclick="code_inputCheck()"> &nbsp; &nbsp; 
								    <input type="reset" value="다시쓰기"> &nbsp; &nbsp; 
  								    <input type="button" value="코드목록" onClick="history.go(-1)">						
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