<%@ page contentType="text/html; charset=EUC-KR" %>
<%@page import="cash.Bean_Cost"%>
<%@page import="java.text.DecimalFormat" %>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash" />
<%
	String usid = request.getParameter("usid");
	String g_cost = request.getParameter("g_cost");
	int total1 = Integer.parseInt(request.getParameter("total"));
	int total = Integer.parseInt(request.getParameter("total"));
%>
<html>
<head>
<title>��� Ȯ��</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div align="Left">
	<%
		// ��� �ݾ� ��� ����
		double gibonyo = 0;
		double totalgum = 0;
		
		DecimalFormat df = new DecimalFormat("###,###.#");
		
		if (g_cost.equals("����")) {
			out.println("<H1>" + g_cost + " : " + total + " kWh ���</H1><p>");
		    double gibon[] = {390, 390, 850, 1500, 3590, 6750, 11980};
		   	int sakwh[] = {50,50,100,100,100,100,200};
   			double kwh[] = {34.5, 81.7, 122.9, 177.7 , 308, 405.7, 639.4};
    		double gum[] = {0,0,0,0,0,0,0,0,0,0,0};
    		for (int j = 0; j < 7; j++) {
    			if ( total1 < 0) {
    				gum[j] = 0;
    				total1 = 0;
    				gum[j] = total1 * kwh[j];
    				String money_j = df.format(gum[j]);
    				out.println("<font color='green'>" + (j+1) + "�ܰ� </font>: " 
    				+ sakwh[j] + "kWh X " + kwh[j] + " = " + money_j + "��<p>");
   				} else if (j == 6) {
    				gum[j] = total1 * kwh[j];
					String money_j = df.format(gum[j]);
    				gibonyo = gibon[j];
					out.println("<font color='green'>" + (j+1) + "�ܰ� </font>: " 
    				+ total1 + "kWh X " + kwh[j] + " = " + money_j + "��<p>");
   				} else if (total1 > sakwh[j]) {
    				gum[j] = sakwh[j] * kwh[j];
    				String money_j = df.format(gum[j]);
    				out.println("<font color='green'>" + (j+1) + "�ܰ� </font>: " 
    				+ sakwh[j] + "kWh X " + kwh[j] + " = " + money_j + "��<p>");
    			} else {
    				gum[j] = total1 * kwh[j];
    				String money_j = df.format(gum[j]);
    				out.println("<font color='green'>" + (j+1) + "�ܰ� </font>: " 
    				+ total1 + "kWh X " + kwh[j] + " = " + money_j + "��<p>");
    			}
    			total1 = total1 - sakwh[j];
    			totalgum = totalgum + gum[j];
    		}
			String money_g = df.format(gibonyo);
    		String money_t = df.format(totalgum);
    		for (int j = 0; j < 7; j++) {	// ��� ��� �հ�
    			gum[7] = gum[7] + gum[j];
    		}
    		gum[8] = gibonyo + Math.round(gum[7]);
			String money_8 = df.format(gum[8]);
			out.println("<br><br><b><font color='blue'>�⺻���</font></b> : " + money_g + "��<p>");
    		out.println("<b><font color='blue'>������ �հ�</font>(���̸� 4�� 5��)</b> : " + money_g + "�� + " + money_t + "�� = " + money_8 + "��<p>");
    		
    		gum[9] = Math.round((gum[8] - Math.round(gum[8] * 0.0323 / 1.0323)) / 10); // 10���̸� ����
			String money_9 = df.format(gum[9]);
    		out.println("<b><font color='blue'>�ΰ���ġ��</font>(���̸� 4�� 5��)</b> : <p>");
    		out.println("["+ money_8 + "�� - (" + money_8 + "�� X 0.0323 / 1.0323(10���̸�����)] X 0.1 = " + money_9 + "��<p>");
    		
    		gum [10] = Math.floor((gum[8] + gum[9]) / 10) * 10;
    		String money_10 = df.format(gum[10]);
    		out.println("<b><font color='red'>û���ݾ�</font>(10���̸� ����)</b> : " + money_8 + "�� + " + money_9 + "�� = <b>" + money_10 + "��</b><p>");
		
		
		} else if (g_cost.equals("����")) {
			out.println("<H1>" + g_cost + " : " + total + " �� ���</H1><p>");
	    	int sudo[] = {720,960,1250};
	    	int sasudo[] = {20,30,500};
	    	double sudogum[] = {0,0,0,0};
	    	for (int j = 0; j < 3; j++) {
	    		if (total1 < 0) {
	    			sudogum[j] = 0;
	    			total1 = 0;
    				String money_j = df.format(sudogum[j]);
	    			out.println((j+1) + "�ܰ� : " + sasudo[j] + "�� X " + sudo[j] + " = " + money_j + "��<p>");
	    		} else if (j == 2) {
    				sudogum[j] = total1 * sudo[j];
					String money_j = df.format(sudogum[j]);
					out.println((j+1) + "�ܰ� : " + total1 + "�� X " + sudo[j] + " = " + money_j + "��<p>");
	    		} else if (total1 > sasudo[j]) {
	    			sudogum[j] = sasudo[j] * sudo[j];
    				String money_j = df.format(sudogum[j]);
    				out.println((j+1) + "�ܰ� : " + sasudo[j] + "�� X " + sudo[j] + " = " + money_j + "��<p>");
	    		} else {
	    			sudogum[j] = total1 * sudo[j];
    				String money_j = df.format(sudogum[j]);
    				out.println((j+1) + "�ܰ� : " + total1 + "�� X " + sudo[j] + " = " + money_j + "��<p>");
	    		}
	    		total1 = total1 - sasudo[j];
	    	}
	    	for (int j = 0; j < 3; j++) {
	    		sudogum[3] = sudogum[3] + sudogum[j];
	    	}
    		String money_t = df.format(sudogum[3]);
    		out.println("������� : " + money_t + "��<p>");
	    	
		} else if (g_cost.equals("����")) {
			out.println("<H1>" + g_cost + " : " + total + " m3 ���</H1><p>");
	    	int gasgum = total * 900;
	    	out.println("�������: " + total + "m3 X " + "900" + " = " + gasgum + "��<p>");
		}
	%>
		

		<br><br><a href="#" onClick="self.close()">�ݱ�</a>
	</div>
</body>
</html>