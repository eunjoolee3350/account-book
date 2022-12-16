function code_inputCheck(){
	if(document.codeFrm.code.value==""){
		alert("코드를 입력해 주세요.");
		document.codeFrm.code.focus();
		return;
	}
	if(document.codeFrm.gubun.value==""){
		alert("세부 내용을 입력해 주세요.");
		document.codeFrm.code.focus();
		return;
	}
	document.codeFrm.action = "code01_p.jsp";
	document.codeFrm.submit();
}

function win_close(){
	self.close();
}