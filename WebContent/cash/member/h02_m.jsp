
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="cash.Bean_Member"%>
<%@page import="cash.Mgr_Cash"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<jsp:useBean id="cBean" class="cash.Bean_Member"/>
<% 
	String usid = (String) session.getAttribute("idKey");
	Bean_Member gBean = cMgr.getMember2(usid);  //회원자료 가져오기
    String state = gBean.getState();
	String appro = gBean.getAppro();
	int numb = gBean.getNumb();
	session.setAttribute("bean", gBean);//회원자료 세션에 저장

	//System.out.println("자료확인");
    //System.out.println(usid);
    //System.out.println(numb);t.println(numb); 
%>
<html>
<head>
<title>회원수정</title>
<link href="style.css" rel="stylesheet" type="text/css" >
<script type="text/javascript">
	function zipCheck() {
		url = "zipSearch.jsp?search=n";
		window.open(url, "ZipCodeSearch","width=500,height=300,scrollbars=yes");
	}
</script>
</head>

<body bgcolor="#FFFFCC" onLoad="regFrm.usid.focus()">
	<div align="center">
		<br /> <br />
		<form name="regFrm" method="post" action="h02_p.jsp" >
			<table align="center" cellpadding="5" >
				<tr>
					<td align="center" valign="middle" bgcolor="#FFFFCC">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr align="center" bgcolor="#996600">
								<td colspan="3"><font color="#FFFFFF"><b>회원 수정</b></font></td>
							</tr>
							<tr>
								<td width="20%">아이디</td>
								<td width="80%"><input name="usid" size="15"
									value="<%=usid%>" readonly></td>
							</tr>
							<tr>
								<td>번호</td>
								<td><input name="numb" size="15"
									value="<%=gBean.getNumb()%>" readonly></td>
							</tr>
							<tr>
								<td>패스워드</td>
								<td><input type="password" name="uspw" size="15"
									value="<%=gBean.getUspw()%>"></td>
							</tr>
								<td>회원 권한</td>
								<td><input name="state" readonly
									value="<%=gBean.getState()%>">
							</tr>
							<tr>
								<td>승인 여부</td>
								<td><input name="appro" readonly
									value = "<%=gBean.getAppro()%>"></td>
							</tr>
							<tr>
								<td>이름</td>
								<td><input name="name" size="15"
									value="<%=gBean.getName()%>"></td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td><input name="telp" size="15"
									value="<%=gBean.getTelp()%>"></td>
							</tr>
							<tr>
								<td>성별</td>
								<td>남<input type="radio" name="gend" value="1"
									<%=gBean.getGend().equals("1") ? "checked" : ""%>> 
									여<input type="radio" name="gend" value="2"
									<%=gBean.getGend().equals("2") ? "checked" : ""%>>
								</td>
							</tr>
							<tr>
								<td>생년월일</td>
								<td><input name="birth" size="6"
									value="<%=gBean.getBirth()%>">
									ex)830815</td>
							</tr>
							<tr>
								<td>Email</td>
								<td><input name="email" size="30"
									value="<%=gBean.getEmail()%>">
								</td>
							</tr>
							<tr>
								<td>우편번호</td>
								<td><input name="post" size="5"
									value="<%=gBean.getPost()%>" readonly> <input
									type="button" value="우편번호찾기" onClick="zipCheck()"></td>
							</tr>
							<tr>
								<td>주소</td>
								<td><input name="addr" size="45" 
								           value="<%=gBean.getAddr()%>"></td>
							</tr>
							<tr>
								<td>취미</td>
								<td>
									<%
										String list[] = { "인터넷", "여행", "게임", "영화", "운동" };
										String hobby[] = gBean.getHobby();
										for (int i = 0; i < list.length; i++) {
											out.println(list[i]);
											out.println("<input type=checkbox name=hobby ");
											out.println("value=" + list[i] + " "
											+ (hobby[i].equals("1") ? "checked" : "") + ">");
										}
									%>
								</td>
							</tr>
							<tr>
								<td>직업</td>
								<td><select name=job>
										<option value="0">선택하세요.
										<option value="회사원">회사원
										<option value="연구전문직">연구전문직
										<option value="교수학생">교수학생
										<option value="일반자영업">일반자영업
										<option value="공무원">공무원
										<option value="의료인">의료인
										<option value="법조인">법조인
										<option value="종교,언론,에술인">종교.언론/예술인
										<option value="농,축,수산,광업인">농/축/수산/광업인
										<option value="주부">주부
										<option value="무직">무직
										<option value="기타">기타
								</select>
								<script>document.regFrm.job.value="<%=gBean.getJob()%>"</script>
								</td>
							</tr>

							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료" > &nbsp; &nbsp; 
								<input type="reset" value="다시쓰기"> &nbsp; &nbsp; 
								<input type="button" value="자료삭제" onClick="location.href='h03.jsp?numb=<%=numb%>'"> &nbsp; &nbsp;
								<input type="button" value="신규회원" onClick="location.href='h01.jsp'"> &nbsp; &nbsp;
								<input type="button" value="회원명단" onClick="history.go(-1)"></td>						
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>