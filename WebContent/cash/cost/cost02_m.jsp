<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="cash.Bean_Cost"%>
<%@page import="cash.Bean_Member"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash" />

<%
	String usid = (String) session.getAttribute("idKey");
    int numb = Integer.parseInt(request.getParameter("numb"));
	//ChulBean cBean = cMgr.getChulnab(usid);  //입력자료 가져오기
	Bean_Cost cBean = cMgr.getCost2(numb);   //입력자료 가져오기
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
	if(document.costFrm.g_cost.value==""){
		alert("요금 종류를 입력해 주세요.");
		document.costFrm.g_cost.focus();
		return;
	}
	if(document.costFrm.yt.value==""){
		alert("이번달  계량값을 입력해 주세요.");
		document.costFrm.yt.focus();
		return;
	}
	document.costFrm.action = "cost02_p.jsp";
	document.costFrm.submit();
}
</script>
</head>

<body bgcolor="#FFFFCC" onLoad="costFrm.g_cost.focus()">
	<div align="center">
		<br /> <br />
		<form name="costFrm" method="post" action="cost02_p.jsp" >
			<table align="center" cellpadding="5" >
				<tr>
					<td align="center" valign="middle" bgcolor="#FFFFCC">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr align="center" bgcolor="#996600">
								<td colspan="3"><font color="#FFFFFF"><b>요금 내역 수정</b></font></td>
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
								<td>요금 종류</td>
								<td><select name=g_cost>
										<option value="0" selected>선택하세요.
										<option value="전기">전기
										<option value="가스">가스
										<option value="수도">수도
								</select></td>
								<script>document.costFrm.g_cost.value="<%=cBean.getG_cost()%>"</script>
								<td>수입 종류를 선택하세요</td>
							</tr>
							<tr>
								<td>전달 계량값</td>
								<td><input name="yt_1" size="15" value="<%=cBean.getYt_1()%>"></td>
								<td>전달 계량값을 적어주세요.</td>
							</tr>
							<tr>
								<td>이번달 계량값</td>
								<td><input name="yt" size="15" value="<%=cBean.getYt()%>"></td>
								<td>이번달 계량값을 적어주세요.</td>
							</tr>
							
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료"> &nbsp; &nbsp; 
								<input type="reset" value="다시쓰기"> &nbsp; &nbsp; 
								<input type="button" value="자료삭제" onClick="location.href='cost03.jsp?numb=<%=numb%>'"> &nbsp; &nbsp;
								<input type="button" value="신규자료" onClick="location.href='cost01.jsp'"> &nbsp; &nbsp;
								<input type="button" value="요금내역" onClick="history.go(-1)"></td>						
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>