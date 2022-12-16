function cost_inputCheck(){
	if(document.costFrm.g_cost.value==""){
		alert("요금 종류를 선택해 주세요.");
		document.costFrm.g_cost.focus();
		return;
	}
	if(document.costFrm.yt.value==""){
		alert("이번달 계량값을 입력해주세요.");
		document.costFrm.yt.focus();
		return;
	}
	document.costFrm.action = "cost01_p.jsp";
	document.costFrm.submit();
}

function win_close(){
	self.close();
}