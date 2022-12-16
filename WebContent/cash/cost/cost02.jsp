<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="cash.Bean_Cost"%>
<%@page import="cash.Bean_Member"%>
<%@page import="java.util.Vector"%>
<%@page import="java.text.DecimalFormat" %>
<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<%	
	String usid = (String) session.getAttribute("idKey");
	int totalRecord = 0; //전체레코드수
    int listSize = 0;    //현재 읽어온 자료의 수
    int numb = 0;
    double totalgum = 0;
    double gibonyo = 0;
	Vector<Bean_Cost> vlist = null;
	Bean_Cost cBean = cMgr.getCost(usid);

	Bean_Member bBean = cMgr.getMember2(usid);
	String state = bBean.getState();
	
    String check = request.getParameter("check");
    	if (check == null) check = "N";
    	
    String keyWord = "", keyField = "";
    if (request.getParameter("keyWord") != null) {
    	keyWord = request.getParameter("keyWord");
    	keyField = request.getParameter("keyField");
    	check = "S";
    }
    
	DecimalFormat df = new DecimalFormat("###,###.#");
	
    // 요금계산 시작
    vlist = cMgr.getCostList(check, keyWord, keyField, state, usid);
    listSize = vlist.size();
    for ( int i = 0; i < listSize; i++) {
    	Bean_Cost bean = vlist.get(i);
    	usid = bean.getUsid();
    	numb = bean.getNumb();
    	String g_cost = bean.getG_cost();
    	int yt_1 = bean.getYt_1();
    	int yt = bean.getYt();
    
    // 총 사용량 계산
	    int total1 = yt - yt_1;	// 계산에 사용
    	int total = yt - yt_1;	// 업데이트할때만 사용
    	totalgum = 0;
    	
    // 사용 금액 계산
   		if (g_cost.equals("전기")) {
		    double gibon[] = {390, 390, 850, 1500, 3590, 6750, 11980};
		   	int sakwh[] = {50,50,100,100,100,100,200};
   			double kwh[] = {34.5, 81.7, 122.9, 177.7 , 308, 405.7, 639.4};
    		double gum[] = {0,0,0,0,0,0,0,0,0,0,0};
//    		System.out.println("총 사용량" + total1);
    		for ( int j = 0; j < 7; j++) {
    			if ( total1 < 0) {
    				gum[j] = 0;
    				total1 = 0;
    			} else if (j == 6) { 
					gum[j] = total1 * kwh[j];
    				gibonyo = gibon[j];
    			} else if ( total1 > sakwh[j] ) {
    				gum[j] = sakwh[j] * kwh[j];
//    				System.out.println("금액" + gum[j]);
				} else {
    				gum[j] = total1 * kwh[j];
//    				System.out.println("금액" + gum[j]);
//    				System.out.println("기본요금" + gibonyo);
    			}
    			total1 = total1 - sakwh[j];
//    			System.out.println("남은 총 사용량" + total1);
    			totalgum = totalgum + gum[j];
    		}
    		
    		for (int j = 0; j < 7; j++) {	// 사용 요금 합계
    			gum[7] = gum[7] + gum[j];
    		}
//    		System.out.println("사용요금 합계" + gum[7]);
//    		System.out.println("기본요금" + gibonyo);
    		gum[8] = gibonyo + Math.round(gum[7]);
//    		System.out.println("전기요금 합계(원미만 4사5입)" + gum[8]);
    		gum[9] = Math.round((gum[8] - Math.round(gum[8] * 0.0323 / 1.0323)) / 10); // 10원미만 절사
//    		System.out.println("부가가치세(원미만 4사 5입)" + gum[9]);
    		gum [10] = Math.floor((gum[8] + gum[9]) / 10) * 10;
//    		System.out.println("청구금액(10원미만 절사)" + gum[10]);
    		
    		// 총 사용량, 금액 등 update
    		cMgr.updateCGum(numb, total, gum[8], gum[9], gum[10]);
    		
	    } else if (g_cost.equals("수도")) {
	    	int sudo[] = {720,960,1250};
	    	int sasudo[] = {20,30,500};
	    	double sudogum[] = {0,0,0,0};
	    	for (int j = 0; j < 3; j++) {
	    		if (total1 < 0) {
	    			sudogum[j] = 0;
	    			total1 = 0;
    			} else if (j == 2) { 
					sudogum[j] = total1 * sudo[j];
	    		} else if (total1 > sasudo[j]) {
	    			sudogum[j] = sasudo[j] * sudo[j];
	    		} else {
	    			sudogum[j] = total1 * sudo[j];
	    		}
	    		total1 = total1 - sasudo[j];
	    	}
	    	for (int j = 0; j < 3; j++) {
	    		sudogum[3] = sudogum[3] + sudogum[j];
	    	}
    		cMgr.updateCGum(numb, total, sudogum[3], 0, sudogum[3]);
	    } else if (g_cost.equals("가스")) {
	    	int gasgum = total * 900;
    		cMgr.updateCGum(numb, total, gasgum, 0, gasgum);
	    }
    }
    totalRecord = cMgr.getCostCount(check, keyWord, keyField, state, usid);
%>

