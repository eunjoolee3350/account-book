<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="cash.Bean_Code"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<%
	int totalRecord=0; //전체레코드수
    int listSize=0;    //현재 읽어온 게시물의 수
	Vector<Bean_Code> vlist = null;
	String usid = (String) session.getAttribute("idKey");

	  String cPath = request.getContextPath();
	  String url1 = "../member/h01.jsp";
	  String url2 = "../main/main.jsp";
	  String url3 = "../main/main.jsp";
	  String url4 = "../main/main.jsp";
	  String url5 = "../main/main.jsp";
	  String url6 = "../main/main.jsp";
	  String url7 = "../main/main.jsp";
	  String label = "회원가입";
	  
      if(usid!=null){
        url1 = "../member/h02_m.jsp";
  	    url2 = "../member/h02.jsp?check=N&numb=0";
  	    url3 = "../member/h02.jsp?check=J&numb=0";
  	    url4 = "../member/h02.jsp?check=Y&numb=0";
  	    url5 = "../code/code02.jsp?check=N";
  	    url6 = "../chul/chul02.jsp?check=N";
  	    url7 = "../cost/cost02.jsp?check=N";
        label = "회원수정";
      }
%>

<html>
<head>
<title>copy</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" bgcolor="#D9E5FF">
<jsp:include page="../login/login.jsp"/>
<hr>
<div align="center">
    <br>
	<font size="3"><a href="<%=url1%>" target="content"><b><%=label%></b></a></font><br><br><br>

    <font size="4" color = blue><b>회원관리</b></font><br>
		<font size="2"><a href="<%=url2%>" target="content"><b>전체회원</b></a></font><br>
		<font size="2"><a href="<%=url3%>" target="content"><b>승인회원</b></a></font><br>
		<font size="2"><a href="<%=url4%>" target="content"><b>미승인회원</b></a></font><br><br>
	<font size="4" color = blue> <a href="<%=url5%>" target="content"><b>코드관리</b></a></font><br><br>
	<font size="4" color = blue><a href="<%=url6%>" target="content"><b>출납내역</b></a></font><br><br>
	<font size="4" color = blue><a href="<%=url7%>" target="content"><b>요금계산</b></a></font><br><br>
</div>

</body>
</html>