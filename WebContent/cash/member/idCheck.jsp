<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash" />
<%
	String usid = request.getParameter("usid");
	boolean result = cMgr.checkId(usid);
%>
<html>
<head>
<title>ID �ߺ�üũ</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br /> <b><%=usid%></b>
		<%
			if (result) {
				out.println("�� �̹� �����ϴ� ID�Դϴ�.<p>");
			} else {
				out.println("�� ��� ���� �մϴ�.<p>");
			}
		%>
		<a href="#" onClick="self.close()">�ݱ�</a>
	</div>
</body>
</html>