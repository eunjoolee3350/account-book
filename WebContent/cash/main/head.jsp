<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
	  String usid = (String) session.getAttribute("idKey");
      String cPath = request.getContextPath();
	  String url1 = "../member/h01.jsp";
	  String url2 = "../main/main.jsp";
	  String url3 = "../main/main.jsp";
	  String url4 = "../main/main.jsp";
	  String url5 = "../main/main.jsp";
	  String label = "회원가입";
      if(usid!=null){
        url1 = "../member/h02_m.jsp";
  	    url2 = "../member/h02.jsp?check=N&numb=0";
  	    url3 = "../code/code02.jsp?check=N";
  	    url4 = "../chul/chul02.jsp?check=N";
  	    url5 = "../cost/cost02.jsp?check=N";
        label = "회원수정";
      }
%>
<html>
<head>
<title>head</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<table width="1280" cellpadding="0" cellspacing="0" >
		<tr>
			<td colspan="5">
				<table>
					<tr>
						<td height="0">
						<a href="<%=cPath%>/cash/index.jsp" target="_parent" onFocus="this.blur();">
						<img src="../images/cash_icon.jpg" width="150" border="0"></a>
						</td>
						<td>
						<font size="6" color="black" align="center">&nbsp;&nbsp;&nbsp; 회원 가계부</font>
						</td>						
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td width="250">&nbsp;</td>
			<td><font size="2"><a href="<%=url1%>" target="content"><b><%=label%></b></a></font></td>
			<td><font size="2"><a href="<%=url2%>" target="content"><b>회원관리</b></a></font></td>
			<td><font size="2"><a href="<%=url3%>" target="content"><b>코드관리</b></a></font></td>
			<td><font size="2"><a href="<%=url4%>" target="content"><b>출납내역</b></a></font></td>
			<td><font size="2"><a href="<%=url5%>" target="content"><b>요금계산</b></a></font></td>
		</tr>
	</table>
</body>
</html>