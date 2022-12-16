<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="cash.Bean_Chul"%>
<%@page import="cash.Bean_Member"%>
<%@page import="java.util.Vector"%>
<%@page import="java.text.DecimalFormat" %>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<%	
	int totalRecord = 0; //전체레코드수
    int listSize = 0;    //현재 읽어온 자료의 수
	Vector<Bean_Chul> vlist = null;
	String usid = (String) session.getAttribute("idKey");
	int numb = 0;
	int imsi = 0;

	DecimalFormat df = new DecimalFormat("###,###.#");
	
    String check = request.getParameter("check");
    	if (check == null) check = "N";
    	
    String keyWord = "", keyField = "";
    if (request.getParameter("keyWord") != null) {
    	keyWord = request.getParameter("keyWord");
    	keyField = request.getParameter("keyField");
    	check = "S";
    }

	Bean_Member bBean = cMgr.getMember2(usid);
	String state = bBean.getState();
	
    totalRecord = cMgr.getChulCount(check, keyWord, keyField, state, usid);
    
    // 잔액계산시작
    	
%>

<html>
<head>
<title>copy</title>
<link href="../member/style.css" rel="stylesheet" type="text/css" >
<script type="text/javascript">
	function chul02_m(numb){
		document.readFrm.numb.value=numb;
		document.readFrm.action="chul02_m.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function chul03(numb){
		document.readFrm.numb.value=numb;
		document.readFrm.action="chul03.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
	
	function check() {
		if (document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.action="chul02.jsp";
		document.searchFrm.target="content";
		document.searchFrm.submit();
	}
</script>

</head>
<body leftmargin="0" topmargin="0" bgcolor="#FFFFCC">

<div align="center">
    <br/>
		<h2>현 금 출 납 내 역</h2>
    <br>
	<table align="center" width="800" border="1">
		<tr>
			<td>출납 거래 내역 자료수 : <%=totalRecord%></td>
		</tr>
	</table>
	<table align="center" width="800" cellpadding="3" border="1">
		<tr>
			<td align="center" colspan="3">
			<%
				vlist = cMgr.getChulList(check, keyWord, keyField, state, usid);
						  listSize = vlist.size();//브라우저 화면에 보여질 자료 레코드 번호
						  if (vlist.isEmpty()) {
							out.println("등록된 자료가 없습니다.");
						  } else {
			%>
				  <table width="100%" cellpadding="2" cellspacing="0" border="1">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>순서</td>
						<td>사용자</td>
						<td>거래일자</td>
						<td>수입종류</td>
						<td>지출종류</td>
						<td>현금종류</td>
						<td>카드종류</td>
						<td>은행종류</td>
						<td>지출내역</td>
						<td>수입액</td>
						<td>지출액</td>
						<td>잔액</td>
						<td>수 정</td>
						<td>삭 제</td>
					</tr>
					<%
						for (int i = 0;i<listSize; i++) {
							if (i == listSize) break;
							Bean_Chul bean = vlist.get(i);
							numb = bean.getNumb();
							usid = bean.getUsid();
							String nalja = bean.getNalja();
							String g_suip = bean.getG_suip();
							String g_gichul = bean.getG_gichul();
							String g_cash = bean.getG_cash();
							String g_card = bean.getG_card();
							String g_bank= bean.getG_bank();
							String gichul_list = bean.getGichul_list();
							
							int suip = bean.getSuip();

							int gichul = bean.getGichul();

							if ( i == 0) {
								imsi = suip - gichul;
								cMgr.updateJan(numb, imsi);
							}
							if ( i != 0) {
								cMgr.updateJan(numb, imsi+suip-gichul);
								imsi = imsi+suip-gichul;
							}
								int jan = imsi;
								cMgr.updateJan(numb, jan);
								String bigo = bean.getBigo();
								
							String suip1 = df.format(suip);
							String gichul1 = df.format(gichul);
							String jan1 = df.format(jan);
													
					%>
					<tr>
						<td align="center">
 						   <a href="javascript:chul02_m('<%=numb%>')" ><%=numb%></a>
						</td>
						<td align="center">
 						   <%=usid%>
						</td>
						<td align="center">
 						   <%=nalja%>
						</td>
						<td align="center">
							<%=g_suip%>
						</td>
						<td align="center">
						   <%=g_gichul%>
						</td>
						<td align="center">
						   <%=g_cash%>
						</td>
<%--   --%>
						<td align="center">
						   <%=g_card%>
						</td>
						<td align="center">
						   <%=g_bank%>
						</td>
						<td align="center">
						<%
							if (gichul_list == null) {
						%>	- 
						<%} else { %> 
							<%=gichul_list%>
						<% } %>
						</td>
						<td align="center">
						   <%=suip1%>원
						</td>
						<td align="center">
						   <%=gichul1%>원
						</td>
						<td align="center">
						   <%=jan1%>원
						</td>
						<td align="center">
						   <a href="javascript:chul02_m('<%=numb%>')">수정</a>
						</td>
						<td align="center">
						   <a href="javascript:chul03('<%=numb%>')">삭제</a>
						</td>
					</tr>
					<%}//for%>
				</table> <%
 			}//if
 		%>
			</td>
		</tr>
		</table>
		
	<form name="searchFrm" method="get" action="chul02.jsp">
	<table width="600" cellpadding="4" cellspacing="0">
		<tr>
			<td align="center" valign="bottom">
				<select name="keyField" size="1">
					<option value="usid"> 사용자 아이디 </option>
					<option value="g_suip"> 수입 종류 </option>
					<option value="g_gichul"> 지출 종류 </option>
					<option value="g_cash"> 현금 종류 </option>
					<option value="g_card"> 카드 종류 </option>
					<option value="g_bank"> 은행 종류 </option>
				</select>
				
				<input size="16" name="keyWord">
				<input type="button" value="검색" onClick="check()">
			</td>
		</tr>
	</table>
	</form>
		
	<form name="readFrm" method="get">
	    <br>
		<input type="button" value="신규출납" onClick="location.href='chul01.jsp'"> &nbsp; &nbsp;
		<input type="button" value="전체자료" onClick="location.href='chul02.jsp?check=N'"> &nbsp; &nbsp;
		<input type="hidden" name="numb"> 
	</form>
</div>
</body>
</html>