<html>
<head>
<title>copy</title>
<link href="../member/style.css" rel="stylesheet" type="text/css" >
<script type="text/javascript">
	function yogum02(g_cost, total) {
		url = "yogum02.jsp?g_cost=" + g_cost + "&total=" + total;
		window.open(url, "yogum02","width=600,height=800,scrollbars=yes");
	}
	
	function cost02_m(numb){
		document.readFrm.numb.value=numb;
		document.readFrm.action="cost02_m.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function cost03(numb){
		document.readFrm.numb.value=numb;
		document.readFrm.action="cost03.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
	
	function check() {
		if (document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.action="cost02.jsp";
		document.searchFrm.target="content";
		document.searchFrm.submit();
	}
</script>

</head>
<body leftmargin="0" topmargin="0" bgcolor="#FFFFCC">

<div align="center">
    <br/>
		<h2>요 금 계 산 내 역</h2>
    <br>
	<table align="center" width="800" border="1">
		<tr>
			<td>요금 거래 내역 자료수 : <%=totalRecord%></td>
		</tr>
	</table>
	<table align="center" width="800" cellpadding="3" border="1">
		<tr>
			<td align="center" colspan="3">
			<%
				vlist = cMgr.getCostList(check, keyWord, keyField, state, usid);
						  listSize = vlist.size();//브라우저 화면에 보여질 자료 레코드 번호
						  if (vlist.isEmpty()) {
							out.println("등록된 자료가 없습니다.");
						  } else {
			%>
				  <table width="100%" cellpadding="2" cellspacing="0" border="1">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>순서</td>
						<td>사용자</td>
						<td>요금종류</td>
						<td>전달계량값</td>
						<td>이번달계량값</td>
						<td>총 사용량</td>
						<td>사용금액</td>
						<td>부가가치세</td>
						<td>납부금액</td>
						<td>계산내역</td>
						<td>수 정</td>
						<td>삭 제</td>
					</tr>
					<%
						for (int i = 0;i<listSize; i++) {
							if (i == listSize) break;
							Bean_Cost bean = vlist.get(i);
							numb = bean.getNumb();
							usid = bean.getUsid();
							String g_cost = bean.getG_cost();
							int yt_1 = bean.getYt_1();
							int yt = bean.getYt();
							int total = bean.getTotal();
							double gum = bean.getGum();
							int vat = bean.getVat();
							int nabbu = bean.getNabbu();
							String gum1 = df.format(gum);
							String vat1 = df.format(vat);
							String nabbu1 = df.format(nabbu);
							String yt_11 = df.format(yt_1);
							String yt1 = df.format(yt);
							String total1 = df.format(total);
					%>
					
					<%/*
				    
				   	if (g_cost.equals("전기")) {
				   		for (int i=0; i<7; i++) {
				   			if (total < sakwh[i]) {
				   				gibonyo = gibon[i];
				   				sayo = (total-sakwh[0])*kwh[0];
				   				sayo2 = 
				   			}
				   		}
				   	}
					*/%>
					<tr>
						<td align="center">
 						   <a href="javascript:cost02_m('<%=numb%>')" ><%=numb%></a>
						</td>
						<td align="center">
 						   <%=usid%>
						</td>
						<td align="center">
 						   <%=g_cost%>
						</td>
						<td align="center">
							<%=yt_11%>
						</td>
						<td align="center">
						   <%=yt1%>
						</td>
						<td align="center">
						<% 
							if (g_cost.equals("전기")) {
						%> <%=total1%>kWh <%
						} else if (g_cost.equals("수도")) {
						%> <%=total1%>톤 <%
						} else {
						%> <%=total1%>m3<%
						}%>
						</td>
<%--   --%>
						<td align="center">
						   <%=gum1%>원
						</td>
						<td align="center">
						   <%=vat1%>원
						</td>
			<%--			<td align="center">
			 			<%
							if (gichul_list == null) {
						%>	- 
						<%} else { %> <%=gichul_list%>
						<% } %>     
						</td>  --%>
						<td align="center">
						   <%=nabbu1%>원
						</td>
						<td align="center">
						   <a href="javascript:yogum02('<%=g_cost%>','<%=total%>')">계산내역</a>
						</td>
						<td align="center">
						   <a href="javascript:cost02_m('<%=numb%>')">수정</a>
						</td>
						<td align="center">
						   <a href="javascript:cost03('<%=numb%>')">삭제</a>
						</td>
					</tr>
					<%}//for%>
				</table> <%
 			}//if
 		%>
			</td>
		</tr>
		</table>
		
	<form name="searchFrm" method="get" action="cost02.jsp">
	<table width="600" cellpadding="4" cellspacing="0">
		<tr>
			<td align="center" valign="bottom">
				<select name="keyField" size="1">
					<option value="usid"> 사용자 아이디 </option>
					<option value="g_cost"> 요금 종류 </option>
				</select>
				
				<input size="16" name="keyWord">
				<input type="button" value="검색" onClick="check()">
			</td>
		</tr>
	</table>
	</form>
		
	<form name="readFrm" method="get">
	    <br>
		<input type="button" value="신규자료" onClick="location.href='cost01.jsp'"> &nbsp; &nbsp;
		<input type="button" value="전체자료" onClick="location.href='cost02.jsp?check=N'"> &nbsp; &nbsp;
		<input type="hidden" name="numb"> 
	</form>
</div>
</body>
</html>