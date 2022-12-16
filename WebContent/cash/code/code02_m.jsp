<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="cash.Bean_Code"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash" />
<jspLuseBean id="cBean" class="cahs.Bean_Code" />

<%
	String usid = (String) session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));
	//Bean_Car carBean = carMgr.getCar(usid);  //입력자료 가져오기
	Bean_Code cBean = cMgr.getCode2(numb);  //입력자료 가져오기
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
<title>코드 정보 수정</title>
<link href="../member/style.css" rel="stylesheet" type="text/css" >
</head>

<body bgcolor="#FFFFCC" onLoad="codeFrm.code.focus()">
	<div align="center">
		<br /> <br />
		<form name="codeFrm" method="post" action="code02_p.jsp" >
			<table align="center" cellpadding="5" >
				<tr>
					<td align="center" valign="middle" bgcolor="#FFFFCC">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr align="center" bgcolor="#996600">
								<td colspan="3"><font color="#FFFFFF"><b>코드 정보 수정</b></font></td>
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
								<td>순번</td>
								<td>
									<input name="numb" size="15" 
										value=<%=numb%> readonly>
								</td>
								<td>수정불가 : 코드의 순번 입니다.</td>
							</tr>
							<tr>
								<td>Code</td>
								<td><input name="code" size="15"
									value="<%=cBean.getCode()%>" ></td>
								<td>Code를 입력하세요</td>
							</tr>
							<tr>
								<td>세부 내용</td>
								<td><input name="gubun" size="15"
									value="<%=cBean.getGubun()%>" ></td>
								<td>코드의 세부내용을 적어주세요.</td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료"> &nbsp; &nbsp; 
								<input type="reset" value="다시쓰기"> &nbsp; &nbsp; 
								<input type="button" value="코드삭제" onClick="location.href='code03.jsp?numb=<%=cBean.getNumb()%>'"> &nbsp; &nbsp;
								<input type="button" value="신규코드등록" onClick="location.href='code01.jsp'"> &nbsp; &nbsp;
								<input type="button" value="코드목록" onClick="history.go(-1)"></td>						
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>