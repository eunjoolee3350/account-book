<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="cMgr" class="cash.Mgr_Cash"/>
<jsp:useBean id="mBean" class="cash.Bean_Member"/>
<jsp:setProperty  name="mBean" property="*"/>
<%
	  boolean result = cMgr.insertMember(mBean);
	/*	String right = mBean.getRight();
		String appro = mBean.getAppro();
		String name = mBean.getName();
		String telp = mBean.getTelp();
		String gend = mBean.getGend();
		String birth = mBean.getBirth();
		String email = mBean.getEmail();
		String post = mBean.getPost();
		String addr = mBean.getAddr();
		String hobby[] = mBean.getHobby();
		String job = mBean.getJob();
		System.out.println(right);
		System.out.println(appro);
		System.out.println(name);
		System.out.println(telp);
		System.out.println(gend);
		System.out.println(birth);
		System.out.println(email);
		System.out.println(post);
		System.out.println(addr);
		System.out.println(hobby);
		System.out.println(job);*/
	  if(result) {
%>
<script type="text/javascript">
		alert("회원가입을 하였습니다.");
		location.href="../main/main.jsp";
</script>
<% } else { %>
<script type="text/javascript">
		alert("회원가입에 실패 하였습니다.");
		history.back();
</script>
<% } %>