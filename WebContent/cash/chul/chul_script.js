function chul_inputCheck(){
	if(document.chulFrm.nalja.value==""){
		alert("거래일자를 입력해 주세요.");
		document.chulFrm.nalja.focus();
		return;
	}
	if(document.chulFrm.g_suip.value=="" || document.chulFrm.g_gichul.value==""){
		alert("수입 또는 지출의 종류를 선택해 주세요.");
		document.chulFrm.g_suip.focus();
		return;
	}
	if(document.chulFrm.g_cash.value=="" || document.chulFrm.g_card.value==""){
		alert("현금 또는 카드의 종류를 선택해 주세요.");
		document.chulFrm.g_cash.focus();
		return;
	}
	if(document.chulFrm.suip.value=="" || document.chulFrm.gichul.value==""){
		alert("수입액 또는 지출액을 입력해주세요.");
		document.chulFrm.suip.focus();
		return;
	}
	document.chulFrm.action = "chul01_p.jsp";
	document.chulFrm.submit();
}

function win_close(){
	self.close();
}