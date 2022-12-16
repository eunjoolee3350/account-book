package cash;

public class Bean_Code {

	private int    numb;	// 순번
	private String usid;	// 아이디
	private String code;	// 코드
	private String gubun;	// 코드 내용(구분)
	
	public String getGubun() {
		return gubun;
	}
	
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	

	public int getNumb() {
		return numb;
	}

	public void setNumb(int numb) {
		this.numb = numb;
	}

	public String getUsid() {
		return usid;
	}

	public void setUsid(String usid) {
		this.usid = usid;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}