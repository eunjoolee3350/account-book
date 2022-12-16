<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="cash.Bean_Code"%>
<jsp:useBean id="cBean" class="cash.Bean_Code"/>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>

<%	
    int totalRecord = 0; //전체레코드수
    int listSize = 0;    //현재 읽어온 자료의 수
    Vector<Bean_Code> vlist = null;
    String usid = (String) session.getAttribute("idKey");
    String check = request.getParameter("check");
    	if (check == null) check = "N";
    
    String keyWord = "", keyField = "";
    if (request.getParameter("keyWord") != null) {
    	keyWord = request.getParameter("keyWord");
    	keyField = request.getParameter("keyField");
    	check = "S";
    }
    
    totalRecord = cMgr.getCodelistCount(check, keyWord, keyField);
%>

<html>
<head>
<title>copy</title>
<link href="../member/style.css" rel="stylesheet" type="text/css" >
<script type="text/javascript">
	function code02_m(numb){
		document.codeFrm.numb.value=numb;
		document.codeFrm.action="code02_m.jsp";
		document.codeFrm.target="content";
		document.codeFrm.submit();
	}

	function code03(numb){
		document.codeFrm.numb.value=numb;
		document.codeFrm.action="code03.jsp";
		document.codeFrm.target="content";
		document.codeFrm.submit();
	}
	
	function check() {
	     if (document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
	     }
	  document.searchFrm.action="code02.jsp";
	  document.searchFrm.target="content";
	  document.searchFrm.submit();
	 }
</script>

</head>
<body leftmargin="0" topmargin="0" bgcolor="#FFFFCC">

<div align="center">
	
    <br/>
		<h2>코 드 목 록</h2>
    <br>
	<table align="center" width="700" border="1">
		<tr>
			<td>코드 수 : <%=totalRecord%></td>
		</tr>
	</table>
	<table align="center" width="700" cellpadding="3" border="1">
		<tr>
			<td align="center" colspan="3">
			<%
					vlist = cMgr.getCodelist(check, keyWord, keyField);
					listSize = vlist.size();           //브라우저 화면에 보여질 자료 수
						if (vlist.isEmpty()) {
						out.println("등록된 자료가 없습니다.");
				 } else {
			%>
				  <table width="100%" cellpadding="2" cellspacing="0" border="1">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>순번</td>
						<td>사용자 아이디</td>
						<td>Code</td>
						<td>세부 내용</td>
						<td>수 정</td>
						<td>삭 제</td>
					</tr>
					<%
						  for (int i = 0;i<listSize; i++) {
							if (i == listSize) break; 
							Bean_Code bean = vlist.get(i);
							//MemberBean mbean = bookMgr.getMember(usid);
							int numb = bean.getNumb();
							usid = bean.getUsid();
							String code = bean.getCode();
							String gubun = bean.getGubun();
							
					%>
					<tr>
						<td align="center">
							<%=numb%>
						</td>
						<td align="center">
 						   <a href="javascript:code02_m('<%=numb%>')" ><%=usid%></a>
						</td>
						<td align="center">
						   <%=code%>
						</td>
						<td align="center">
						   <%=gubun%>
						</td>
						<td align="center">
						   <a href="javascript:code02_m('<%=numb%>')">수정</a>
						</td>
						<td align="center">
						   <a href="javascript:code03('<%=numb%>')">삭제</a>
						</td>
					</tr>
					<%}//for%>
				</table> <%
 			}//if
 		%>
			</td>
		</tr>
		</table>
	<form name="searchFrm" method="get" action="code02.jsp">
	<table width="600" cellpadding="4" cellspacing="0">
		<tr>
			<td align="center" valign="bottom">
				<select name="keyField" size="1">
					<option value="usid"> 사용자 아이디 </option>
					<option value="code"> 코드 </option>
					<option value="gubun"> 세부 내용 </option>
				</select>
				
				<input size="16" name="keyWord">
				<input type="button" value="코드찾기" onClick="check()">
			</td>
		</tr>
	</table>
	</form>
		
	<form name="codeFrm" method="get">
	    <br>
		<input type="button" value="신규코드등록" onClick="location.href='code01.jsp'"> &nbsp; &nbsp;
		<input type="button" value="전체코드" onClick="location.href='code02.jsp?check=N'"> &nbsp; &nbsp;
		<input type="hidden" name="numb"> 
	</form>
</div>
</body>
</html>