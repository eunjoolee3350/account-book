package cash;

public class Bean_Member {

	private int    numb;	// 순번
	private String usid;	// 아이디
	private String uspw;	// 패스워드
	private String state;	// 권한
	private String appro;	// 승인여부
	private String name;	// 이름
	private String telp;	// 연락처
	private String gend;	// 성별
	private String birth;	// 생년월일
	private String email;	// 이메일
	private String post;	// 우편번호
	private String addr;	// 주소
	private String hobby[];	// 위미
	private String job;		// 직업
	

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

	public String getUspw() {
		return uspw;
	}

	public void setUspw(String uspw) {
		this.uspw = uspw;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getAppro() {
		return appro;
	}

	public void setAppro(String appro) {
		this.appro = appro;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTelp() {
		return telp;
	}

	public void setTelp(String telp) {
		this.telp = telp;
	}

	public String getGend() {
		return gend;
	}

	public void setGend(String gend) {
		this.gend = gend;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String[] getHobby() {
		return hobby;
	}

	public void setHobby(String[] hobby) {
		this.hobby = hobby;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}	
}